import 'package:chat/view/list_users_screen.dart';
import 'package:chat/view/login_screen.dart';
import 'package:chat/view/Register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> listScreen = [];

  var currentScreen = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    listScreen.add(LoginScreen());
    listScreen.add(RegisterScreen());
    listScreen.add(const ListUsersScreen());
    CheckUser();
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
    return GetMaterialApp(
      locale: const Locale("fa"),
      debugShowCheckedModeBanner: false,
      home: listScreen[currentScreen],
    );
  }
}
