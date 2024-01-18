// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:poaiapp/Model/contentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  SharedPreferences? pref;
  RxString userInput = "".obs;

  RxList<Content> contents = <Content>[Content(1, "ai", "hey")].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // Future.delayed(Duration(seconds: 2), () {
    //   print("Controller init succed");
    //   print("Splash Screen removed");
    //   FlutterNativeSplash.remove();
    // });

    pref = await SharedPreferences.getInstance();
    getContents();

    // print(pref!.containsKey("key"));

    textEditingController.addListener(() {
      userInput.value = textEditingController.value.text;
    });
  }

  sendButton() async {
    Content userinput =
        Content(DateTime.now().millisecondsSinceEpoch, "user", userInput.value);
    // clear user input
    userInput.value = "";
    textEditingController.clear();

    // append to chat list view
    contents.add(userinput);

    // encoding object
    List<String> contentString = [];
    for (Content element in contents) {
      contentString.add(json.encode(element.toJson()));
    }
    // save to local disk
    await pref!.setStringList(
      "contents",
      contentString,
    );
    print("Content saved to local disk succeed");
  }

  getContents() {
    if (pref!.containsKey("contents")) {
      print("Fetching contents");
      List<String> contentss = pref!.getStringList("contents")!;

      List<Content> contentDecoded = [];
      for (String element in contentss) {
        contentDecoded.add(Content.fromJson(json.decode(element)));
      }

      contents.addAll(contentDecoded);
      FlutterNativeSplash.remove();

      print("Fetch contents done");
    } else {
      FlutterNativeSplash.remove();
      print("No Contents to fetch");
    }
  }

  reset() {
    if (pref!.containsKey("contents")) {
      contents.clear();
      userInput.value = "";
      textEditingController.clear();
      pref!.remove("contents");
    }
  }
}
