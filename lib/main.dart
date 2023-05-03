import 'package:chat/view/login/login_screen.dart';
import 'package:chat/view/login/Register_screen.dart';
import 'package:chat/view/splash_screens.dart';
import 'package:chat/view/users%20screens/list_users_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      locale: Locale("fa"),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
