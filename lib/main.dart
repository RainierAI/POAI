// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:poaiapp/Controller/mainController.dart';
import 'package:poaiapp/colors.dart';
import 'package:poaiapp/setting.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  print("Splash Screen start");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POAI APP',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
          leadingWidth: double.infinity,
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Image.asset(
                  "assets/mainicon.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Private Offline AI",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Clr.lightGray,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(SettingView());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Image.asset(
                  "assets/setting.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          left: false,
          right: false,
          top: false,
          child: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                    reverse: true,
                    itemCount: mainController.contents.length,
                    itemBuilder: ((context, index) {
                      final contentsList =
                          mainController.contents.reversed.toList();
                      if (contentsList[index].sender! == "user") {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset('assets/profile.png'),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Text(
                                      contentsList[index].content!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: contentsList[index].content!));

                                    // Get.snackbar(
                                    //   "Copied",
                                    //   "Text successfully copied to clipboard.",
                                    //   backgroundColor: Clr.lightGray,
                                    //   colorText: Clr.darkGray,
                                    //   duration: Duration(seconds: 2),
                                    // );
                                    Get.snackbar(
                                      "Copy successful!",
                                      "Saved to clipboard",
                                      backgroundColor: Clr.neonGreen,
                                      colorText: Clr.darkGray,
                                      duration: Duration(seconds: 2),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Clr.gray500,
                                    // size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset('assets/aiprofile.png'),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Text(
                                      contentsList[index].content!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: contentsList[index].content!));

                                    // Get.snackbar(
                                    //   "Copied",
                                    //   "Text successfully copied to clipboard.",
                                    //   backgroundColor: Clr.lightGray,
                                    //   colorText: Clr.darkGray,
                                    //   duration: Duration(seconds: 2),
                                    // );
                                    Get.snackbar(
                                      "Copy successful!",
                                      "Saved to clipboard",
                                      backgroundColor: Clr.neonGreen,
                                      colorText: Clr.darkGray,
                                      duration: Duration(seconds: 2),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Clr.gray500,
                                    // size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }))),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                // color: Colors.amber,
                child: Obx(
                  () => TextField(
                    controller: mainController.textEditingController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                        fontSize: 16, color: Clr.lightGray, height: 1.43),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Clr.gray500,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Clr.gray500,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // isDense: true,
                      hintText: "Input Text",
                      hintStyle: TextStyle(
                          fontSize: 16, color: Clr.gray500, height: 1.43),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          mainController.sendButton();
                        },
                        child: Icon(
                          Icons.arrow_circle_up,
                          color: (mainController.userInput.value.isEmpty)
                              ? Clr.gray500
                              : Clr.neonGreen,
                          size: 30,
                        ),
                      ),
                    ),
                    cursorColor: Clr.lightGray,
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
