//import 'dart:html';

import 'package:flutter/material.dart';
import 'SignUpPage.dart';
import 'package:first_project/views/user/userDashboard.dart';
import 'package:first_project/views/admin/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // static const IconData email_rounded =
  //  IconData(0xf1a2, fontFamily: 'MaterialIcons');
  bool hidePwd = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(15),
          width: 50,
          height: 50,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(50)),
          //   color: Colors.grey.withOpacity(0.5),
          // ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
            //child: Image.asset('assets/image.png'),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Email Address",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded,
                            color: Color(0xfff063057),                          
                        ),
                            hintText: "Example : test@test.com",
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              obscureText: hidePwd,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_rounded,
                                  color: Color(0xfff063057)),
                                  hintText: "****",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              onPressed: togglePwdVisibility,
                              icon: IconButton(
                                onPressed: () {},
                                icon: hidePwd == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, right: 20),
                      alignment: Alignment.centerRight,
                      child: Text("Forgot Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xfff063057),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: InkWell(
                        onTap: openUserPage,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                        child: Text('or'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/fbIcon.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/gIcon.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account "),
                        InkWell(
                          onTap: openSignUpPage,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminDashboard()));
                          },
                          child: new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Text(
                              "Admin Login",
                              style: TextStyle(
                                  height: 4.5,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     InkWell(
                    //       onTap: adminDashboard,
                    //     ),
                    //     Text(
                    //         'Admin Login',
                    //         style: TextStyle(
                    //         decoration: TextDecoration.underline,
                    //         height: 1.5,
                    //         color: Colors.blue,
                    //         fontWeight: FontWeight.w700,
                    //         fontFamily: 'Roboto-Regular',
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openSignUpPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  void openUserPage() {
    Navigator.pop(context);
    //Navigator.pushNamed(context, '/Schedule');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserPage()));
  }

  void togglePwdVisibility() {
    hidePwd = !hidePwd;
    setState(() {});
  }
}
