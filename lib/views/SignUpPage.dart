import 'package:flushbar/flushbar.dart';
import 'package:first_project/models/user.dart';
import 'package:first_project/utils/api_url.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:first_project/views/user/userDashboard.dart';

class SignUpPage extends StatefulWidget {
  final User users;
  SignUpPage(this.users);

  @override
  _SignUpPageState createState() => _SignUpPageState(users);
}

class _SignUpPageState extends State<SignUpPage> {
  final User users;
  _SignUpPageState(this.users);
  
  bool hidePwd = true;

  void _toggleVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }
  final formKey = new GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Full Name",
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
                          controller: _nameController,
                          onChanged: (value) =>
                              users.name = _nameController.text,
                          autocorrect: true,
                          autofocus: true,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          validator: (val) =>
                              val.isEmpty ? "Enter a valid User Name" : null,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(16),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xfff063057),
                              ),
                              hintText: "Example : John Doe",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Confirm Password",
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
                          controller: _confirmpasswordController,
                          autocorrect: true,
                          autofocus: true,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.send,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter re-password";
                            }
                            if (_passwordController.text !=
                                _confirmpasswordController.text) {
                              return "Password Do not match";
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(16),
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Color(0xfff063057),
                              ),
                              hintText: "******",
                              border: InputBorder.none),
                        ),
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
                            if (formKey.currentState.validate()) {
                              registerUser();
                            } else {
                              print("Unsuccessfull");
                            }
                          },
                          child: Center(
                            child: Text(
                              "Sign Up",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account "),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(User())));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() async {
    var result = await AppUrl.registerUser(users);
    {
      if (result.statusCode == 201) {
        Flushbar(
          icon: Icon(
            Icons.warning_outlined,
            color: Colors.amberAccent,
          ),
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.blue[200],
          titleText:
              Text("Success", style: TextStyle(color: Colors.amberAccent)),
          message: "Signed In Successfully",
          duration: Duration(seconds: 1),
        )..show(context).then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserPage(user: users))));
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
  }

  void openUserPage() {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserPage(user: users)));
  }
}
