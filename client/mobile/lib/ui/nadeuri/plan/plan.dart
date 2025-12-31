import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/ui/nadeuri/plan/plan_view_model.dart';

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

    planTitleController.text = widget._planViewModel.plan.planTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
              child: Text("저장"),
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
            ),
            Divider(height: 32.0),
            _DateTimeSection(planViewModel: widget._planViewModel),
            Divider(height: 32.0),
            Stack(
              alignment: AlignmentGeometry.centerLeft,
              children: [
                Icon(Icons.location_on_outlined, color: Colors.blue),
                Align(
                  child: TextButton(onPressed: () {}, child: Text("장소추가")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTimeSection extends StatefulWidget {
  final PlanViewModel _planViewModel;

  const _DateTimeSection({super.key, required PlanViewModel planViewModel}) : _planViewModel = planViewModel;

  @override
  State<_DateTimeSection> createState() => _DateTimeSectionState();
}

class _DateTimeSectionState extends State<_DateTimeSection> {
  bool _dateOnly = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue),
            Spacer(),
            Text("시간 미정 "),
            Switch(
              value: _dateOnly,
              onChanged: (value) {
                setState(() {
                  _dateOnly = value;
                });
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
                    initialDate: widget._planViewModel.plan.startAt,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (newDate == null) {
                    return;
                  }

                  widget._planViewModel.updateStartAt(
                    newDate.copyWith(
                      hour: widget._planViewModel.plan.startAt.hour,
                      minute: widget._planViewModel.plan.startAt.minute,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListenableBuilder(
                    listenable: widget._planViewModel,
                    builder: (context, child) =>
                        Text(DateFormat("yyyy년 MM월 dd일").format(widget._planViewModel.plan.startAt)),
                  ),
                ),
              ),
            ),
            if (!_dateOnly)
              InkWell(
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: widget._planViewModel.plan.startAt.hour,
                      minute: widget._planViewModel.plan.startAt.minute,
                    ),
                  );
                  if (newTime == null) {
                    return;
                  }

                  widget._planViewModel.updateStartAt(
                    widget._planViewModel.plan.startAt.copyWith(hour: newTime.hour, minute: newTime.minute),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListenableBuilder(
                    listenable: widget._planViewModel,
                    builder: (context, child) =>
                        Text(DateFormat("h:mm aaa").format(widget._planViewModel.plan.startAt)),
                  ),
                ),
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
                    initialDate: widget._planViewModel.plan.endAt,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (newDate == null) {
                    return;
                  }

                  widget._planViewModel.updateEndAt(
                    newDate.copyWith(
                      hour: widget._planViewModel.plan.endAt.hour,
                      minute: widget._planViewModel.plan.endAt.minute,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListenableBuilder(
                    listenable: widget._planViewModel,
                    builder: (context, child) =>
                        Text(DateFormat("yyyy년 MM월 dd일").format(widget._planViewModel.plan.endAt)),
                  ),
                ),
              ),
            ),
            if (!_dateOnly)
              InkWell(
                onTap: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: widget._planViewModel.plan.endAt.hour,
                      minute: widget._planViewModel.plan.endAt.minute,
                    ),
                  );
                  if (newTime == null) {
                    return;
                  }

                  widget._planViewModel.updateEndAt(
                    widget._planViewModel.plan.endAt.copyWith(hour: newTime.hour, minute: newTime.minute),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListenableBuilder(
                    listenable: widget._planViewModel,
                    builder: (context, child) => Text(DateFormat("h:mm aaa").format(widget._planViewModel.plan.endAt)),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
