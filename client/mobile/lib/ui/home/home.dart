import 'package:flutter/material.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/ui/home/home_view_model.dart';
import 'package:mobile/utils/result.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();

    _homeViewModel = context.read<HomeViewModel>();

    _homeViewModel.load.addListener(_navigateOnLoadError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _homeViewModel.load,
          builder: (context, child) {
            if (_homeViewModel.load.running) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_homeViewModel.load.error) {
              final Error result = _homeViewModel.load.result! as Error;
              final Exception error = result.error;
              if (error is Unauthorized || error is TokenNotFound) {
                return SizedBox.shrink();
              }
              return _PleaseRetryScreen(homeViewModel: _homeViewModel);
            }

            return child!;
          },
          child: _HomeScreen(homeViewModel: _homeViewModel),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _homeViewModel.load.removeListener(_navigateOnLoadError);

    super.dispose();
  }

  void _navigateOnLoadError() {
    if (_homeViewModel.load.error && mounted) {
      Error result = _homeViewModel.load.result! as Error; // error == true 이면 result != null
      final Exception error = result.error;

      if (error is Unauthorized || error is TokenNotFound) {
        Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
      }
    }
  }
}

class _HomeScreen extends StatelessWidget {
  final double _paddingHorizontalToFitWithCard = 4.0;
  final double _paddingHorizontal = 16.0;

  final HomeViewModel _homeViewModel;

  const _HomeScreen({super.key, required homeViewModel}) : _homeViewModel = homeViewModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 16.0),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(padding: MediaQuery.of(context).viewInsets, child: _CreateNadeuriSheet());
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: _paddingHorizontal + _paddingHorizontalToFitWithCard,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("나들이 추가하기", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.0),
        InkWell(
          onTap: () async {},
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: _paddingHorizontal + _paddingHorizontalToFitWithCard,
            ),
            child: Row(
              children: <Widget>[
                ListenableBuilder(
                  listenable: _homeViewModel.load,
                  builder: (context, child) {
                    return Text(
                      "예정된 일정 (${_homeViewModel.nadeuris.length})",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 260, // 카드 내부의 위젯을 다룰 때, 카드의 높이를 조정해야 함.
          child: Padding(
            padding: EdgeInsets.fromLTRB(_paddingHorizontal, 0, 0, 0),
            child: ListenableBuilder(
              listenable: _homeViewModel,
              builder: (context, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _homeViewModel.nadeuris.length,
                  itemBuilder: (context, index) {
                    return _NadeuriCard(title: _homeViewModel.nadeuris[index].title ?? "");
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(height: 24.0),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: _paddingHorizontal + _paddingHorizontalToFitWithCard,
            ),
            child: Row(
              children: <Widget>[Text("지난 일정 (5)", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 260, // 카드 내부의 위젯을 다룰 때, 카드의 높이를 조정해야 함.
          child: Padding(
            padding: EdgeInsets.fromLTRB(_paddingHorizontal, 0, 0, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _NadeuriCard(title: "나들이 제목");
              },
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}

class _NadeuriCard extends StatelessWidget {
  static final ShapeBorder _border = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));

  final String _title;

  const _NadeuriCard({super.key, required String title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: _border,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        customBorder: _border,
        child: SizedBox(
          width: 180,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[700],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("mm.dd ~ mm.dd", style: TextStyle(color: Colors.white, fontSize: 12.0)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),
                        width: 30,
                        height: 30,
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),
                        width: 30,
                        height: 30,
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                      child: Container(
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),
                        width: 30,
                        height: 30,
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: Align(alignment: AlignmentDirectional.centerEnd, child: Icon(Icons.more_horiz, size: 16)),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget>[Text(_title, style: TextStyle(fontWeight: FontWeight.bold))],
                ),
                Row(
                  children: <Widget>[Text("주소", style: TextStyle(color: Colors.black54))],
                ),
                SizedBox(height: 12.0),
                Row(children: [Text("장소1")]),
                Row(children: [Text("장소2")]),
                Row(children: [Text("장소3")]),
                Row(children: [Text("...")]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateNadeuriSheet extends StatefulWidget {
  const _CreateNadeuriSheet({super.key});

  @override
  State<_CreateNadeuriSheet> createState() => _CreateNadeuriSheetState();
}

class _CreateNadeuriSheetState extends State<_CreateNadeuriSheet> {
  String _createNadeuriText = "나중에 정하기";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("나들이 제목을 입력해 보세요!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 32.0),
          TextField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _createNadeuriText = value.isEmpty ? "나중에 정하기" : "나들이 추가하기";
              });
            },
          ),
          SizedBox(height: 32.0),
          Align(
            alignment: Alignment.bottomRight,
            child: FilledButton(
              onPressed: () {
                // TODO: 나들이 생성 요청
                // TODO: 나들이 상세 정보 페이지로 이동
              },
              child: Text(_createNadeuriText),
            ),
          ),
        ],
      ),
    );
  }
}

class _PleaseRetryScreen extends StatelessWidget {
  final HomeViewModel _homeViewModel;

  const _PleaseRetryScreen({super.key, required HomeViewModel homeViewModel}) : _homeViewModel = homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("서비스 접속이 원활하지 않습니다.\n다시 시도해주세요.", textAlign: TextAlign.center),
          SizedBox(height: 12.0),
          ElevatedButton.icon(
            onPressed: () {
              _homeViewModel.load.execute();
            },
            icon: Icon(Icons.replay),
            label: Text("다시 시도하기"),
          ),
        ],
      ),
    );
  }
}
