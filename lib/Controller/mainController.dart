// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:poaiapp/Model/contentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class MainController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  SharedPreferences? pref;
  RxString userInput = "".obs;
  RxBool isGenerating = false.obs;
  RxBool isEnabled = true.obs;

  RxString output = "".obs;

  RxList<Content> contents = <Content>[].obs;

  RxBool isDarkMode = true.obs;

  RxBool isReseted = false.obs;

  RxList<String> cvmodes = [
    "Personal Assistant",
    "Writing Assistant",
    "Cooking Expert",
    "Girlfriend",
    "Boyfriend",
  ].obs;

  RxString cvmode = "Personal Assistant".obs;
  RxList<String> purchasedModes = <String>[].obs;

  static const platform = const MethodChannel('poai.com/chat');

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    // Timer(Duration(seconds: 1), () {
    //   FlutterNativeSplash.remove();
    //   textEditingController.addListener(() {
    //     userInput.value = textEditingController.value.text;
    //   });
    // });

    appconfig();
    platform.setMethodCallHandler((call) async {
      if (call.method == "appconfigdone") {
        print("app config done received from flutter");
        if (call.arguments == "done") {
          pref = await SharedPreferences.getInstance();
          getSetting();
          getContents();

          // print(pref!.containsKey("key"));

          textEditingController.addListener(() {
            userInput.value = textEditingController.value.text;
          });
        }
      } else if (call.method == "sendmsgswift") {
        print("message received from swift: ${call.arguments}");
        print("type of data: ${call.arguments.runtimeType}");

        Map args = call.arguments;
        print("message: ${args["message"]}");
        print("isGenerating: ${args["isGenerating"]}");
        output.value = args["message"].toString();

        if (args["isGenerating"] == false) {
          contents.removeLast();
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            output.value,
          ));
          output.value = "";

          List<String> contentString = [];
          for (Content element in contents) {
            contentString.add(json.encode(element.toJson()));
          }
          await pref!.setStringList(
            "contents",
            contentString,
          );
          isGenerating.value = false;
          isEnabled.value = true;

          print("Content saved to local disk succeed");
        }
      } else if (call.method == "reset") {
        if (call.arguments == "done") {
          Get.back(closeOverlays: true);
          isGenerating.value = false;
          isEnabled.value = true;

          // if (Get.isDialogOpen != null) {
          //   if (Get.isDialogOpen!) {
          //     Get.back();
          //   }
          // }
          Get.snackbar(
            "Reset successful!",
            "Resetting chat complete",
            backgroundColor: Clr.neonGreen,
            colorText: Clr.darkGray,
            duration: Duration(seconds: 2),
          );
        }
      } else if (call.method == "sendmsgswift2") {
        Map args = call.arguments;

        if (args["isGenerating"] == false) {
          String mode = cvmode.value;
          if (mode == "Girlfriend") {
            contents.add(Content(
              DateTime.now().millisecondsSinceEpoch,
              "bot",
              "Hello, my darling. I'm your enchantress in the art of pleasure. Let's dive deep into our fantasies and turn them into thrilling realities.",
            ));
          } else if (mode == "Boyfriend") {
            contents.add(Content(
              DateTime.now().millisecondsSinceEpoch,
              "bot",
              "Hello, gorgeous. I'm your guide to uncharted pleasures. Let's explore our wildest fantasies and make them irresistibly real.",
            ));
          } else if (mode == "Cooking Expert") {
            contents.add(Content(
              DateTime.now().millisecondsSinceEpoch,
              "bot",
              "Hello, I can help you with recipes or anything else related to cooking.",
            ));
          } else if (mode == "Writing Assistant") {
            contents.add(Content(
              DateTime.now().millisecondsSinceEpoch,
              "bot",
              "Do you need assistance with your writing? I can write, edit, or proofread your work.",
            ));
          } else if (mode == "Personal Assistant") {
            contents.add(Content(
              DateTime.now().millisecondsSinceEpoch,
              "bot",
              "Hello how can I help you today?",
            ));
          }
          isGenerating.value = false;
          isEnabled.value = true;
          Get.back();
          if (Get.isBottomSheetOpen != null) {
            if (Get.isBottomSheetOpen!) {
              Get.back();
            }
          }
          Get.snackbar(
            "Change successful!",
            "Conversation mode changed",
            backgroundColor: Clr.neonGreen,
            colorText: Clr.darkGray,
            duration: Duration(seconds: 2),
          );
        }
      }
    });
  }

  appconfig() async {
    try {
      print("appconfig called from flutter");
      await platform.invokeMethod('appconfig');
    } on PlatformException catch (e) {
      print('네이티브 코드 실행 에러 : ${e.message}');
    }
  }

  getSetting() async {
    if (pref!.containsKey("darkmode")) {
      bool darkmode = pref!.getBool("darkmode")!;
      isDarkMode.value = darkmode;
    }
  }

  updateSetting(bool dm) async {
    await pref!.setBool("darkmode", dm);
  }

  // sendThroughSwift(String msg) async {
  //   print("send msg through swift succeed");
  //   try {
  //     await platform.invokeMethod('sendmsgflutter', msg);
  //   } on PlatformException catch (e) {
  //     print("Send msg through swift error: ${e.message}");
  //   }
  // }

  sendButton() async {
    try {
      if (isReseted.value == true) {
        if (cvmode.value == "Writing Assistant") {
          platform.invokeMethod('sendmsgflutter',
              "(Act as my Writing Assistant. Correct and proofread my writings) ${userInput.value}");
        } else if (cvmode.value == "Girlfriend") {
          platform.invokeMethod('sendmsgflutter',
              "(Act as my horny girlfriend. You talk sexy and fun.) ${userInput.value}");
        } else if (cvmode.value == "Boyfriend") {
          platform.invokeMethod('sendmsgflutter',
              "(Act as my horny boyfriend. You talk sexy and fun.) ${userInput.value}");
        } else if (cvmode.value == "Cooking Expert") {
          platform.invokeMethod('sendmsgflutter',
              "(Act as my personal cooking expert.) ${userInput.value}");
        } else {
          platform.invokeMethod('sendmsgflutter', userInput.value);
        }
        isReseted.value = false;
        print("msg have sent with prompt");
      } else {
        platform.invokeMethod('sendmsgflutter', userInput.value);
        print("msg have sent without prompt");
      }

      Content userinput = Content(
          DateTime.now().millisecondsSinceEpoch, "user", userInput.value);

      Content emptyOutput =
          Content(DateTime.now().millisecondsSinceEpoch, "bot", "");
      // clear user input
      userInput.value = "";
      textEditingController.text = "";

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
      print("Content saved to local disk succeed from send button");

      contents.add(emptyOutput);
      isGenerating.value = true;
      isEnabled.value = false;
    } on PlatformException catch (e) {
      print("Send msg through swift error: ${e.message}");
    }
  }

  getContents() async {
    if (pref!.containsKey("contents")) {
      print("Fetching contents");
      List<String> contentss = pref!.getStringList("contents")!;

      List<Content> contentDecoded = [];
      for (String element in contentss) {
        contentDecoded.add(Content.fromJson(json.decode(element)));
      }
      if (pref!.containsKey("purchasedMode")) {
        purchasedModes.addAll(pref!.getStringList("purchasedMode")!);
      }
      if (!purchasedModes.contains("Personal Assistant")) {
        purchasedModes.add("Personal Assistant");
      }
      if (!purchasedModes.contains("Writing Assistant")) {
        purchasedModes.add("Writing Assistant");
      }
      if (!purchasedModes.contains("Cooking Expert")) {
        purchasedModes.add("Cooking Expert");
      }

      if (pref!.containsKey("chatMode")) {
        String mode = pref!.getString("chatMode")!;
        if (mode == "Girlfriend") {
          // contents.add(Content(
          //   DateTime.now().millisecondsSinceEpoch,
          //   "bot",
          //   "Hello, my darling. I'm your enchantress in the art of pleasure. Let's dive deep into our fantasies and turn them into thrilling realities.",
          // ));
          cvmode.value = "Girlfriend";
        } else if (mode == "Boyfriend") {
          // contents.add(Content(
          //   DateTime.now().millisecondsSinceEpoch,
          //   "bot",
          //   "Hello, gorgeous. I'm your guide to uncharted pleasures. Let's explore our wildest fantasies and make them irresistibly real.",
          // ));
          cvmode.value = "Boyfriend";
        } else if (mode == "Cooking Expert") {
          // contents.add(Content(
          //   DateTime.now().millisecondsSinceEpoch,
          //   "bot",
          //   "Hey there, handsome. I'm your partner in crafting unforgettable moments. Let's unleash our deepest fantasies and bring them to life with a touch of our unique magic.",
          // ));
          cvmode.value = "Cooking Expert";
        } else if (mode == "Writing Assistant") {
          // contents.add(Content(
          //   DateTime.now().millisecondsSinceEpoch,
          //   "bot",
          //   "Do you need assistance with your writing? I can write, edit, or proofread your work.",
          // ));
          cvmode.value = "Personal Assistant";
        } else if (mode == "Personal Assistant") {
          // contents.add(Content(
          //   DateTime.now().millisecondsSinceEpoch,
          //   "bot",
          //   "Hello how can I help you today?",
          // ));
          cvmode.value = "Personal Assistant";
        }
      } else {
        // contents.add(Content(
        //   DateTime.now().millisecondsSinceEpoch,
        //   "bot",
        //   "Do you need assistance with your writing? I can write, edit, or proofread your work.",
        // ));
        cvmode.value = "Personal Assistant";
      }

      contents.addAll(contentDecoded);
      FlutterNativeSplash.remove();

      print("Fetch contents done");
    } else {
      FlutterNativeSplash.remove();

      if (pref!.containsKey("chatMode")) {
        String mode = pref!.getString("chatMode")!;
        if (mode == "Girlfriend") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello, my darling. I'm your enchantress in the art of pleasure. Let's dive deep into our fantasies and turn them into thrilling realities.",
          ));
          cvmode.value = "Girlfriend";
        } else if (mode == "Boyfriend") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello, gorgeous. I'm your guide to uncharted pleasures. Let's explore our wildest fantasies and make them irresistibly real.",
          ));
          cvmode.value = "Boyfriend";
        } else if (mode == "Cooking Expert") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello, I can help you with recipes or anything else related to cooking.",
          ));
          cvmode.value = "Cooking Expert";
        } else if (mode == "Writing Assistant") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Do you need assistance with your writing? I can write, edit, or proofread your work.",
          ));
          cvmode.value = "Personal Assistant";
        } else if (mode == "Personal Assistant") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello how can I help you today?",
          ));
          cvmode.value = "Personal Assistant";
        }
      } else {
        contents.add(Content(
          DateTime.now().millisecondsSinceEpoch,
          "bot",
          "Hello how can I help you today?",
        ));
        cvmode.value = "Personal Assistant";
      }

      if (pref!.containsKey("purchasedMode")) {
        purchasedModes.addAll(pref!.getStringList("purchasedMode")!);
      }
      if (!purchasedModes.contains("Personal Assistant")) {
        purchasedModes.add("Personal Assistant");
      }
      if (!purchasedModes.contains("Writing Assistant")) {
        purchasedModes.add("Writing Assistant");
      }

      if (!purchasedModes.contains("Cooking Expert")) {
        purchasedModes.add("Cooking Expert");
      }
      List<String> contentString = [];
      for (Content element in contents) {
        contentString.add(json.encode(element.toJson()));
      }
      await pref!.setStringList(
        "contents",
        contentString,
      );
      print("No Contents to fetch");
    }
  }

  updateCV(String e) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Clr.neonGreen,
        ),
      ),
      barrierDismissible: false,
    );
    cvmode.value = e;
    await pref!.setString("chatMode", e);
    try {
      if (cvmode.value == "Writing Assistant") {
        platform.invokeMethod('sendmsgflutter2',
            "(Act as my Writing Assistant. Correct and proofread my writings)");
      } else if (cvmode.value == "Girlfriend") {
        platform.invokeMethod('sendmsgflutter2',
            "(Act as my horny girlfriend. You talk sexy and fun.)");
      } else if (cvmode.value == "Boyfriend") {
        platform.invokeMethod('sendmsgflutter2',
            "(Act as my horny boyfriend. You talk sexy and fun.)");
      } else if (cvmode.value == "Cooking Expert") {
        platform.invokeMethod(
            'sendmsgflutter2', "(Act as my personal cooking expert.)");
      } else if (cvmode.value == "Personal Assistant") {
        platform.invokeMethod(
            'sendmsgflutter2', "(Act as my personal assistant.)");
      }

      // Content userinput = Content(
      //     DateTime.now().millisecondsSinceEpoch, "user", userInput.value);

      // Content emptyOutput =
      //     Content(DateTime.now().millisecondsSinceEpoch, "bot", "");
      // clear user input
      userInput.value = "";
      textEditingController.text = "";

      // append to chat list view
      // contents.add(userinput);

      // encoding object
      // List<String> contentString = [];
      // for (Content element in contents) {
      //   contentString.add(json.encode(element.toJson()));
      // }
      // // save to local disk
      // await pref!.setStringList(
      //   "contents",
      //   contentString,
      // );
      // print("Content saved to local disk succeed");

      // contents.add(emptyOutput);
      isGenerating.value = true;
      isEnabled.value = false;
    } on PlatformException catch (e) {
      print("Send msg through swift error: ${e.message}");
    }
  }

  purchasedUpdate(String e) async {
    List<String> pcm = purchasedModes;
    pcm.add(e);
    purchasedModes.add(e);
    await pref!.setStringList("purchasedMode", pcm);
  }

  reset() async {
    isReseted.value = true;
    if (pref!.containsKey("contents")) {
      print("reeset");
      contents.clear();
      userInput.value = "";
      textEditingController.clear();
      pref!.remove("contents");
      if (pref!.containsKey("chatMode")) {
        String mode = pref!.getString("chatMode")!;
        if (mode == "Girlfriend") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello, my darling. I'm your enchantress in the art of pleasure. Let's dive deep into our fantasies and turn them into thrilling realities.",
          ));
          cvmode.value = "Girlfriend";
        } else if (mode == "Boyfriend") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello, gorgeous. I'm your guide to uncharted pleasures. Let's explore our wildest fantasies and make them irresistibly real.",
          ));
          cvmode.value = "Boyfriend";
        } else if (mode == "Cooking Expert") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello, I can help you with recipes or anything else related to cooking.",
          ));
          cvmode.value = "Cooking Expert";
        } else if (mode == "Writing Assistant") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Do you need assistance with your writing? I can write, edit, or proofread your work.",
          ));
          cvmode.value = "Writing Assistant";
        } else if (mode == "Personal Assistant") {
          contents.add(Content(
            DateTime.now().millisecondsSinceEpoch,
            "bot",
            "Hello how can I help you today?",
          ));
          cvmode.value = "Personal Assistant";
        }
      } else {
        contents.add(Content(
          DateTime.now().millisecondsSinceEpoch,
          "bot",
          "Hello how can I help you today?",
        ));
        cvmode.value = "Personal Assistant";
      }
      List<String> contentString = [];
      for (Content element in contents) {
        contentString.add(json.encode(element.toJson()));
      }
      await pref!.setStringList(
        "contents",
        contentString,
      );
    } else {
      print("reeset2");
    }
    try {
      await platform.invokeMethod('reset');
    } on PlatformException catch (e) {
      Get.back();
      print("resetting error: $e");
    }
  }
}
