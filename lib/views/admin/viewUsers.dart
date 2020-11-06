import 'package:first_project/providers/user.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserListProvider userV = new UserListProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff063057),
        title: Text('User List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: userV.getUserList(),
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
            snapshoptData['id'] ?? '',
            style: TextStyle(fontSize: 13.0),
          ),
        ),
        title: Text(snapshoptData['name'] ?? ''),
        subtitle: Text(snapshoptData['email'] ?? ''),
      ),
    );
  }
}
