import 'package:chat/constant/my_colors.dart';
import 'package:chat/view/users%20screens/list_users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'login/Register_screen.dart';
import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Widget> listScreen = [];

  var currentScreen = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    listScreen.add(LoginScreen());
    listScreen.add(RegisterScreen());
    listScreen.add(const ListUsersScreen());
    CheckUser();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => listScreen[currentScreen],
      ));
    });
  }

  void CheckUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        currentScreen = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().themeColor,
      body: Center(
        child: Column(
          children: [
            SpinKitFadingCube(
              size: 40,
              color: Colors.white,
            ),
            Text("Chatgram")
          ],
        ),
      ),
    );
  }
}
