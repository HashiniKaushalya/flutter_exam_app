import 'dart:convert';
import 'package:first_project/models/exam.dart';
import 'package:first_project/models/scheduleExam.dart';
import 'package:first_project/utils/api_url.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ScheduleExams extends StatefulWidget {
  final Exam exams;
  ScheduleExams(this.exams);
  @override
  State<StatefulWidget> createState() => _ScheduleExamsState(exams);
}

class _ScheduleExamsState extends State<ScheduleExams> {
  final Exam exams;
  _ScheduleExamsState(this.exams);
  List<Exam> item = List();
  List<ScheduleExam> scheduleItems = List();
  List<String> array = [];
  bool _isLoading = false;
  DateTime pickedDate;

  String _selectedExam;
  @override
  void initState() {
    super.initState();
    getScheduledList();
    _getExamList();
   // _isLoading = true;
  }

  _getExamList() async {
    var res = await AppUrl.getExamList();
    try {
      if (res.statusCode == 200) {
        Iterable listData = json.decode(res.body);
        setState(() {
          item = listData.map((e) => Exam.fromJson(e)).toList();
          _isLoading = true;
        });
      }
    } catch (error) {
      throw error;
    }
  }

  getScheduledList() async {
    var res = await AppUrl.getScheduledList();
    try {
      if (res.statusCode == 200) {
        Iterable listData = json.decode(res.body);
        setState(() {
          scheduleItems =
              listData.map((e) => ScheduleExam.fromJson(e)).toList();
          //_isLoading = true;
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
        title: Text("Add.."),
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.3),
        child: _isLoading
            ? CircularProgressIndicator()
            : Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Choose..'),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _selectedExam,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedExam = newValue;
                                    array.add(_selectedExam);
                                    //_isLoading = false;
                                  });
                                  print(_selectedExam);
                                },
                                items: item.map((value) {
                                  return DropdownMenuItem(
                                    child: new Text(value.name ?? 'Empty'),
                                    value: value.name,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _selectedExam == null
                        ? Text('Select the dropdown value for list to appear.')
                        : Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: array.length,
                                itemBuilder: (context, index) {
                                  return new Card(
                                    color: Theme.of(context).primaryColor,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 8.0, 8.0, 2.0),
                                          child: Container(
                                            height: 70,
                                            child: new ListTile(
                                              title: Text(
                                                array[index],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  pickedDate.toString() ??
                                                      'default'),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  Icons.date_range,
                                                  color: Color(0xfff063057),
                                                ),
                                                onPressed: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        pickedDate == null
                                                            ? DateTime.now()
                                                            : pickedDate,
                                                    firstDate: DateTime(2001),
                                                    lastDate: DateTime(2222),
                                                  ).then((date) {
                                                    setState(() {
                                                      pickedDate = date;
                                                    });
                                                  });
                                                  scheduleExams();
                                                  //Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
              ),
      ),
    );
  }

  void scheduleExams() async {
    var res = await AppUrl.postScheduleExam();
    if (res.statusCode == 201) {
      Flushbar(
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.amberAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Success", style: TextStyle(color: Colors.amberAccent)),
        message: "You have sucessfully scheduled an exam",
        duration: Duration(seconds: 2),
      ).show(context).then((value) => getScheduledList());
    }
  }
}
