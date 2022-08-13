import 'package:codefury_start_up_app/pages/company_registration_page.dart';
import 'package:codefury_start_up_app/pages/user_registration_page.dart';
import 'package:flutter/material.dart';

class User_login_page extends StatefulWidget {
  const User_login_page({Key? key}) : super(key: key);

  @override
  State<User_login_page> createState() => _User_login_pageState();
}

class _User_login_pageState extends State<User_login_page> {
  final _formKey=GlobalKey<FormState>();

  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();



  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus:false,
      controller:emailController,
      keyboardType:TextInputType.emailAddress,
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
          onPressed:(){},
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
}
