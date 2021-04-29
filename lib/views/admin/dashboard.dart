import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        centerTitle: false,
        title: Text(
          "Admin Dashboard",
          style: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.all(15),
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
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
                                  'Manage Exams ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(context, '/dashboardAdmin')
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
                                  'View Users',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(context, '/dashboardUser')
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
