import 'package:first_project/providers/auth.dart';
import 'package:first_project/utils/validators.dart';
import 'package:first_project/utils/widgets.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);


    final usernameField = TextFormField(
        autofocus: false,
        validator: validateEmail,
        onSaved: (value) => _username = value,
        decoration: buildInputDecoration("Email", Icons.email_rounded));

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Password", Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.register(_username, _password, _confirmPassword).then((response) {
          if (response['status']) {
            // User user = response['data'];
            // Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/LoginPage');
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.blue],
          ),
        ),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 105.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        "Exam Master",
                        style: TextStyle(
                            fontSize: 25.0, color: Color(0xfff063057)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Image.asset('asserts/logo.png'),
                    ),
                    SizedBox(height: 15.0),
                    SizedBox(height: 5.0),
                    usernameField,
                    SizedBox(height: 15.0),
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(height: 15.0),
                    SizedBox(height: 10.0),
                    confirmPassword,
                    SizedBox(height: 20.0),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : longButtons("Sign Up", doRegister),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//   return Scaffold(
//     appBar: AppBar(
//       brightness: Brightness.light,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: Container(
//         margin: EdgeInsets.all(15),
//         width: 50,
//         height: 50,
//         // decoration: BoxDecoration(
//         //   borderRadius: BorderRadius.all(Radius.circular(10)),
//         //   color: Colors.grey.withOpacity(0.5),
//         // ),
//         child: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     ),
//     body: Column(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(top: 30, left: 30, right: 30),
//           child: Image.asset('assets/image.png'),
//         ),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(40)),
//               color: Colors.grey.withOpacity(0.3),
//             ),
//             child: Container(
//               padding: EdgeInsets.only(left: 20, right: 20, top: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       "Full Name",
//                       style: TextStyle(
//                         color: Colors.black.withOpacity(0.7),
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       color: Colors.grey.withOpacity(0.2),
//                     ),
//                     child: TextField(
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black),
//                       decoration: InputDecoration(
//                           hintText: "Example : John Doe",
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       "Email Address",
//                       style: TextStyle(
//                         color: Colors.black.withOpacity(0.7),
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       color: Colors.grey.withOpacity(0.2),
//                     ),
//                     child: TextField(
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black),
//                       decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email_rounded,
//                           color: Color(0xfff063057)),
//                           hintText: "Example : test@test.com",
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       "Password",
//                       style: TextStyle(
//                         color: Colors.black.withOpacity(0.7),
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       color: Colors.grey.withOpacity(0.2),
//                     ),
//                     child: Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextField(
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black),
//                             obscureText: hidePwd,
//                             decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.lock_rounded,
//                                 color: Color(0xfff063057)),
//                                 hintText: "****", border: InputBorder.none),
//                           ),
//                         ),
//                         Container(
//                           height: 50,
//                           width: 50,
//                           child: IconButton(
//                             onPressed: togglePwdVisibility,
//                             icon: IconButton(
//                               onPressed: () {},
//                               icon: hidePwd == true
//                                   ? Icon(Icons.visibility_off)
//                                   : Icon(Icons.visibility),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 5, right: 20),
//                     alignment: Alignment.centerRight,
//                     child: Text("Forgot Password"),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: Color(0xfff063057),
//                         borderRadius: BorderRadius.all(Radius.circular(25))),
//                     child: InkWell(
//                       child: Center(
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text("Already have an account "),
//                       InkWell(
//                         onTap: openLoginPage,
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                               color: Colors.deepPurple,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// void openLoginPage() {
//   Navigator.pop(context);
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => LoginPage()));
// }

// void togglePwdVisibility() {
//   hidePwd = !hidePwd;
//   setState(() {});
// }
