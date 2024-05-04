import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_processing/screen/loginScreen.dart';
import 'package:order_processing/screen/signUpScreen.dart';
import 'package:order_processing/utills/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController forgetPasswordController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Container(
                height: 200,

                child: Lottie.asset("assets/welcome.json"),
              ),
              FadeInLeft(
                duration: Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: forgetPasswordController,

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
              SizedBox(height: 30.0,),

              FadeInUp(
                duration: Duration(milliseconds: 1800),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF448AFF,),
                    minimumSize:Size(200, 50),
                  ),
                  onPressed: ()async{
                    var forgotEmail=forgetPasswordController.text.trim();
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: forgotEmail
                      ).then((value) => {
                        print("Email sent"),
                        Get.off(()=>LoginScreen())
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email Successfully Sent!")),
                      );
                    } on FirebaseAuthException catch (e){
                      print("Error:$e");
                    }
                  },
                  child: Text("Recover Password",
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
