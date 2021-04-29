import 'package:first_project/models/exam.dart';
import 'package:first_project/utils/api_url.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminView extends StatefulWidget {
  final Exam exams;
  AdminView(this.exams);
  @override
  _AdminViewState createState() => _AdminViewState(exams);
}

class _AdminViewState extends State<AdminView> {
  final Exam exams;
  _AdminViewState(this.exams);
  TextEditingController nameController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  @override
  void initState() {
    getExamList();
    super.initState();
  }

  List<Exam> examList;

  getExamList() async {
    var res = await AppUrl.getExamList();
    try {
      if (res.statusCode == 200) {
        Iterable list = json.decode(res.body);
        setState(() {
          examList = list.map((e) => Exam.fromJson(e)).toList();
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
        title: Text('Exam Management'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAdd(context);
        },
        backgroundColor: Color(0xfff063057),
        child: Icon(Icons.add),
      ),
    );
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")} hours ${minutes.toString().padLeft(2, "0")} minutes';
  }

   addExams() async {
    var res = await AppUrl.addExam(exams);
    if (res.statusCode == 201) {
      Flushbar(
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.amberAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Success", style: TextStyle(color: Colors.amberAccent)),
        message: "Added Successfully",
        duration: Duration(seconds: 2),
      )..show(context).then((value) => getExamList());
    } else {
      Flushbar(
        title: "Adding Unsucessful",
        message: "An error occured during adding.Try Again",
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  void onAdd(BuildContext context) {
    Alert(
        context: context,
        title: "Add Exam",
        content: Column(
          children: [
            TextField(
              controller: nameController,
              onChanged: (value) => exams.name = nameController.text,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              cursorColor: Colors.blue,
            ),
            TextField(
              controller: durationController,
              onChanged: (value) => exams.duration = durationController.text,
              decoration: InputDecoration(
                labelText: 'Duration Minutes',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              addExams();
              Navigator.of(context).pop();
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
}

// ignore: must_be_immutable
class ExamCard extends StatefulWidget {
  final Exam exams;
  int index;
  ExamCard(this.exams, this.index);
  @override
  _ExamCardState createState() => _ExamCardState(exams, index);
}

class _ExamCardState extends State<ExamCard> {
  TextEditingController editnameController = TextEditingController();
  TextEditingController editdurationController = TextEditingController();
  _ExamCardState(this.exams, this.index);
  final Exam exams;
  int index;

  @override
  void initState() {
    getExamList();
    super.initState();
    editnameController = new TextEditingController(text: exams.name);
    editdurationController = new TextEditingController(text: exams.duration);
  }

  List<Exam> examList;

  getExamList() async {
    var res = await AppUrl.getExamList();
    try {
      if (res.statusCode == 200) {
        Iterable list = json.decode(res.body);
        setState(() {
          examList = list.map((e) => Exam.fromJson(e)).toList();
        });
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
              ),
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text(
                  exams.name ?? 'default',
                ),
                subtitle: Text(exams.duration ?? 'default'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Edit',
                color: Colors.cyan[900],
                icon: Icons.edit,
                onTap: () {
                  onEdit(context);
                },
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.blueGrey,
                icon: Icons.delete,
                onTap: () {
                  onDelete(context);
                },
              )
            ]));
  }

  void onEdit(BuildContext context) {
    Alert(
        context: context,
        title: "Edit Exam",
        content: Column(
          children: <Widget>[
            TextField(
              controller: editnameController,
              onChanged: (value) => exams.name = editnameController.text,
              decoration: InputDecoration(              
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: editdurationController,
              onChanged: (value) =>
                  exams.duration = editdurationController.text,
              decoration: InputDecoration(
                labelText: 'Duration in Minutes',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              editExams();
              Navigator.of(context).pop();
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void editExams() async {
    int index;
    var res = await AppUrl.updateExam(examList[index].examId, exams);
    if (res.statusCode == 200) {
      Flushbar(
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.amberAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Update", style: TextStyle(color: Colors.amberAccent)),
        message: "You have sucessfully updated the exam",
        duration: Duration(seconds: 2),
      ).show(context).then((value) => getExamList());
    } else {
      Flushbar(
        title: "Update Unsucessful",
        message: "An error occured during update.Try Again",
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  void onDelete(BuildContext context) {
    Alert(
        context: context,
        type: AlertType.info,
        title: "Delete Alert",
        desc: "Are you sure to delete this item",
        buttons: [
          DialogButton(
            onPressed: () {
              deleteConfirm();
              Navigator.of(context).pop();
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void deleteConfirm() async {
    var res = await AppUrl.deleteExam(examList[index].examId);
    if (res.statusCode == 200) {
      Flushbar(
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.amberAccent,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blue[200],
        titleText: Text("Delete", style: TextStyle(color: Colors.amberAccent)),
        message: "You have sucessfully deleted the exam",
        duration: Duration(seconds: 2),
      ).show(context).then((value) => getExamList());
    } else {
      Flushbar(
        title: "Delete Unsucessful",
        message: "An error occured during the deletion.Try Again",
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }
}
