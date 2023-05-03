import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:chat/view/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/constant/my_colors.dart';
import 'package:chat/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/pick_controller.dart';
import 'Account_screen.dart';
import 'chat_screen.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({Key? key}) : super(key: key);

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  @override
  void initState() {
    super.initState();
    _userlist();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance.collection("users");
  FilePickerController controller = Get.put(FilePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              child: controller.file.value.name == 'nothing'
                  ? Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                            opacity: 1,
                            image: AssetImage(
                              "assets/images/avatar.jpg",
                            )),
                      ),
                    )
                  : Image.file(File(controller.file.value.path!)),
            ),
            ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountScreen(),
                      ));
                },
                title: const Text("حساب کاربری")),
            const Divider(
              height: 2,
            ),
            ListTile(onTap: () {}, title: const Text("تنظیمات")),
            const Divider(
              height: 2,
            ),
            ListTile(
                onTap: () {
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "برنامه نویس: محمد امیدی",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "mohammad.omidi2011@gmail.com",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: MyColors().themeColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.email_outlined,
                                        color: MyColors().themeColor, size: 40),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }));
                },
                title: const Text("درباره")),
            const Divider(
              height: 2,
            ),
            ListTile(
              title: TextButton(
                  onPressed: () {
                    showPlatformDialog(
                      context: context,
                      builder: (context) => BasicDialogAlert(
                        title: const Text("ایا مطمئن هستید؟"),
                        content: const Text(
                            " اگر میخواهید از حساب کاربری خود خارج شوید روی دکمه خروج کلیک کنید"),
                        actions: <Widget>[
                          BasicDialogAction(
                            title: const Text("بستن"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          BasicDialogAction(
                            title: const Text("خروج",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _auth.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("خروج از حساب کاربری")),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors().themeColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("لیست کاربر ها"),
            InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userlist(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Center(
              child: SpinKitFadingCube(
                size: 40,
                color: MyColors().themeColor,
              ),
            );
          }
          List<Users> children = snapshot.data?.docs
                  .map((doc) => Users(doc['name'].toString(),
                      doc['userid'].toString(), doc['email'].toString()))
                  .toList() ??
              [];
          return Container(
            child: ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                return listUsers(children[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget listUsers(Users user) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatScreen(user);
        }));
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/avatar.jpg")),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user.name),
            ),
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _userlist() {
    return firestoreInstance
        .where('userid', isNotEqualTo: _auth.currentUser?.uid)
        .snapshots();
  }
}
