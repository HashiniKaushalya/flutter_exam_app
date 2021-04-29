import 'dart:ui';
import 'package:first_project/models/scheduleExam.dart';
import 'package:first_project/models/user.dart';
import 'package:first_project/views/user/scheduleExams.dart';
import 'package:flutter/material.dart';
import 'package:first_project/views/LoginPage.dart';
import 'package:first_project/views/SignUpPage.dart';
import 'package:first_project/views/admin/manageExams.dart';
import 'package:first_project/views/admin/viewUsers.dart';
import 'package:first_project/views/user/viewScheduled.dart';
import 'models/exam.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
        '/LoginPage': (context) => LoginPage(User()),
        '/SignUpPage': (context) => SignUpPage(User()),
        '/dashboardAdmin': (context) => AdminView(Exam()),
        '/dashboardUser': (context) => UserView(User()),
        '/scheduleExams': (context) => ScheduleExams(Exam()),
        '/viewScheduled': (context) => Scheduled(ScheduleExam()),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: Text(
                "Exam-Master",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Container(
              padding: EdgeInsets.all(80),
              child: Image.asset('assets/image2.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xfff063057),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: InkWell(
                onTap: openSignUp,
                child: Center(
                  child: Text("Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Container(
              padding: EdgeInsets.all(30),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xfff063057),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: InkWell(
                onTap: openLogin,
                child: Center(
                  child: Text("Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openSignUp() {
    Navigator.pushNamed(context, '/SignUpPage');
  }

  void openLogin() {
    Navigator.pushNamed(context, '/LoginPage');
  }
}
