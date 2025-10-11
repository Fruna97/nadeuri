import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _paddingHorizontalToFitWithCard = 4.0;
  final double _paddingHorizontal = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
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
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: _paddingHorizontal + _paddingHorizontalToFitWithCard,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text("예정된 일정 (4)", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(_paddingHorizontal, 0, 0, 0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [_NadeuriCard(), _NadeuriCard(), _NadeuriCard(), _NadeuriCard()]),
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
                      children: <Widget>[
                        Text("지난 일정 (2)", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(_paddingHorizontal, 0, 0, 0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [_NadeuriCard(), _NadeuriCard()]),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NadeuriCard extends StatelessWidget {
  static final ShapeBorder _border = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));

  const _NadeuriCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: _border,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        customBorder: _border,
        child: Container(
          width: 180,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.blueAccent[700], borderRadius: BorderRadius.circular(12.0)),
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
                      decoration: BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4.0, 0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(alignment: AlignmentDirectional.topEnd, child: Icon(Icons.more_horiz, size: 16)),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Row(
                children: <Widget>[Text("나들이 제목", style: TextStyle(fontWeight: FontWeight.bold))],
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
