import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/repository/nadeuri_repository.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/domain/model/plan/plan.dart';
import 'package:mobile/ui/core/app_snack_bar.dart';
import 'package:mobile/ui/nadeuri/details/nadeuri_details_view_model.dart';
import 'package:mobile/ui/nadeuri/plan/plan.dart';
import 'package:mobile/ui/nadeuri/plan/plan_view_model.dart';
import 'package:mobile/utils/result.dart';
import 'package:provider/provider.dart';

final DateFormat timeFormat = DateFormat("h:mm aaa");
final DateFormat monthDayFormat = DateFormat("MM월 dd일");
final DateFormat yearMonthDayFormat = DateFormat("yyyy년 MM월 dd일");

class NadeuriDetailsPage extends StatefulWidget {
  final NadeuriDetailsViewModel _nadeuriDetailsViewModel;

  const NadeuriDetailsPage({super.key, required NadeuriDetailsViewModel nadeuriDetailsViewModel})
    : _nadeuriDetailsViewModel = nadeuriDetailsViewModel;

  @override
  State<NadeuriDetailsPage> createState() => _NadeuriDetailsPageState();
}

class _NadeuriDetailsPageState extends State<NadeuriDetailsPage> with RouteAware {
  late final RouteObserver<ModalRoute<void>> _routeObserver;

  @override
  void initState() {
    super.initState();

    _routeObserver = context.read<RouteObserver<ModalRoute<void>>>();

    widget._nadeuriDetailsViewModel.load.addListener(_onLoad);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(height: 32.0),
            _NadeuriTitleSection(nadeuriDetailsViewModel: widget._nadeuriDetailsViewModel),
            Divider(height: 32.0),
            _ChatSection(),
            Divider(height: 32.0),
            _PlanSection(nadeuriDetailsViewModel: widget._nadeuriDetailsViewModel),
            Divider(height: 32.0),
            _PhotoSection(),
            Divider(height: 32.0),
            _SettlementSection(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget._nadeuriDetailsViewModel.load.removeListener(_onLoad);

    _routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    widget._nadeuriDetailsViewModel.load.execute();
  }

  /// 인증에 문제가 있으면 로그인 페이지로 이동
  /// Nadeuri 조회 실패 시 홈 화면으로 이동
  void _onLoad() {
    if (widget._nadeuriDetailsViewModel.load.error && mounted) {
      final Error result = widget._nadeuriDetailsViewModel.load.result! as Error;
      final Exception error = result.error;

      if (error is Unauthorized || error is TokenNotFound) {
        widget._nadeuriDetailsViewModel.load.clearResult();
        context.read<AppSnackBar>().showSnackBar("세션이 만료되었습니다.\n다시 로그인해주세요!");
        Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
        return;
      }

      if (error is NotFound) {
        widget._nadeuriDetailsViewModel.load.clearResult();
        context.read<AppSnackBar>().showSnackBar("나들이 정보가 없습니다.");
        Navigator.pop(context);
        return;
      }
    }
  }
}

class _NadeuriTitleSection extends StatefulWidget {
  final NadeuriDetailsViewModel _nadeuriDetailsViewModel;

  const _NadeuriTitleSection({super.key, required NadeuriDetailsViewModel nadeuriDetailsViewModel})
    : _nadeuriDetailsViewModel = nadeuriDetailsViewModel;

  @override
  State<_NadeuriTitleSection> createState() => _NadeuriTitleSectionState();
}

class _NadeuriTitleSectionState extends State<_NadeuriTitleSection> {
  final FocusNode _nadeuriTitleFocusNode = FocusNode();

  late final TextEditingController _nadeuriTitleController;

  bool _nadeuriTextFieldReadOnly = true;

