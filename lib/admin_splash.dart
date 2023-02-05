import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/admin/auth/admin_signin.dart';
import 'package:student_mental_health/admin/screens/admin_navigation.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AdminSplash extends StatefulWidget {
  const AdminSplash({super.key});

  @override
  State<AdminSplash> createState() => _AdminSplashState();
}

class _AdminSplashState extends State<AdminSplash> {
  bool _isAdminSignedIn = false;

  @override
  void initState() {
    getAdminLoggedInStatus();
    Future.delayed(const Duration(milliseconds: 500)).then((value) =>
        _isAdminSignedIn
            ? nextScreen(context, const AdminNavigation())
            : nextScreen(context, const AdminSignIn()));
    super.initState();
  }

  getAdminLoggedInStatus() async {
    await HelperFunctions.getAdminLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isAdminSignedIn = value;
        });
      }
    });
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
              child: SpinKitChasingDots(
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
