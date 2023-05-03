import 'dart:developer';
import 'package:chat/constant/my_colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../users screens/list_users_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email_controller = TextEditingController();
  var name_controller = TextEditingController();
  var password_controller = TextEditingController();
  bool passwordVisible = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  void registeruser(var mail, var pass) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: mail, password: pass))
        .user;
    if (user == null) {
      log("sign up failed!!");
    } else {
      addser(mail, name_controller.text);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListUsersScreen(),
          ));
      log("user created..");
    }
  }

  void addser(var mail, var name) async {
    return users.add({
      "name": name,
      "email": mail,
      "userid": _auth.currentUser?.uid
    }).then((value) {
      log("User added");
    }).catchError((onError) {
      log("error: $onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "ثبت نام",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height / 12,
              ),
              Image.asset(
                "assets/images/icon.png",
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: name_controller,
                  decoration: InputDecoration(
                    hintText: "نام کاربری",
                    prefixIcon: const Icon(CupertinoIcons.person),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: (OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.5, color: MyColors().themeColor),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: email_controller,
                  decoration: InputDecoration(
                    hintText: "ایمیل",
                    prefixIcon: const Icon(Icons.email_outlined),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: (OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.5, color: MyColors().themeColor),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: password_controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: passwordVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    hintText: "رمز عبور",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: (OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.5, color: MyColors().themeColor),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    )),
                  ),
                  obscureText: passwordVisible,
                ),
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              InkWell(
                onTap: (() {
                  if (email_controller.text.isEmpty) {
                    Get.snackbar("خطا", "لطفا ایمیل خود را وارد کنید",
                        backgroundColor: MyColors().themeColor,
                        colorText: Colors.white,
                        duration: Duration(seconds: 4));
                  }
                  if (password_controller.text.isEmpty) {
                    Get.snackbar("خطا", "لطفا رمز عبور خود را وارد کنید",
                        backgroundColor: MyColors().themeColor,
                        colorText: Colors.white,
                        duration: Duration(seconds: 4));
                  }
                  if (name_controller.text.isEmpty) {
                    Get.snackbar("خطا", "لطفا نام کلربری خود را وارد کنید",
                        backgroundColor: MyColors().themeColor,
                        colorText: Colors.white,
                        duration: Duration(seconds: 4));
                  }
                  setState(() {
                    registeruser(
                        email_controller.text, password_controller.text);
                  });
                }),
                child: Container(
                  height: 60,
                  width: 180,
                  decoration: BoxDecoration(
                      color: MyColors().themeColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                      child: Text(
                    "ثبت نام",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
