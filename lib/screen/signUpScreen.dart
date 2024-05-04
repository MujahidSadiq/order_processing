
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_processing/utills/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

import '../services/signUpServices.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController signNameController=TextEditingController();
  TextEditingController signEmailController=TextEditingController();
  TextEditingController signPasswordController=TextEditingController();
  User? CurrentUser=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(
          AppConstant.appName,style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                height: 200,

                child: Lottie.asset("assets/welcome.json"),
              ),
              FadeInLeft(
                duration: Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: signNameController,

                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              FadeInLeft(
                duration: Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: signEmailController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              FadeInLeft(
                duration: Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: signPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(

                    hintText: "Enter Your Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              FadeInUp(
                duration: Duration(milliseconds: 1800),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF448AFF,),
                    minimumSize:Size(200, 50),
                  ),
                  onPressed: ()async{
                    var userName =signNameController.text.trim();
                    var userEmail=signEmailController.text.trim();
                    var userPassword=signPasswordController.text.trim();
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: userEmail,
                        password:userPassword
                    ).then((value) => {
                      signUpUser(
                        userName,
                        userEmail,
                        userPassword,
                      ),
                    });
                  },
                  child: Text("Sign Up",
                    style: TextStyle(color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
