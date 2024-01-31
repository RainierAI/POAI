// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poaiapp/Controller/mainController.dart';
import 'package:poaiapp/Controller/purchaseController.dart';
import 'package:poaiapp/colors.dart';
import 'package:poaiapp/pp.dart';
import 'package:poaiapp/tof.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    final purchaseController = Get.find<PurchaseController>();

    return Obx(
      () => Scaffold(
        backgroundColor:
            (mainController.isDarkMode.value) ? Clr.darkGray : Clr.lightGray,
        appBar: AppBar(
          surfaceTintColor:
              (mainController.isDarkMode.value) ? Clr.darkGray : Clr.lightGray,
          backgroundColor:
              (mainController.isDarkMode.value) ? Clr.darkGray : Clr.lightGray,
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
              color: (mainController.isDarkMode.value)
                  ? Clr.lightGray
                  : Clr.darkGray,
            ),
          ),
          title: Text(
            "Settings",
            style: TextStyle(
                color: (mainController.isDarkMode.value)
                    ? Clr.lightGray
                    : Clr.darkGray,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            Text(
              "Conversation Mode",
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: -0.4,
                  fontWeight: FontWeight.w600,
                  color: Clr.gray500),
            ),
            SizedBox(
              height: 4,
            ),
            Obx(
              () => GestureDetector(
                onTap: () {
                  // show modal bottom sheet
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                            // height: 400,
                            decoration: BoxDecoration(
                              color: (mainController.isDarkMode.value)
                                  ? Clr.gray900
                                  : Clr.lightGray,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18)),
                            ),
                            child: ListView.builder(
                                padding: EdgeInsets.all(20),
                                itemCount: mainController.cvmodes.length,
                                itemBuilder: ((context, index) {
                                  var data = mainController.cvmodes[index];
                                  return Obx(() => GestureDetector(
                                        onTap: () async {
                                          if (mainController.purchasedModes
                                              .contains(data)) {
                                            mainController.updateCV(data);
                                          } else {
                                            final connectivityResult =
                                                await (Connectivity()
                                                    .checkConnectivity());
                                            if (connectivityResult ==
                                                ConnectivityResult.none) {
                                              Get.dialog(
                                                AlertDialog(
                                                  backgroundColor: Clr.gray800,
                                                  surfaceTintColor: Clr.gray800,
                                                  title: Text(
                                                    "Network error",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Clr.lightGray,
                                                        fontSize: 18),
                                                  ),
                                                  // content: Text("Are you sure?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          AppSettings.openAppSettings(
                                                              type:
                                                                  AppSettingsType
                                                                      .settings);
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Settings",
                                                          style: TextStyle(
                                                              color: Clr
                                                                  .neonGreen),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color: Clr
                                                                  .lightGray),
                                                        )),
                                                  ],
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24)),
                                                ),
                                                barrierDismissible: false,
                                              );
                                            } else {
                                              Get.dialog(
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Clr.neonGreen,
                                                  ),
                                                ),
                                                barrierDismissible: false,
                                              );
                                              purchaseController
                                                  .purchaseProduct2(data);
                                            }
                                          }
                                          print(
                                              "onchanged dropdown value: ${data}");
                                        },
                                        child: Container(
                                          color:
                                              (mainController.isDarkMode.value)
                                                  ? Clr.gray900
                                                  : Clr.lightGray,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 18),
                                          height: 60,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                mainController.cvmodes[index],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  letterSpacing: -0.4,
                                                  fontWeight: FontWeight.w600,
                                                  color: (mainController
                                                          .isDarkMode.value)
                                                      ? Clr.lightGray
                                                      : Clr.darkGray,
                                                ),
                                              ),
                                              if (mainController.cvmode.value ==
                                                      mainController
                                                          .cvmodes[index] &&
                                                  mainController.purchasedModes
                                                      .contains(mainController
                                                          .cvmodes[index]))
                                                Icon(
                                                  Icons.radio_button_on,
                                                  color: Clr.neonGreen,
                                                ),
                                              if (mainController.cvmode.value !=
                                                      mainController
                                                          .cvmodes[index] &&
                                                  mainController.purchasedModes
                                                      .contains(mainController
                                                          .cvmodes[index]))
                                                Icon(
                                                  Icons.radio_button_off,
                                                  color: Clr.gray500,
                                                ),
                                              if (!mainController.purchasedModes
                                                      .contains(mainController
                                                          .cvmodes[index]) &&
                                                  purchaseController
                                                      .isConnected.value)
                                                Text(
                                                  "${purchaseController.productss[purchaseController.productss.indexWhere((element2) => element2.title == mainController.cvmodes[index].toString())].currencySymbol} ${purchaseController.productss[purchaseController.productss.indexWhere((element2) => element2.title == mainController.cvmodes[index].toString())].rawPrice}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    letterSpacing: -0.4,
                                                    fontWeight: FontWeight.w600,
                                                    color: (mainController
                                                            .isDarkMode.value)
                                                        ? Clr.lightGray
                                                        : Clr.darkGray,
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ));
                                })));
                      });
                },
                child: Container(
                  color: (mainController.isDarkMode.value)
                      ? Clr.darkGray
                      : Clr.lightGray,
                  height: 48,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mainController.cvmode.value,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w600,
                          color: (mainController.isDarkMode.value)
                              ? Clr.lightGray
                              : Clr.darkGray,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: (mainController.isDarkMode.value)
                            ? Clr.lightGray
                            : Clr.darkGray,
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Obx(
            //   () => Container(
            //     height: 60,
            //     color: (mainController.isDarkMode.value)
            //         ? Clr.darkGray
            //         : Clr.lightGray,
            //     alignment: Alignment.center,
            //     child: DropdownButtonHideUnderline(
            //       child: Obx(() {
            //         return DropdownButton<String>(
            //           dropdownColor: (mainController.isDarkMode.value)
            //               ? Colors.grey
            //               : Clr.lightGray,
            //           isExpanded: true,
            //           borderRadius: BorderRadius.circular(16),
            //           menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
            //           value: mainController.cvmode.value,
            //           items: mainController.cvmodes.map((element) {
            //             // print(
            //             //     "elements: $element, ${purchaseController.productss.indexWhere((element2) => element2.title == element.toString())}");
            //             return DropdownMenuItem(
            //               value: element,
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(vertical: 8.0),
            //                 child: Center(
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text(
            //                         element,
            //                         style: TextStyle(
            //                           fontSize: 18,
            //                           letterSpacing: -0.4,
            //                           fontWeight: FontWeight.w600,
            //                           color: (mainController.isDarkMode.value)
            //                               ? Clr.lightGray
            //                               : Clr.darkGray,
            //                         ),
            //                         textAlign: TextAlign.center,
            //                       ),
            //                       if (!mainController.purchasedModes
            //                               .contains(element) &&
            //                           (element.toString() !=
            //                                   "Personal Assistant" ||
            //                               element.toString() !=
            //                                   "Writing Assistant") &&
            //                           purchaseController.isConnected.value)
            //                         Text(
            //                           "${purchaseController.productss[purchaseController.productss.indexWhere((element2) => element2.title == element.toString())].currencySymbol} ${purchaseController.productss[purchaseController.productss.indexWhere((element2) => element2.title == element.toString())].rawPrice}",
            //                           style: TextStyle(
            //                             fontSize: 14,
            //                             letterSpacing: -0.4,
            //                             fontWeight: FontWeight.w600,
            //                             color: (mainController.isDarkMode.value)
            //                                 ? Clr.lightGray
            //                                 : Clr.darkGray,
            //                           ),
            //                         ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //           onChanged: (v) async {
            //             if (mainController.purchasedModes
            //                 .contains(v.toString())) {
            //               mainController.updateCV(v.toString());
            //             } else {
            //               final connectivityResult =
            //                   await (Connectivity().checkConnectivity());
            //               if (connectivityResult == ConnectivityResult.none) {
            //                 Get.dialog(
            //                   AlertDialog(
            //                     backgroundColor: Clr.gray800,
            //                     surfaceTintColor: Clr.gray800,
            //                     title: Text(
            //                       "Network error",
            //                       style: TextStyle(
            //                           fontWeight: FontWeight.w500,
            //                           color: Clr.lightGray,
            //                           fontSize: 18),
            //                     ),
            //                     // content: Text("Are you sure?"),
            //                     actions: [
            //                       TextButton(
            //                           onPressed: () {
            //                             AppSettings.openAppSettings(
            //                                 type: AppSettingsType.settings);
            //                             Get.back();
            //                           },
            //                           child: Text(
            //                             "Settings",
            //                             style: TextStyle(color: Clr.neonGreen),
            //                           )),
            //                       TextButton(
            //                           onPressed: () {
            //                             Get.back();
            //                           },
            //                           child: Text(
            //                             "Cancel",
            //                             style: TextStyle(color: Clr.lightGray),
            //                           )),
            //                     ],
            //                     shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(24)),
            //                   ),
            //                   barrierDismissible: false,
            //                 );
            //               } else {
            //                 Get.dialog(
            //                   Center(
            //                     child: CircularProgressIndicator(
            //                       color: Clr.neonGreen,
            //                     ),
            //                   ),
            //                   barrierDismissible: false,
            //                 );
            //                 purchaseController.purchaseProduct2(v!);
            //               }
            //             }
            //             print("onchanged dropdown value: ${v.toString()}");
            //           },
            //         );
            //       }),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Dark Mode",
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: -0.4,
                  fontWeight: FontWeight.w600,
                  color: Clr.gray500),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              color: (mainController.isDarkMode.value)
                  ? Clr.darkGray
                  : Clr.lightGray,
              height: 48,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark mode",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: -0.4,
                      fontWeight: FontWeight.w600,
                      color: (mainController.isDarkMode.value)
                          ? Clr.lightGray
                          : Clr.darkGray,
                    ),
                  ),
                  Obx(
                    () => CupertinoSwitch(
                      value: mainController.isDarkMode.value,
                      activeColor: Clr.neonGreen,
                      onChanged: (v) {
                        mainController.isDarkMode.value = v;
                        mainController.updateSetting(v);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
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
                    backgroundColor: Clr.gray800,
                    surfaceTintColor: Clr.gray800,
                    title: Text(
                      "Are you sure?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Clr.lightGray,
                          fontSize: 18),
                    ),
                    // content: Text("Are you sure?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();

                            Get.dialog(
                              Center(
                                child: CircularProgressIndicator(
                                  color: Clr.neonGreen,
                                ),
                              ),
                              barrierDismissible: false,
                            );
                            mainController.reset();
                            // if (Get.isDialogOpen != null) {
                            //   if (Get.isDialogOpen!) {
                            //     Get.back();
                            //   }
                            // }

                            // Get.back();
                          },
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Clr.neonGreen),
                          )),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Clr.lightGray),
                          )),
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  barrierDismissible: false,
                );
              },
              child: Container(
                color: (mainController.isDarkMode.value)
                    ? Clr.darkGray
                    : Clr.lightGray,
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
                        color: (mainController.isDarkMode.value)
                            ? Clr.lightGray
                            : Clr.darkGray,
                      ),
                    ),
                    Icon(
                      Icons.restart_alt,
                      color: (mainController.isDarkMode.value)
                          ? Clr.lightGray
                          : Clr.darkGray,
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
              onTap: () {
                Get.to(TofPage());
              },
              child: Container(
                color: (mainController.isDarkMode.value)
                    ? Clr.darkGray
                    : Clr.lightGray,
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
                        color: (mainController.isDarkMode.value)
                            ? Clr.lightGray
                            : Clr.darkGray,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: (mainController.isDarkMode.value)
                          ? Clr.lightGray
                          : Clr.darkGray,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                Get.to(PpPage());
              },
              child: Container(
                color: (mainController.isDarkMode.value)
                    ? Clr.darkGray
                    : Clr.lightGray,
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
                        color: (mainController.isDarkMode.value)
                            ? Clr.lightGray
                            : Clr.darkGray,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: (mainController.isDarkMode.value)
                          ? Clr.lightGray
                          : Clr.darkGray,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Coffe Tip",
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: -0.4,
                  fontWeight: FontWeight.w600,
                  color: Clr.gray500),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  final connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.none) {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Clr.gray800,
                        surfaceTintColor: Clr.gray800,
                        title: Text(
                          "Network error",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Clr.lightGray,
                              fontSize: 18),
                        ),
                        // content: Text("Are you sure?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                AppSettings.openAppSettings(
                                    type: AppSettingsType.settings);
                                Get.back();
                              },
                              child: Text(
                                "Settings",
                                style: TextStyle(color: Clr.neonGreen),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Clr.lightGray),
                              )),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      barrierDismissible: false,
                    );
                  } else {
                    Get.dialog(
                      Center(
                        child: CircularProgressIndicator(
                          color: Clr.neonGreen,
                        ),
                      ),
                      barrierDismissible: false,
                    );
                    purchaseController.purchaseProduct();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Clr.neonGreen,
                  ),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: (purchaseController.productss.isNotEmpty)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        "Buy us a cup of coffee!",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w600,
                          color: Clr.darkGray,
                        ),
                      ),
                      if (purchaseController.productss.contains(
                          purchaseController.productss
                              .where((element) =>
                                  element.id == "co.rainierai.PrivateAI.tip")
                              .first))
                        Text(
                          "${purchaseController.productss.last.currencySymbol} ${purchaseController.productss.last.rawPrice}",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w600,
                            color: Clr.darkGray,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
