import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:order_processing/screen/forgotPasswordScreen.dart';
import 'package:order_processing/screen/homeScreen.dart';
import 'package:order_processing/screen/signUpScreen.dart';
import 'package:order_processing/utills/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController LoginEmailController=TextEditingController();
  TextEditingController LoginPasswordController=TextEditingController();
  bool obscureText=true;

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

                controller: LoginEmailController,

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

                controller: LoginPasswordController,
                obscureText: obscureText,

                decoration: InputDecoration(

                  hintText: "Enter Your Password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),

                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        obscureText=!obscureText;
                      });
                    },
                      child:obscureText? Icon(Icons.visibility):
                      Icon(Icons.visibility_off)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: (){
                Get.to(()=>ForgotPasswordScreen());
              },
              child: Container(
                alignment: Alignment.topRight,
                  child: Text("Forgot Password",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold),),
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

                  var loginemail=LoginEmailController.text.trim();
                  var loginPassword=LoginPasswordController.text.trim();
                  EasyLoading.show();

                  try{
                    final User? firebaseUser=(await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email:loginemail,
                      password:loginPassword,
                    )).user;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Login successful!")),
                    );
                    EasyLoading.dismiss();

                    if (firebaseUser!=null){
                      Get.to(()=>HomeScreen());
                    }else {
                      print("check email and password");
                      EasyLoading.dismiss();
                    }

                  } on FirebaseAuthException catch (e){
                    print("Error $e");
                    EasyLoading.dismiss();
                  }
                  },
                  child: Text("Login",
                    style: TextStyle(color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Get.to(()=>SignUpScreen());
              },
              child: Container(
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Don't Have An Account?  Sign Up"),
                    ),
                ),
              ),
            )
          ],
        ),
        ),
      ),
    );
  }
}
