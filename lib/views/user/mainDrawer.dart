import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Color(0xfff063057),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                   margin: EdgeInsets.only(
                     top: 30,
                     bottom: 10,
                   ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2, blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 10),
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-photo%2Fhands-university-student-holding-pen-260nw-747984823.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fexams&tbnid=3ZitivcZvyA5KM&vet=12ahUKEwjd6bP837btAhXRQHwKHatVB8EQMygCegUIARDYAQ..i&docid=KK2esUJJm0puHM&w=390&h=280&q=exam%20image&ved=2ahUKEwjd6bP837btAhXRQHwKHatVB8EQMygCegUIARDYAQ'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  
                  child: Container(
                  height: 40,
                  width: 40,                 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    color: Colors.green,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                 ),
                ),               
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();          
            //Navigator.of(context).pushNamed(DetailScreen.routeName)
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: null,
        ),
      ],
    ));
  }
}
