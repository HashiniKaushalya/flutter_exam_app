import 'dart:convert';
import 'package:first_project/models/exam.dart';
import 'package:first_project/models/scheduleExam.dart';
import 'package:first_project/utils/api_url.dart';
import 'package:flutter/material.dart';

class Scheduled extends StatefulWidget {
  final ScheduleExam exams;
  Scheduled(this.exams, {Exam exam});
  @override
  _ScheduledState createState() => _ScheduledState(exams);
}

class _ScheduledState extends State<Scheduled> {
  final ScheduleExam exams;
  _ScheduledState(this.exams);

  @override
  void initState() {
    getScheduledList();
    super.initState();
  }

  List<ScheduleExam> examList;

  getScheduledList() async {
    var res = await AppUrl.getScheduledList();
    try {
      if (res.statusCode == 200) {
        Iterable list = json.decode(res.body);
        setState(() {
          examList = list.map((e) => ScheduleExam.fromJson(e)).toList();
        });
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        title: Text('Scheduled Exam List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: examList == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: examList.length,
                  itemBuilder: (context, index) {
                    return ExamCard(examList[index], index);
                  }),
            ),
    );
  }
}

// ignore: must_be_immutable
class ExamCard extends StatefulWidget {
  final ScheduleExam exams;
  int index;
  ExamCard(this.exams, this.index);
  @override
  _ExamCardState createState() => _ExamCardState(exams, index);
}

class _ExamCardState extends State<ExamCard> {
  _ExamCardState(this.exams, this.index);
  final ScheduleExam exams;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
        ),
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(
            exams.date ?? 'default',
          ),
          subtitle: Text(
            exams.examName ?? 'default'
          ),
        ),
      ),
    );
  }
}

