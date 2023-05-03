import 'dart:developer';
import 'package:chat/constant/my_colors.dart';
import 'package:chat/view/login/Register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../users screens/list_users_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();
  var passwordVisible = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginuser(var email, var pass) async {
    final User? user =
        (await _auth.signInWithEmailAndPassword(email: email, password: pass))
            .user;

    if (user == null) {
      Get.snackbar("خطا", "حساب کاربری وجود ندارد",
          backgroundColor: MyColors().themeColor,
          colorText: Colors.white,
          duration: Duration(seconds: 4));
    } else {
      Get.to(ListUsersScreen());
      log("user login..");
    }
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
                      "ورود",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height / 7,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: email_controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: "ایمیل",
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
                  obscureText: passwordVisible,
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
                ),
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              InkWell(
                onTap: () {
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
                  setState(() {
                    loginuser(email_controller.text, password_controller.text);
                  });
                },
                child: Container(
                  height: 60,
                  width: 180,
                  decoration: BoxDecoration(
                      color: MyColors().themeColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                      child: Text(
                    "ورود",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
              SizedBox(
                height: Get.height / 6.8,
              ),
              Container(
                height: Get.height / 3.5,
                decoration: BoxDecoration(
                    color: MyColors().themeColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80))),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: const Text(
                      "ثبت نام",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
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
