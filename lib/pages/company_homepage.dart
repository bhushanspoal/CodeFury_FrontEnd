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
      appBar: AppBar(title: Text("Welcome"),),
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/hustle.jpg", fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.companyName} ${loggedInUser.ownerName}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    logout(context);
                  }),
              FloatingActionButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            User_chatbot()));
              },
                child: Icon(Icons.message, color: Colors.white),
                backgroundColor: Colors.blueAccent,)
            ],
          ),
        ),
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => User_login_page()));
  }
}
