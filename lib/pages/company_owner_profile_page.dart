import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/company_registration_model.dart';

class Company_owner_profile_page extends StatefulWidget {
  const Company_owner_profile_page({Key? key}) : super(key: key);

  @override
  State<Company_owner_profile_page> createState() => _Company_owner_profile_pageState();
}

class _Company_owner_profile_pageState extends State<Company_owner_profile_page> {
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
                "Company Name:${loggedInUser.companyName} ",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Owner Name:${loggedInUser.ownerName}",
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