  @override
  void initState() {
    super.initState();

    _nadeuriTitleController = TextEditingController(text: widget._nadeuriDetailsViewModel.nadeuri.title);

    widget._nadeuriDetailsViewModel.updateNadeuri.addListener(_onUpdateNadeuri);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              setState(() {
                _nadeuriTextFieldReadOnly = true;
                _onTitleFixed();
              });
            },
            onTapOutside: (event) {
              setState(() {
                _nadeuriTextFieldReadOnly = true;
                _onTitleFixed();
              });
            },
            controller: _nadeuriTitleController,
            focusNode: _nadeuriTitleFocusNode,
            decoration: InputDecoration(
              hintText: "나들이 제목을 지정해보세요!",
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _nadeuriTextFieldReadOnly = !_nadeuriTextFieldReadOnly;
                    if (_nadeuriTextFieldReadOnly) {
                      _nadeuriTitleFocusNode.unfocus();
                      _onTitleFixed();
                    } else {
                      _nadeuriTitleFocusNode.requestFocus();
                    }
                  });
                },
                icon: Icon(Icons.edit),
              ),
            ),
            style: TextStyle(fontSize: 20.0),
            readOnly: _nadeuriTextFieldReadOnly,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget._nadeuriDetailsViewModel.updateNadeuri.removeListener(_onUpdateNadeuri);

    super.dispose();
  }

  /// 원래 제목과 다르면 업데이트 시도
  void _onTitleFixed() {
    if (_nadeuriTitleController.text == widget._nadeuriDetailsViewModel.nadeuri.title) {
      return;
    }

    widget._nadeuriDetailsViewModel.updateNadeuri.execute((_nadeuriTitleController.text,));
  }

  void _onUpdateNadeuri() {
    if (widget._nadeuriDetailsViewModel.updateNadeuri.error && mounted) {
      final Error result = widget._nadeuriDetailsViewModel.updateNadeuri.result! as Error;
      final Exception error = result.error;

      // 인증에 문제가 있으면 로그인 페이지로 이동.
      if (error is Unauthorized || error is TokenNotFound) {
        widget._nadeuriDetailsViewModel.updateNadeuri.clearResult();
        context.read<AppSnackBar>().showSnackBar("세션이 만료되었습니다.\n다시 로그인해주세요!");
        Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
        return;
      }

      // Nadeuri가 존재하지 않으면 홈화면으로 이동.
      if (error is NotFound) {
        widget._nadeuriDetailsViewModel.load.clearResult();
        context.read<AppSnackBar>().showSnackBar("나들이 정보가 없습니다.");
        Navigator.pop(context);
        return;
      }

      // 이외의 문제면 업데이트 전으로 되돌림.
      _nadeuriTitleFocusNode.unfocus();
      setState(() {
        _nadeuriTextFieldReadOnly = true;
      });
      context.read<AppSnackBar>().showSnackBar("제목 변경에 실패했습니다. 다시 시도해주세요.");
      _nadeuriTitleController.text = widget._nadeuriDetailsViewModel.nadeuri.title;
    }
  }
}

class _ChatSection extends StatelessWidget {
  const _ChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("채팅", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              CircleAvatar(
                foregroundImage: NetworkImage(""),
                onForegroundImageError: (exception, stackTrace) {},
                radius: 20,
                child: Icon(Icons.person, size: 30, color: Colors.blue),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                foregroundImage: NetworkImage(""),
                onForegroundImageError: (exception, stackTrace) {},
                radius: 20,
                child: Icon(Icons.person, size: 30, color: Colors.blue),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                foregroundImage: NetworkImage(""),
                onForegroundImageError: (exception, stackTrace) {},
                radius: 20,
                child: Icon(Icons.person, size: 30, color: Colors.blue),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                foregroundImage: NetworkImage(""),
                onForegroundImageError: (exception, stackTrace) {},
                radius: 20,
                child: Icon(Icons.person, size: 30, color: Colors.blue),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                foregroundImage: NetworkImage(""),
                onForegroundImageError: (exception, stackTrace) {},
                radius: 20,
                child: Icon(Icons.person, size: 30, color: Colors.blue),
              ),
              SizedBox(width: 8.0),
              Spacer(),
              Icon(Icons.more_horiz, size: 16),
            ],
          ),
          SizedBox(height: 16.0),
          Text("최근 채팅 메시지"),
        ],
      ),
    );
  }
}

class _PlanSection extends StatelessWidget {
  final NadeuriDetailsViewModel _nadeuriDetailsViewModel;

  const _PlanSection({super.key, required NadeuriDetailsViewModel nadeuriDetailsViewModel})
    : _nadeuriDetailsViewModel = nadeuriDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _nadeuriDetailsViewModel,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return _PlansDialog(nadeuriDetailsViewModel: _nadeuriDetailsViewModel);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text("일정들", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("더보기", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            if (_nadeuriDetailsViewModel.sortedPlans.isEmpty)
              Center(child: Text("일정이 없습니다. 일정을 추가해보세요."))
            else
              for (int i = 0; i < min(_nadeuriDetailsViewModel.sortedPlans.length, 5); i++)
                _planBar(_nadeuriDetailsViewModel.sortedPlans[i], context),
          ],
        );
      },
    );
  }
}

class _PhotoSection extends StatelessWidget {
  const _PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text("사진 ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Icon(Icons.arrow_forward_ios, size: 18.0),
          ],
        ),
      ),
    );
  }
}

class _SettlementSection extends StatelessWidget {
  const _SettlementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Text("정산 ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Icon(Icons.arrow_forward_ios, size: 18.0),
          ],
        ),
      ),
    );
  }
}

class _PlansDialog extends StatefulWidget {
  final NadeuriDetailsViewModel _nadeuriDetailsViewModel;

