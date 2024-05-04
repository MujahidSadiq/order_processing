

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_processing/screen/loginScreen.dart';

signUpUser(
    String userName,
    String userEmail,
    String userPassword
    )async
{
  User? userid=FirebaseAuth.instance.currentUser;
  try{
    await FirebaseFirestore.instance.collection("user").doc(userid!.uid).set({
      "username":userName,
      'userEmail':userEmail,
      'userPassword':userPassword,
      "userId":userid,
      "createdAt":DateTime.now(),
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(()=>LoginScreen()),
    });
    

  }on FirebaseAuthException catch(e){
    print("Error $e");
  }
}