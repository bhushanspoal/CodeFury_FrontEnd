import 'package:codefury_start_up_app/pages/company_registration_page.dart';
import 'package:codefury_start_up_app/pages/user_homepage.dart';
import 'package:codefury_start_up_app/pages/user_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class User_login_page extends StatefulWidget {
  const User_login_page({Key? key}) : super(key: key);

  @override
  State<User_login_page> createState() => _User_login_pageState();
}

class _User_login_pageState extends State<User_login_page> {
  final _formKey=GlobalKey<FormState>();

  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus:false,
      controller:emailController,
      keyboardType:TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved:(value)
        {
          emailController.text= value!;
        },
      textInputAction: TextInputAction.next,
        decoration:InputDecoration(
            prefixIcon:Icon(Icons.mail),
            contentPadding:EdgeInsets.fromLTRB(20,15,20,15),
        hintText:"Email",
        border:OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
    ),// OutlineInput Border
    ));
    final passwordField = TextFormField(
      autofocus:false,
      controller:passwordController,
      obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
      onSaved:(value)
      {
        passwordController.text= value!;
      },
      textInputAction: TextInputAction.done,
        decoration:InputDecoration(
          prefixIcon:Icon(Icons.vpn_key),
          contentPadding:EdgeInsets.fromLTRB(20,15,20,15),
          hintText:"Password",
          border:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
          ),// OutlineInput Border
        )
    );
    final loginButton=Material(
      elevation:5,
      borderRadius:BorderRadius.circular(30),
      color:Colors.blueAccent,
      child:MaterialButton(
          padding:EdgeInsets.fromLTRB(20,15,20,15),
          minWidth:MediaQuery.of(context).size.width,
          onPressed:(){
            signIn(emailController.text, passwordController.text);
          },
          child:Text(
            "Login",
            textAlign:TextAlign.center,
            style:TextStyle(fontSize:20,color:Colors.white,fontWeight:FontWeight.bold),// TextStyle
          )),// Text // MaterialButton
    );// Material

    return Scaffold(
      backgroundColor:Colors.white,
      body:Center(
      child:SingleChildScrollView(
      child:Container(
      color:Colors.white,
      child:Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              SizedBox(
                height: 200,
                child: Image.asset("assets/hustle.jpg",fit: BoxFit.contain,),
              ),
              const SizedBox(height: 45,),
            emailField,
              const SizedBox(height: 20,),
            passwordField,
              const SizedBox(height: 20,),
              loginButton,
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [Text("Don't have an account ? SignUp as "),
                GestureDetector(onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              User_registration_page()));
                },
                    child: const Text("User",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    ),
                ),
                  const Text(" or "),
                  GestureDetector(onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Company_registration_page()));
                  },
                    child: const Text("Owner",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              )
            ]
        ),
        ),
      ),
    ),
    ),
    ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => User_homepage())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

}
