import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/auth_screen/login.dart';
import 'package:flutter_application_1/widgets_common/splash_logo.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home_screen/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  splashsc() {
    if (user != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => HomeScreen());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => login());
      });
    }
  }

  @override
  void initState() {
    splashsc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            logo(),
            Text(
              'eMart',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '@Warda Devs',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
