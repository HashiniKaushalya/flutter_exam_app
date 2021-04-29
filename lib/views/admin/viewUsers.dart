import 'dart:convert';
import 'package:first_project/models/user.dart';
import 'package:first_project/utils/api_url.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  final User users;
  UserView(this.users);
  @override
  _UserViewState createState() => _UserViewState(users);
}

class _UserViewState extends State<UserView> {
  final User users;
  _UserViewState(this.users);

  @override
  void initState() {
    getUserList();
    super.initState();
  }

  List<User> userList;

  getUserList() async {
    var res = await AppUrl.getUserList();
    try {
      if (res.statusCode == 200) {
        Iterable list = json.decode(res.body);
        setState(() {
          userList = list.map((e) => User.fromJson(e)).toList();
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
        title: Text('User List'),
      ),
      body: userList == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return UserCard(userList[index], index);
                  }),
      ),
    );
  }
}

// ignore: must_be_immutable
class UserCard extends StatefulWidget {
  final User users;
  int index;
  UserCard(this.users, this.index);
  @override
  _UserCardState createState() => _UserCardState(users, index);
}

class _UserCardState extends State<UserCard> {
  _UserCardState(this.users, this.index);
  final User users;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[100],
        ),
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(
            users.name ?? 'default',
          ),
          subtitle: Text(
            users.email ?? 'default'
          ),
        ),
      ),
    );
  }
}
