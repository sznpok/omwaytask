import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omwaytech/constants/color_constant.dart';
import 'package:omwaytech/constants/image_constant.dart';
import 'package:omwaytech/home/ui/home_screen.dart';
import 'package:omwaytech/utils/custom_storage.dart';
import 'package:omwaytech/utils/size.dart';
import 'package:omwaytech/utils/token.dart';

import 'auth/ui/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigate() async {
    String? accessToken = await readTokenAccess();
    String? userID = await readID();
    if (accessToken != null &&
        accessToken.isNotEmpty &&
        userID != null &&
        userID.isNotEmpty) {
      AccessToken.token = accessToken.toString();
    }
    if (accessToken != null) {
      _navigateToHomeScreen();
    } else {
      _navigateToAuthPage();
    }
  }

  _navigateToHomeScreen() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  _navigateToAuthPage() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome Our App",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: primaryLightColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.01,
            ),
            Image.asset(
              ImageConstant.logoImage,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
