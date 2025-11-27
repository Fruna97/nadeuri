import 'package:flutter/material.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/ui/core/app_snack_bar.dart';
import 'package:mobile/ui/nadeuri/details/nadeuri_details_view_model.dart';
import 'package:mobile/utils/result.dart';
import 'package:provider/provider.dart';

class NadeuriDetailsPage extends StatefulWidget {

  final NadeuriDetailsViewModel _nadeuriDetailsViewModel;

  const NadeuriDetailsPage({super.key, required NadeuriDetailsViewModel nadeuriDetailsViewModel})
    : _nadeuriDetailsViewModel = nadeuriDetailsViewModel;

  @override
  State<NadeuriDetailsPage> createState() => _NadeuriDetailsPageState();
}

class _NadeuriDetailsPageState extends State<NadeuriDetailsPage> {

  @override
  void initState() {
    super.initState();

    widget._nadeuriDetailsViewModel.load.addListener(_onLoad);
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
            _PlanSection(),
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

    super.dispose();
  }

  /// 인증에 문제가 있으면 로그인 페이지로 이동.
  void _onLoad() {
    if (widget._nadeuriDetailsViewModel.load.error && mounted) {
      final Error result = widget._nadeuriDetailsViewModel.load.result! as Error;
      final Exception error = result.error;

      if (error is Unauthorized || error is TokenNotFound) {
        widget._nadeuriDetailsViewModel.load.clearResult();
        context.read<AppSnackBar>().showSnackBar("세션이 만료되었습니다.\n다시 로그인해주세요!");
        Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
      }
      if (error is NotFound) {
        widget._nadeuriDetailsViewModel.load.clearResult();
        context.read<AppSnackBar>().showSnackBar("나들이 정보가 없습니다.");
        Navigator.pop(context);
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

  /// 인증에 문제가 있으면 로그인 페이지로 이동.
  void _onUpdateNadeuri() {
    if (widget._nadeuriDetailsViewModel.updateNadeuri.error && mounted) {
      final Error result = widget._nadeuriDetailsViewModel.updateNadeuri.result! as Error;
      final Exception error = result.error;

      if (error is Unauthorized || error is TokenNotFound) {
        widget._nadeuriDetailsViewModel.updateNadeuri.clearResult();
        context.read<AppSnackBar>().showSnackBar("세션이 만료되었습니다.\n다시 로그인해주세요!");
        Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
      }
    }
  }
}

class _ChatSection extends StatelessWidget {
  const _ChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("채팅", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.0),
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
            SizedBox(height: 12.0),
            Text("최근 채팅 메시지"),
          ],
        ),
      ),
    );
  }
}

class _PlanSection extends StatelessWidget {
  const _PlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("일정들", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        _plan("서울숲", DateTime(2025, 06, 05, 14), DateTime(2025, 06, 05, 15)),
        _plan("여의도", DateTime(2025, 06, 06, 14), DateTime(2025, 06, 08, 15)),
      ],
    );
  }

  InkWell _plan(String? planTitle, DateTime startAt, DateTime endAt) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(planTitle ?? ""),
            Row(
              children: DateUtils.isSameDay(startAt, endAt)
                  ? <Widget>[
                      Text(
                        "${startAt.year}.${startAt.month.toString().padLeft(2, "0")}.${startAt.day.toString().padLeft(2, "0")}",
                      ),
                      Spacer(),
                      Text(
                        "${startAt.hour.toString().padLeft(2, "0")}:${startAt.minute.toString().padLeft(2, "0")} ~ ${endAt.hour.toString().padLeft(2, "0")}:${endAt.minute.toString().padLeft(2, "0")}",
                      ),
                    ]
                  : <Widget>[
                      Text(
                        "${startAt.year}.${startAt.month.toString().padLeft(2, "0")}.${startAt.day.toString().padLeft(2, "0")} ${startAt.hour.toString().padLeft(2, "0")}:${startAt.minute.toString().padLeft(2, "0")}",
                      ),
                      Spacer(),
                      Text("~"),
                      Spacer(),
                      Text(
                        "${endAt.year}.${endAt.month.toString().padLeft(2, "0")}.${endAt.day.toString().padLeft(2, "0")} ${endAt.hour.toString().padLeft(2, "0")}:${endAt.minute.toString().padLeft(2, "0")}",
                      ),
                    ],
            ),
          ],
        ),
      ),
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
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            Text("사진 ", style: TextStyle(fontSize: 20.0)),
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
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            Text("정산 ", style: TextStyle(fontSize: 20.0)),
            Icon(Icons.arrow_forward_ios, size: 18.0),
          ],
        ),
      ),
    );
  }
}
