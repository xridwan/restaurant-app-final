import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app_final/common/styles.dart';
import 'package:restaurant_app_final/ui/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Image.asset(
          'assets/restaurant.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
