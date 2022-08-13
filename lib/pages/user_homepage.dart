import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codefury_start_up_app/models/company_api_model.dart';
import 'package:codefury_start_up_app/pages/user_chatbot.dart';
import 'package:codefury_start_up_app/pages/user_invest_page.dart';
import 'package:codefury_start_up_app/pages/user_login_page.dart';
import 'package:codefury_start_up_app/pages/user_profile_page.dart';
import 'package:codefury_start_up_app/services/company_api_services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../models/user_registration_model.dart';

class User_homepage extends StatefulWidget {
  const User_homepage({Key? key}) : super(key: key);

  @override
  State<User_homepage> createState() => _User_homepageState();
}

class _User_homepageState extends State<User_homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  List<CompanyApi>?companyapi;
  var isLoaded=false;
  @override
  void initState() {
    super.initState();

    getData();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  getData() async{
    companyapi = await RemoteService().getCompanyApi();
    if (companyapi != null)
    {
      setState(() {
        isLoaded=true;
      });
    }
  }


  
  Widget build(BuildContext context) {
    return Scaffold(


  floatingActionButton: SpeedDial(
    animatedIcon: AnimatedIcons.add_event,
    children: [
      SpeedDialChild(
        child: Icon(Icons.message),
        label: 'ChatBot',
        onLongPress: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      User_chatbot()));
        }
      ),
      SpeedDialChild(
          child: Icon(Icons.attach_money_outlined),
          label: 'Invest',
          onLongPress: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        User_invest_page()));
          }
      ),
      SpeedDialChild(
        child: Icon(Icons.person),
        label: 'Profile',
        onLongPress: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      User_profile_page()));
        }
      )
    ],
  ),
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
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: companyapi?.length,
            itemBuilder: (context,index){
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 5,),
              child: Column(
                children: [
                  Text(companyapi![index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  Text(companyapi![index].info,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                  Text("Contact Deatils are Owner's name: ${companyapi![index].ownerName} and "
                      "email : ${companyapi![index].mailId}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text("The amount of money pledged ${companyapi![index].amount} Lacs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 25,)
                ],
              ),
            ),
          );
        }),
        replacement: const Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => User_login_page()));
  }
}