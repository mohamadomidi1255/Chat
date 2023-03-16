import 'dart:developer';

import 'package:chat/constant/my_colors.dart';
import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    var useremail = user!.email;
    var useremailVerified = user.uid;

    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: Get.height / 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/avatar.jpg"),
                      fit: BoxFit.contain)),
            ),
            Positioned(
              right: 10,
              bottom: 0,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: MyColors().allColor,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.camera,
                      size: 35,
                      color: Color.fromARGB(207, 255, 255, 255),
                    )),
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //0
                Row(
                  children: [
                    Text(
                      "حساب کاربری",
                      style: TextStyle(
                          color: MyColors().allColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                //1

                const SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: (() {

                //     // Get.bottomSheet(BottomSheet(
                //     //     onClosing: () {},
                //     //     builder: (contaxt) {
                //     //       return Container();
                //     //     }));
                //   }),
                //   child: Column(children: [
                //     Row(
                //       children: [
                //         Text(
                //           name.toString(),
                //           style: const TextStyle(fontSize: 18),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           " نام شما",
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: MyColors().allColor,
                //           ),
                //         ),
                //         Text(
                //           "برای تغییر ایمیل ضربه بزنید",
                //           style: TextStyle(fontSize: 14, color: Colors.black87),
                //         ),
                //       ],
                //     ),
                //   ]),
                // ),
                // const Divider(
                //   height: 1,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                //2
                InkWell(
                  onTap: (() {
                    Get.bottomSheet(BottomSheet(
                        backgroundColor: Colors.transparent,
                        onClosing: () {},
                        builder: (contaxt) {
                          return Container(
                            height: Get.height / 2.3,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Get.width / 1.1,
                                  height: 80,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                      ),
                                      label: const Text("ایمیل جدید"),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors().allColor,
                                          width: 1.5,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      focusedBorder: (const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      )),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: MyColors().allColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Center(
                                    child: const Text(
                                      "ثبت ایمیل جدید",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }));
                  }),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          useremail.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " ایمیل شما",
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColors().allColor,
                          ),
                        ),
                        const Text(
                          "برای تغییر ایمیل ضربه بزنید",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ]),
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                //3
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            useremailVerified.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            " ایدی شما",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyColors().allColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () {
                      showPlatformDialog(
                        context: context,
                        builder: (context) => BasicDialogAlert(
                          title: const Text("ایا مطمئن هستید؟"),
                          content: const Text(
                              " اگر میخواهید حساب کاربری خود را حذف کنید روی دکمه حذف کلیک کنید"),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: const Text("بستن"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            BasicDialogAction(
                              title: const Text("حذف",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                user.delete();

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      "حذف حساب کاربری",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
