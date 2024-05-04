import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:order_processing/screen/homeScreen.dart';
import 'package:order_processing/utills/constant.dart';


class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {

  TextEditingController productNameController=TextEditingController();
  TextEditingController clientNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController buyPriceController=TextEditingController();
  TextEditingController salePriceController=TextEditingController();
  TextEditingController saleDateController=TextEditingController();
  User? user= FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(AppConstant.appName,style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              FadeInLeft(
                duration: Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: "Enter Which You Want ",
                    labelText: "Product Name",
                    prefixIcon: Icon(Icons.shopping_cart),
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
                  controller: clientNameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    labelText: "Client Name",
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
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone),
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
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Client Address",
                    labelText: "Address",
                    prefixIcon: Icon(Icons.home),
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
                  controller: buyPriceController,
                  decoration: InputDecoration(
                    hintText: "Enter Buy Price",
                    labelText: "Buy Price",
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
                  controller: salePriceController,
                  decoration: InputDecoration(
                    hintText: "Enter Sale Price",
                    labelText: "Sale Price ",
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
                  controller: saleDateController,
                  decoration: InputDecoration(
                    hintText: "Enter Sale Date",
                    labelText: "Sale Date",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF448AFF),
                  minimumSize: Size(200, 50)
                ),
                onPressed: ()async{
                  EasyLoading.show();
                  var profit= int.parse(salePriceController.text)- int.parse(buyPriceController.text);
                  Map<String,dynamic> userOrderMap={

                    'userId':user?.uid,
                    'productName':productNameController.text.trim(),
                    'clientName':clientNameController.text.trim(),
                    'phoneNumber':phoneController.text.trim(),
                    "address":addressController.text.trim(),
                     'buyPrice':buyPriceController.text.trim(),
                    "salePrice": salePriceController.text.trim(),
                    "saleDate":saleDateController.text.trim(),
                    "profit":profit,
                    "createdAt":DateTime.now(),
                    "status":"pending",


                  };
                  await FirebaseFirestore.instance.collection("orders").doc()
                      .set(
                         userOrderMap
                  );
                  Get.off(()=>HomeScreen());
                  EasyLoading.dismiss();
                },
                  child: Text("Create Order ",style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.3,
                      fontSize: 16.0),
                  ),
              ),
        ],
          ),
        ),
      ),
    );
  }
}