  const _PlansDialog({super.key, required NadeuriDetailsViewModel nadeuriDetailsViewModel})
    : _nadeuriDetailsViewModel = nadeuriDetailsViewModel;

  @override
  State<_PlansDialog> createState() => _PlansDialogState();
}

class _PlansDialogState extends State<_PlansDialog> with RouteAware {
  late final RouteObserver<ModalRoute<void>> _routeObserver;

  @override
  void initState() {
    super.initState();

    _routeObserver = context.read<RouteObserver<ModalRoute<void>>>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._nadeuriDetailsViewModel,
      builder: (context, _) {
        Widget dialogContents;
        List<Widget> plansForListView = <Widget>[];
        if (widget._nadeuriDetailsViewModel.sortedPlans.isEmpty) {
          dialogContents = Center(child: Text("일정이 없습니다. 일정을 추가해보세요."));
        } else {
          Map<DateTime, List<Plan>> planMap = <DateTime, List<Plan>>{};
          for (Plan plan in widget._nadeuriDetailsViewModel.sortedPlans) {
            DateTime key = DateTime(plan.startAt.year, plan.startAt.month, plan.startAt.day);
            planMap.putIfAbsent(key, () => <Plan>[]).add(plan);
          }
          for (DateTime key in planMap.keys.toList()..sort()) {
            plansForListView.add(
              Text(yearMonthDayFormat.format(key), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            );
            for (Plan plan in planMap[key]!) {
              plansForListView.add(_planBar(plan, context));
            }
            plansForListView.add(SizedBox(height: 16.0));
          }
          dialogContents = ListView(children: plansForListView);
        }
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(24.0),
            height: 500,
            child: Column(
              children: [
                Text("일정들", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Divider(height: 32.0),
                Expanded(child: dialogContents),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlanPage(
                              planViewModel: PlanViewModel.create(
                                nadeuriRepository: context.read<NadeuriRepository>(),
                                nadeuriUuid: widget._nadeuriDetailsViewModel.nadeuri.uuid!,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    widget._nadeuriDetailsViewModel.load.execute();
  }
}

InkWell _planBar(Plan plan, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlanPage(
            planViewModel: PlanViewModel.edit(
              nadeuriRepository: context.read<NadeuriRepository>(),
              plan: plan.allDay
                  ? plan.copyWith(
                      startAt: _isSameDay(plan.startAt, DateTime.now())
                          ? DateTime(plan.startAt.year, plan.startAt.month, plan.startAt.day, plan.startAt.hour + 1)
                          : DateTime(plan.startAt.year, plan.startAt.month, plan.startAt.day, 8),
                      endAt: _isSameDay(plan.endAt, DateTime.now())
                          ? DateTime(plan.endAt.year, plan.endAt.month, plan.endAt.day - 1, plan.endAt.hour + 2)
                          : DateTime(plan.endAt.year, plan.endAt.month, plan.endAt.day - 1, 9),
                    )
                  : plan,
            ),
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(plan.title.isEmpty ? "제목 없음" : plan.title),
          Row(
            children:
                DateUtils.isSameDay(
                  plan.startAt,
                  plan.allDay ? plan.endAt.subtract(const Duration(days: 1)) : plan.endAt,
                )
                ? <Widget>[
                    Text(monthDayFormat.format(plan.startAt)),
                    if (!plan.allDay) ...[
                      Spacer(),
                      Text("${timeFormat.format(plan.startAt)} - ${timeFormat.format(plan.endAt)}"),
                    ],
                  ]
                : <Widget>[
                    Expanded(
                      child: Text(
                        DateTime.now().year == plan.startAt.year
                            ? plan.allDay
                                  ? monthDayFormat.format(plan.startAt)
                                  : "${monthDayFormat.format(plan.startAt)} ${timeFormat.format(plan.startAt)}"
                            : plan.allDay
                            ? yearMonthDayFormat.format(plan.startAt)
                            : "${yearMonthDayFormat.format(plan.startAt)} ${timeFormat.format(plan.startAt)}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text("-"),
                    Expanded(
                      child: Text(
                        DateTime.now().year == plan.endAt.year
                            ? plan.allDay
                                  ? monthDayFormat.format(plan.endAt.subtract(const Duration(days: 1)))
                                  : "${monthDayFormat.format(plan.endAt)} ${timeFormat.format(plan.endAt)}"
                            : plan.allDay
                            ? yearMonthDayFormat.format(plan.endAt.subtract(const Duration(days: 1)))
                            : "${yearMonthDayFormat.format(plan.endAt)} ${timeFormat.format(plan.endAt)}",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
          ),
        ],
      ),
    ),
  );
}

bool _isSameDay(DateTime dateTime1, DateTime dateTime2) {
  return (dateTime1.year == dateTime2.year) && (dateTime1.month == dateTime2.month) && (dateTime1.day == dateTime2.day);
}
