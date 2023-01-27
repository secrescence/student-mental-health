import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/admin/auth/admin_signin.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AdminSplash extends StatefulWidget {
  const AdminSplash({super.key});

  @override
  State<AdminSplash> createState() => _AdminSplashState();
}

class _AdminSplashState extends State<AdminSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2300))
        .then((value) => nextScreen(context, const AdminSignIn()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(
                'assets/logo-white-splash.png',
              ),
            ),
            const Expanded(
              child: SpinKitSpinningLines(
                color: Colors.white,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
