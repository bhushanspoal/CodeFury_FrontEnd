import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury_start_up_app/pages/user_chatbot.dart';
import 'package:codefury_start_up_app/pages/user_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/company_registration_model.dart';

class Company_homepage extends StatefulWidget {
  const Company_homepage({Key? key}) : super(key: key);

  @override
  State<Company_homepage> createState() => _Company_homepageState();
}

class _Company_homepageState extends State<Company_homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  CompanyModel loggedInUser = CompanyModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("companies")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = CompanyModel.fromMap(value.data());
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
      appBar: AppBar(title: Text("Welcome ${loggedInUser.companyName} ${loggedInUser.ownerName}"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout(context);
                //Implement logout functionality
              }),
        ],),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => User_login_page()));
  }
}
