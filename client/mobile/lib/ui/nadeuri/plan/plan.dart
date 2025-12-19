import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final TextEditingController planTitleController = TextEditingController();

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
            _DateTimeSection(),
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
  const _DateTimeSection({super.key});

  @override
  State<_DateTimeSection> createState() => _DateTimeSectionState();
}

class _DateTimeSectionState extends State<_DateTimeSection> {
  bool _dateOnly = false;
  DateTime _fromDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 1,
  );
  DateTime _toDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 2,
  );

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
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: _fromDateTime,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (dateTime == null) {
                    return;
                  }

                  setState(() {
                    _fromDateTime = DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      _fromDateTime.hour,
                      _fromDateTime.minute,
                    );
                    if (_toDateTime.isBefore(_fromDateTime) || _toDateTime.isAtSameMomentAs(_fromDateTime)) {
                      _toDateTime = _fromDateTime.add(const Duration(hours: 1));
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(DateFormat("yyyy년 MM월 dd일").format(_fromDateTime)),
                ),
              ),
            ),
            if (!_dateOnly)
              InkWell(
                onTap: () async {
                  TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: _fromDateTime.hour, minute: _fromDateTime.minute),
                  );
                  if (timeOfDay == null) {
                    return;
                  }

                  setState(() {
                    _fromDateTime = DateTime(
                      _fromDateTime.year,
                      _fromDateTime.month,
                      _fromDateTime.day,
                      timeOfDay.hour,
                      timeOfDay.minute,
                    );
                    if (_toDateTime.isBefore(_fromDateTime) || _toDateTime.isAtSameMomentAs(_fromDateTime)) {
                      _toDateTime = _fromDateTime.add(const Duration(hours: 1));
                    }
                  });
                  log(_fromDateTime.toString());
                  log(_toDateTime.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(DateFormat("h:mm aaa").format(_fromDateTime)),
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
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: _toDateTime,
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                  );
                  if (dateTime == null) {
                    return;
                  }

                  setState(() {
                    _toDateTime = DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      _toDateTime.hour,
                      _toDateTime.minute,
                    );
                    if (_toDateTime.isBefore(_fromDateTime) || _toDateTime.isAtSameMomentAs(_fromDateTime)) {
                      _fromDateTime = _toDateTime.subtract(const Duration(hours: 1));
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(DateFormat("yyyy년 MM월 dd일").format(_toDateTime)),
                ),
              ),
            ),
            if (!_dateOnly)
              InkWell(
                onTap: () async {
                  TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: _toDateTime.hour, minute: _toDateTime.minute),
                  );
                  if (timeOfDay == null) {
                    return;
                  }

                  setState(() {
                    _toDateTime = DateTime(
                      _toDateTime.year,
                      _toDateTime.month,
                      _toDateTime.day,
                      timeOfDay.hour,
                      timeOfDay.minute,
                    );
                    if (_toDateTime.isBefore(_fromDateTime) || _toDateTime.isAtSameMomentAs(_fromDateTime)) {
                      _fromDateTime = _toDateTime.subtract(const Duration(hours: 1));
                    }
                  });
                  log(_fromDateTime.toString());
                  log(_toDateTime.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(DateFormat("h:mm aaa").format(_toDateTime)),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
