import 'package:flutter/material.dart';

class User_homepage extends StatefulWidget {
  const User_homepage({Key? key}) : super(key: key);

  @override
  State<User_homepage> createState() => _User_homepageState();
}

class _User_homepageState extends State<User_homepage> {
  @override
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
              // Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     )),
              // Text("${loggedInUser.email}",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     )),
              SizedBox(
                height: 15,
              ),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    //logout(context);
                  }),
            ],
          ),
        ),
      ),
      );
  }
}
