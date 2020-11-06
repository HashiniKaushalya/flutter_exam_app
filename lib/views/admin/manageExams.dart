import 'dart:convert';

import 'package:first_project/providers/exams.dart';
//import 'package:exam_master/utils/shared_preference.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  void initState() {
    super.initState();
    // futureAlbum = fetchAlbum();
  }

  ExamProvider exam = new ExamProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        title: Text('Exam  Manage '),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: exam.getExam(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // print(_age(snapshot.data[0]));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAdd();
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
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: () => {onEdit(snapshot)},
            ), // icon-1
            InkWell(
              child: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  deleteConfirm(int.parse(snapshot['id']));
                },
              ),
            ), // icon-1
          ],
        ),
      ),
    );
  }

  void deleteConfirm(int id) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Delete Alert",
      desc: "Are you sure to delete this item",
      buttons: [
        DialogButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            exam.deleteExam(id).then(
              (value) {
                Get.back();
                if (value == 200) {
                  Flushbar(
                    title: "Deleted Sucessfully",
                    message: "You have sucessfully deleted the exam",
                    duration: Duration(seconds: 2),
                  ).show(context);
                  super.setState(() {});
                } else {
                  Flushbar(
                    title: "Delete Unsucessful",
                    message: "An error occured during deletion.Try Again",
                    duration: Duration(seconds: 2),
                  ).show(context);
                }
              },
            );
          },
          width: 120,
        )
      ],
    ).show();
  }

  onEdit(snapshot) {
    var nameController = new TextEditingController();
    var durationController = new TextEditingController();
    nameController.text = snapshot['name'];
    durationController.text = snapshot['duration'].toString();
    Alert(
        context: context,
        title: "Edit Exam",
        content: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(
                labelText: 'Duration Minutes',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              final Map<String, dynamic> data = {
                "name": nameController.text,
                "duration": int.parse(durationController.text)
              };
              exam
                  .updateExam(int.parse(snapshot['id']), json.encode(data))
                  .then((value) {
                Get.back();
                if (value == 200) {
                  Flushbar(
                    title: "Update Sucessfully",
                    message: "You have sucessfully updated the exam",
                    duration: Duration(seconds: 2),
                  ).show(context);
                  super.setState(() {});
                } else {
                  Flushbar(
                    title: "Update Unsucessful",
                    message: "An error occured during update.Try Again",
                    duration: Duration(seconds: 2),
                  ).show(context);
                }
              });
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  onAdd() {
    var nameController = new TextEditingController();
    var durationController = new TextEditingController();
    Alert(
        context: context,
        title: "Add Exam",
        content: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(
                labelText: 'Duration Minutes',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              final Map<String, dynamic> data = {
                "name": nameController.text,
                "duration": int.parse(durationController.text)
              };
              exam.addExam(json.encode(data)).then((value) {
                Get.back();
                if (value == 201) {
                  Flushbar(
                    title: "Sucessfully Added",
                    message: "You have sucessfully added the exam",
                    duration: Duration(seconds: 2),
                  ).show(context);
                  super.setState(() {});
                } else {
                  Flushbar(
                    title: "Adding Unsucessful",
                    message: "An error occured during adding.Try Again",
                    duration: Duration(seconds: 2),
                  ).show(context);
                }
              });
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
