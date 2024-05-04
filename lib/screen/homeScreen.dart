import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:order_processing/screen/createNewOrderScreen.dart';
import 'package:order_processing/screen/loginScreen.dart';
import 'package:order_processing/utills/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(AppConstant.appName,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>CreateOrderScreen());
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 15.0,
                  child: Icon(Icons.add)),
            ),
          )
        ],
      ),
      drawer: Drawer(
              backgroundColor: Colors.blueAccent,


             child: ListView(

               children: [
               UserAccountsDrawerHeader(

                   currentAccountPicture: CircleAvatar(
                     child: Text("M"),
                   ),
                   accountName:Text("Mujahid Sadiq") ,
                   accountEmail: Text("subhanmustafai@gmail.com"),
                 decoration: BoxDecoration(color: Colors.blueAccent),
               ),
                 ListTile(
                   title: Text("Home",),
                   leading: Icon(Icons.home),
                   trailing: Icon(Icons.arrow_circle_right),
                 ),
                 ListTile(
                   title: Text("Add New Order",),
                   leading: Icon(Icons.add),
                   trailing: Icon(Icons.arrow_circle_right),
                 ),
                 ListTile(
                   title: Text("Info",),
                   leading: Icon(Icons.info),
                   trailing: Icon(Icons.arrow_circle_right),
                 ),
                 Divider(
                   height: 10.0,
                   color: Colors.grey,
                 ),
                 ListTile(
                   title: Text("Help",),
                   leading: Icon(Icons.help),
                   trailing: Icon(Icons.arrow_circle_right),
                 ),
                 Divider(
                   height: 10.0,
                   color: Colors.grey,
                 ),
                 ListTile(
                   title: Text("Logout",),
                   leading: Icon(Icons.logout),
                   trailing: Icon(Icons.arrow_circle_right),
                   onTap: ()async{
                     await FirebaseAuth.instance.signOut();
                     Get.offAll(()=>LoginScreen());
                   },
                 ),
             ],
           ),
      ),
      body: Container(
        child:StreamBuilder(
          stream:FirebaseFirestore.instance
              .collection("orders")
              .where("userId", isEqualTo: user!.uid)
              .snapshots() ,
          builder:(BuildContext context, snapshot) {
                  if (snapshot.hasError){
                    return  Center(
                      child: Text("Error"),
                    );
                  }
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CupertinoActivityIndicator() ,
                    );
                  }

                  if (snapshot==null){
                    return  Center(
                      child: Text("Error"),
                    );
                  }

                  if (snapshot!=null && snapshot.data!=null){
                    return
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          String status=snapshot.data!.docs[index]["status"];
                          var docId=snapshot.data!.docs[index].id;
                      return Card(
                        child: FadeInLeft(
                          child: ListTile(
                            title: Text(snapshot.data!.docs[index]["productName"]),
                            subtitle:status =="pending"? Text(snapshot.data!.docs[index]["status"],
                              style: TextStyle(color: Colors.green),
                            ): Text(snapshot.data!.docs[index]["status"],
                              style: TextStyle(color: Colors.red),
                            ),
                            leading: CircleAvatar(
                              child: Text(index.toString()),
                            ),
                            trailing: CircleAvatar(
                              child: InkWell(
                                onTap: (){
                                  Get.defaultDialog(
                                    title: "Do you want to upadate your order? ",
                                    content: Text(''),
                                    onCancel: (){},
                                    onConfirm: ()async{
                                      EasyLoading.show();
                                      await FirebaseFirestore.instance
                                          .collection("orders")
                                          .doc(docId)
                                          .update(
                                        {"status":'sold'}
                                      );
                                      EasyLoading.dismiss();
                                      Get.back();
                                    }
                                  );
                                },
                                  child: Icon(Icons.edit),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    );

                  }
                  return Container();
          } ,
        )




      ),
    );
  }
}
