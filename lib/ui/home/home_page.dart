import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm_demo/ui/home/controller/home_controller.dart';
import 'package:mvvm_demo/utils/Gap.dart';
import 'package:mvvm_demo/utils/color_helper.dart';


class HomePage extends StatelessWidget {

  final User user;
  HomePage({required this.user});

  var now = DateTime.now();
  var formatterDate = DateFormat("yyy-MM-dd");
  var formatterTime = DateFormat("HH : mm a");
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: Container(),
        centerTitle: true,
        title: Text("MVVM Demo"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(child: Icon(Icons.logout),
            onTap: (){
              print("Logout");
              user.delete();
            },),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text("Welcome ${_homeController.username.value}",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700
                  ),)),
                VerticalGap(gap: 40.0),
                RichText(text: TextSpan(
                    text: 'Date : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(text: formatterDate.format(now),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),)
                    ]
                )),
                VerticalGap(gap: 12.0),
                RichText(text: TextSpan(
                    text: 'Time : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(text: formatterTime.format(now),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),)
                    ]
                )),
                VerticalGap(gap: 12.0),
                RichText(text: TextSpan(
                    text: 'Username/Email : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      WidgetSpan(child:   TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLength: 40,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey[200] ?? Colors.grey)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey)
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: "Username/Email"

                        ),
                        controller: _homeController.usernameController,
                        onChanged: (String? value){
                          if(value?.isNotEmpty ?? false){
                            _homeController.username.value = value!;
                          }else{
                            _homeController.username.value = "";
                          }
                        },
                      ))
                    ]
                )),
                VerticalGap(gap: 30.0),
                RichText(text: TextSpan(
                    text: 'Medications : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(text: "Medication Class 1",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),)
                    ]
                )),
                VerticalGap(gap: 12.0),
                Obx(()=>
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("AssociatedDrug#1",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),),
                                    VerticalGap(gap: 20.0),
                                    RichText(text: TextSpan(
                                        text: 'Name : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className1.length != 0
                                              ? _homeController.className1.value[0].associatedDrug![0].name
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Dose : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className1.length != 0
                                              ? _homeController.className1.value[0].associatedDrug![0].dose
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Strength : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className1.length != 0
                                              ? _homeController.className1.value[0].associatedDrug![0].strength
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    ))
                                  ]
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("AssociatedDrug#2",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),),
                                    VerticalGap(gap: 20.0),
                                    RichText(text: TextSpan(
                                        text: 'Name : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className1.length != 0
                                              ? _homeController.className1.value[0].associatedDrug2![0].name
                                              : "",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Dose : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className1.length != 0
                                              ? _homeController.className1.value[0].associatedDrug2![0].dose
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Strength : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className1.length != 0
                                              ? _homeController.className1.value[0].associatedDrug2![0].strength
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    ))
                                  ]
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                VerticalGap(gap: 20.0),
                RichText(text: TextSpan(
                    text: 'Medications : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(text: "Medication Class 2",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),)
                    ]
                )),
                VerticalGap(gap: 12.0),
                Obx(()=>
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("AssociatedDrug#1",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),),
                                    VerticalGap(gap: 20.0),
                                    RichText(text: TextSpan(
                                        text: 'Name : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className2.length != 0
                                              ? _homeController.className2.value[0].associatedDrug![0].name
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Dose : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className2.length != 0
                                              ? _homeController.className2.value[0].associatedDrug![0].dose
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Strength : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className2.length != 0
                                              ? _homeController.className2.value[0].associatedDrug![0].strength
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    ))
                                  ]
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("AssociatedDrug#2",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),),
                                    VerticalGap(gap: 20.0),
                                    RichText(text: TextSpan(
                                        text: 'Name : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className2.length != 0
                                              ? _homeController.className2.value[0].associatedDrug2![0].name
                                              : "",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Dose : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className2.length != 0
                                              ? _homeController.className2.value[0].associatedDrug2![0].dose
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    )),
                                    VerticalGap(gap: 12.0),
                                    RichText(text: TextSpan(
                                        text: 'Strength : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: _homeController.className2.length != 0
                                              ? _homeController.className2.value[0].associatedDrug2![0].strength
                                              : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),)
                                        ]
                                    ))
                                  ]
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),

    );
  }
}

