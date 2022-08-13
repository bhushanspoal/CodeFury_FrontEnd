import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_registration_model.dart';

class User_profile_page extends StatefulWidget {
  const User_profile_page({Key? key}) : super(key: key);

  @override
  State<User_profile_page> createState() => _User_profile_pageState();
}

class _User_profile_pageState extends State<User_profile_page> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal.shade500,
        body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/hustle.jpg'),
              radius: 70.0,
            ),
            Text(
              "${loggedInUser.firstName} ${loggedInUser.secondName}",
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
            SizedBox(width: 150, height: 10,
              child: Divider(
                color: Colors.black,
              )
              ,),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.amber,
                    size: 30,
                  ),
                  title: Text(
                    "${loggedInUser.email}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )
            ),

          ],
        )
        ),
    );
  }
}
