// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poaiapp/Controller/mainController.dart';
import 'package:poaiapp/colors.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Scaffold(
      backgroundColor: Clr.darkGray,
      appBar: AppBar(
        backgroundColor: Clr.darkGray,
        elevation: 0.0,
        shape: Border(
          bottom: BorderSide(
            color: Clr.gray800,
            width: 1,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Clr.lightGray,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
              color: Clr.lightGray, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          Text(
            "Chat",
            style: TextStyle(
                fontSize: 12,
                letterSpacing: -0.4,
                fontWeight: FontWeight.w600,
                color: Clr.gray500),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Clr.lightGray,
                  title: Text(
                    "Are you sure?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Clr.gray800),
                  ),
                  // content: Text("Are you sure?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          mainController.reset();
                          Get.back();
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Clr.gray800),
                        )),
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                barrierDismissible: false,
              );
            },
            child: Container(
              color: Clr.darkGray,
              height: 48,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reset Chat",
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: -0.4,
                        fontWeight: FontWeight.w600,
                        color: Clr.lightGray),
                  ),
                  Icon(
                    Icons.restart_alt,
                    color: Clr.lightGray,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "About",
            style: TextStyle(
                fontSize: 12,
                letterSpacing: -0.4,
                fontWeight: FontWeight.w600,
                color: Clr.gray500),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Clr.darkGray,
              height: 48,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terms of Service",
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: -0.4,
                        fontWeight: FontWeight.w600,
                        color: Clr.lightGray),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Clr.lightGray,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Clr.darkGray,
              height: 48,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: -0.4,
                        fontWeight: FontWeight.w600,
                        color: Clr.lightGray),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Clr.lightGray,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
