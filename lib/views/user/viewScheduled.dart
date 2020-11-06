//import 'dart:math';

import 'package:first_project/providers/sheduleExam.dart';
import 'package:first_project/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scheduled extends StatefulWidget {
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  ExamsSheduleProvider examShedule = new ExamsSheduleProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        title: Text('User Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              UserPreferences().removeUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: examShedule.getExam(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // print(_age(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return examCard(snapshot.data[index]);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget examCard(snapshoptData) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xfff063057),
          foregroundColor: Colors.white,
          child: Text(
            snapshoptData['id'],
            style: TextStyle(fontSize: 13.0),
          ),
        ),
        title: Text(snapshoptData['name']),
        subtitle: Text('Duration - 3h 30 minutes'),
        trailing: Text(DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(snapshoptData['sheduled_date']))),
      ),
    );
  }
}
