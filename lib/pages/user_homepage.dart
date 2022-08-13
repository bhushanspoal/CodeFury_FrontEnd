import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury_start_up_app/pages/user_chatbot.dart';
import 'package:codefury_start_up_app/pages/user_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_registration_model.dart';

class User_homepage extends StatefulWidget {
  const User_homepage({Key? key}) : super(key: key);

  @override
  State<User_homepage> createState() => _User_homepageState();
}

class _User_homepageState extends State<User_homepage> {
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    User_chatbot()));
      },

        child: Icon(Icons.message, color: Colors.white),
        backgroundColor: Colors.blueAccent,),
      appBar: AppBar(title: Text("Welcome ${loggedInUser.firstName} ${loggedInUser.secondName}"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout(context);
                //Implement logout functionality
              }),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => User_login_page()));
  }
}