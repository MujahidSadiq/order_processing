import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:order_processing/screen/homeScreen.dart';
import 'package:order_processing/screen/loginScreen.dart';
import 'package:order_processing/screen/signUpScreen.dart';
import 'package:order_processing/utills/constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    await Firebase.initializeApp(options:const FirebaseOptions(
      projectId:"orderprocessing-414ef",
      apiKey:"AIzaSyCKBMThzn-ahMg0QvgaHCfQWOner3f3Zx8",
      appId:"1:706303084010:android:90d6af3bf5bc82bcd6de93",
      messagingSenderId:"",

    ));
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;

  @override
  void initState() {
    user=FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title:AppConstant.appName,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:user!=null? HomeScreen():LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}


