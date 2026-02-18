import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/ui/core/app_snack_bar.dart';
import 'package:mobile/ui/nadeuri/plan/plan_view_model.dart';
import 'package:mobile/ui/nadeuri/select_place/select_place.dart';
import 'package:mobile/ui/nadeuri/select_place/select_place_view_model.dart';
import 'package:mobile/utils/result.dart';
import 'package:provider/provider.dart';

class PlanPage extends StatefulWidget {
  final PlanViewModel _planViewModel;

  const PlanPage({super.key, required PlanViewModel planViewModel}) : _planViewModel = planViewModel;

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final TextEditingController planTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    planTitleController.text = widget._planViewModel.plan.title;

    widget._planViewModel.command.addListener(_onCommand);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListenableBuilder(
              listenable: widget._planViewModel.command,
              builder: (context, child) => AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: widget._planViewModel.command.running
                    ? SizedBox(
                        width: 80,
                        child: Center(child: CircularProgressIndicator(key: const ValueKey("saving"))),
                      )
                    : SizedBox(
                        width: 80,
                        child: OutlinedButton(
                          key: const ValueKey("save"),
                          onPressed: () {
                            widget._planViewModel.command.execute();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                          child: Text("저장"),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            TextField(
              controller: planTitleController,
              decoration: InputDecoration(hintText: "일정 제목", helperText: "장소를 추가하면 장소 이름이 입력됩니다."),
              maxLength: 100,
              onTapOutside: (event) => widget._planViewModel.updateTitle(planTitleController.text),
            ),
            Divider(height: 32.0),
            _DateTimeSection(planViewModel: widget._planViewModel),
            Divider(height: 32.0),
            Stack(
              alignment: AlignmentGeometry.centerLeft,
              children: [
                Icon(Icons.location_on_outlined, color: Colors.blue),
                Align(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectPlacePage(selectPlaceViewModel: SelectPlaceViewModel()),
                        ),
                      );
                    },
                    child: Text("장소추가"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget._planViewModel.command.removeListener(_onCommand);

    super.dispose();
  }

  /// 추가/갱신 성공 시 이전 화면으로 이동
  /// 인증 문제 시 로그인 페이지로 이동
  /// 리소스 조회 실패 시 상위 페이지로 이동
  /// 그 외 문제 시 스낵바 표시
  void _onCommand() {
    if (widget._planViewModel.command.completed) {
      widget._planViewModel.command.clearResult();
      Navigator.pop(context);
      return;
    }

    if (widget._planViewModel.command.error) {
      final Error result = widget._planViewModel.command.result! as Error;
      final Exception error = result.error;
      widget._planViewModel.command.clearResult();

      if (error is Unauthorized || error is TokenNotFound) {
        context.read<AppSnackBar>().showSnackBar("세션이 만료되었습니다.\n다시 로그인해주세요!");
        Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
        return;
      }

      if (error is NotFound) {
        if (error.resource == "NADEURI") {
          context.read<AppSnackBar>().showSnackBar("해당하는 나들이가 존재하지 않습니다.");
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          return;
        }

        if (error.resource == "PLAN") {
          context.read<AppSnackBar>().showSnackBar("해당하는 일정이 존재하지 않습니다.");
          Navigator.pop(context);
          return;
        }
      }

      context.read<AppSnackBar>().showSnackBar("문제가 발생했습니다!\n나중에 다시 시도해보세요.");
    }
  }
}

class _DateTimeSection extends StatelessWidget {
  final PlanViewModel _planViewModel;

  const _DateTimeSection({super.key, required PlanViewModel planViewModel}) : _planViewModel = planViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue),
            Spacer(),
            Text("시간 미정 "),
            ListenableBuilder(
              listenable: _planViewModel,
              builder: (context, child) {
                return Switch(
                  value: _planViewModel.plan.allDay,
                  onChanged: (value) {
                    _planViewModel.updateAllDay(value);
                  },
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _planViewModel.plan.startAt,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (newDate == null) {
                    return;
                  }

                  _planViewModel.updateStartAt(
                    newDate.copyWith(
                      hour: _planViewModel.plan.startAt.hour,
                      minute: _planViewModel.plan.startAt.minute,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListenableBuilder(
                    listenable: _planViewModel,
                    builder: (context, child) => Text(DateFormat("yyyy년 MM월 dd일").format(_planViewModel.plan.startAt)),
                  ),
                ),
              ),
            ),
            ListenableBuilder(
              listenable: _planViewModel,
              builder: (context, child) {
                return Visibility(
                  visible: !_planViewModel.plan.allDay,
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: _planViewModel.plan.startAt.hour,
                          minute: _planViewModel.plan.startAt.minute,
                        ),
                      );
                      if (newTime == null) {
                        return;
                      }

                      _planViewModel.updateStartAt(
                        _planViewModel.plan.startAt.copyWith(hour: newTime.hour, minute: newTime.minute),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListenableBuilder(
                        listenable: _planViewModel,
                        builder: (context, child) => Text(DateFormat("h:mm aaa").format(_planViewModel.plan.startAt)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Icon(Icons.keyboard_arrow_down),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _planViewModel.plan.endAt,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (newDate == null) {
                    return;
                  }

                  _planViewModel.updateEndAt(
                    newDate.copyWith(hour: _planViewModel.plan.endAt.hour, minute: _planViewModel.plan.endAt.minute),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListenableBuilder(
                    listenable: _planViewModel,
                    builder: (context, child) => Text(DateFormat("yyyy년 MM월 dd일").format(_planViewModel.plan.endAt)),
                  ),
                ),
              ),
            ),
            ListenableBuilder(
              listenable: _planViewModel,
              builder: (context, child) {
                return Visibility(
                  visible: !_planViewModel.plan.allDay,
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: _planViewModel.plan.endAt.hour,
                          minute: _planViewModel.plan.endAt.minute,
                        ),
                      );
                      if (newTime == null) {
                        return;
                      }

                      _planViewModel.updateEndAt(
                        _planViewModel.plan.endAt.copyWith(hour: newTime.hour, minute: newTime.minute),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListenableBuilder(
                        listenable: _planViewModel,
                        builder: (context, child) => Text(DateFormat("h:mm aaa").format(_planViewModel.plan.endAt)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
