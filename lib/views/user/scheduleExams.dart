import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:first_project/providers/exams.dart';
import 'package:first_project/providers/sheduleExam.dart';
import 'package:flushbar/flushbar.dart';

class Shedule extends StatefulWidget {
  @override
  _SheduleState createState() => _SheduleState();
}

class _SheduleState extends State<Shedule> {
  ExamProvider exam = new ExamProvider();
  DateTime selectedDate = DateTime.now();
  ExamsSheduleProvider examShedule = new ExamsSheduleProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        title: Text('Schedule Exam'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: exam.getExam(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //print(_age(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return examCard(context, snapshot.data[index]);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget examCard(context, snapshot) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xfff063057),
          foregroundColor: Colors.white,
          child: Text(
            snapshot['id'],
            style: TextStyle(fontSize: 13.0),
          ),
        ),
        title: Text(snapshot['name']),
        subtitle: Text(getTimeString(snapshot['duration'])),
        trailing: IconButton(
            icon: Icon(
              Icons.date_range,
              color: Color(0xfff063057),
            ),
            onPressed: () => _selectDate(context, snapshot)),
      ),
    );
  }

  _selectDate(BuildContext context, selectedExam) async {
    final DateTime picked = await showDatePicker(
      context: context,
      confirmText: 'SHEDULE',
      helpText: 'Select a date to shedule the exam',
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      print(selectedExam);
      print(picked);
      sheduleExam(selectedExam, picked);
    }
    // setState(() {
    //   selectedDate = picked;
    // });
  }

  void sheduleExam(data, sheddate) {
    var reqBody = {
      "name": data["name"],
      "duration": data["duration"],
      "sheduled_date": sheddate.toString(),
      "userId": 1
    };
    examShedule.sheduleExam(reqBody).then((value) {
      if (value == 200) {
        Flushbar(
          title: "Sheduled Sucessfully",
          message: "You have sucessfully deleted the exam",
          duration: Duration(seconds: 2),
        ).show(context);
        super.setState(() {});
      } else {
        Flushbar(
          title: "Shedule Unsucessful",
          message: "An error occured during sheduling.Try Again",
          duration: Duration(seconds: 2),
        ).show(context);
      }
    });
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")} hours ${minutes.toString().padLeft(2, "0")} minutes';
  }
}
