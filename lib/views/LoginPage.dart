import 'dart:convert';
import 'package:first_project/models/user.dart';
import 'package:first_project/views/user/userDashboard.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUpPage.dart';
import 'package:first_project/views/admin/dashboard.dart';
import 'package:first_project/utils/api_url.dart';

class LoginPage extends StatefulWidget {
  final User users;
  LoginPage(this.users, {User user});
  @override
  _LoginPageState createState() => _LoginPageState(users);
}

class _LoginPageState extends State<LoginPage> {
  User users;
  _LoginPageState(this.users);

  bool hidePwd = true;

  void _toggleVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() async {
      var res = await AppUrl.loginUser(users);
      var decodedBody = json.decode(res.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (res.statusCode == 200) {
        if (decodedBody == "Invalid Username or Password") {
          Flushbar(
            icon: Icon(
              Icons.warning_outlined,
              color: Colors.amberAccent,
            ),
            showProgressIndicator: true,
            progressIndicatorBackgroundColor: Colors.blue[200],
            titleText:
                Text("Failed", style: TextStyle(color: Colors.amberAccent)),
            message: "Invalid username or password",
            duration: Duration(seconds: 1),
          )..show(context);
        } else {
          User data = User.fromJson(decodedBody);
          prefs.setInt('userId', data.userId);
          if (data.isAdmin == true) {
            Flushbar(
              icon: Icon(
                Icons.warning_outlined,
                color: Colors.amberAccent,
              ),
              showProgressIndicator: true,
              progressIndicatorBackgroundColor: Colors.blue[200],
              titleText:
                  Text("Success", style: TextStyle(color: Colors.amberAccent)),
              message: "Logged In Successfully",
              duration: Duration(seconds: 1),
            )..show(context).then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminDashboard())));
          } else {
            Flushbar(
              icon: Icon(
                Icons.warning_outlined,
                color: Colors.amberAccent,
              ),
              showProgressIndicator: true,
              progressIndicatorBackgroundColor: Colors.blue[200],
              titleText:
                  Text("Success", style: TextStyle(color: Colors.amberAccent)),
              message: "Logged In Successfully",
              duration: Duration(seconds: 1),
            )..show(context).then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPage(
                          user: users,
                        ))));
          }
        }
      } else {
        Flushbar(
          icon: Icon(
            Icons.warning_outlined,
            color: Colors.amberAccent,
          ),
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.blue[200],
          titleText:
              Text("Warning", style: TextStyle(color: Colors.amberAccent)),
          message: "Something went wrong",
          duration: Duration(seconds: 4),
        )..show(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
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
                          child: TextFormField(
                            controller: _emailController,
                            onChanged: (value) =>
                                users.email = _emailController.text,
                            autocorrect: true,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.send,
                            validator: (val) => val.isEmpty
                                ? "Enter a valid Email Address"
                                : null,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            cursorColor: Colors.black,
                            cursorRadius: Radius.circular(16),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_rounded,
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
                                child: TextFormField(
                                  controller: _passwordController,
                                  onChanged: (value) =>
                                      users.password = _passwordController.text,
                                  autocorrect: true,
                                  autofocus: true,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.send,
                                  validator: (val) => val.isEmpty
                                      ? "Enter a valid Password"
                                      : null,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  cursorColor: Colors.black,
                                  cursorRadius: Radius.circular(16),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock_rounded,
                                          color: Color(0xfff063057)),
                                      hintText: "******",
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: hidePwd
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 20),
                          alignment: Alignment.centerRight,
                          child: Text("Forgotten Password"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xfff063057),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: InkWell(
                            onTap: () {
                              //doLogin();
                              if (formKey.currentState.validate()) {
                                login();
                              }
                            },
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
                            Text("Don't have an account? "),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openSignUpPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage(User())));
  }
}
