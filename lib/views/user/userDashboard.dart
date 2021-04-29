import 'package:first_project/views/user/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:first_project/models/user.dart';
//import 'package:first_project/views/LoginPage.dart';
//import './mainDrawer.dart';

class UserPage extends StatefulWidget {
  final User user;
  UserPage({Key key, @required this.user}) : super(key: key);
  
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        centerTitle: false,
        title: Text(
          "User Dashboard",
          style: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.all(5),
          width: 50,
          height: 50,
           child: IconButton(
             onPressed: () {
               Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainDrawer()));
             },
             icon: Icon(
               Icons.menu,
               color: Colors.white,
             ),
           ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: RaisedButton(
                            color: Color(0xfff063057),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                Text(
                                  'Schedule Exams ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(context, '/scheduleExams')
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: RaisedButton(
                            color: Color(0xfff063057),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                Text(
                                  'View Scheduled Exams',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(context, '/viewScheduled')
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
