import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Image.asset(
            'assets/logo-violet.png',
            fit: BoxFit.cover,
          ),
          leading: IconButton(
            onPressed: () {
              nextScreenPop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sofia Pro',
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: CustomButton(
                  text: 'Sign out',
                  onPressed: () => FirebaseAuth.instance.signOut().then(
                      (value) =>
                          nextScreenReplace(context, const Onboarding())),
                  color: phoneFieldButtonColor),
            ),
            const SizedBox(height: 200),
            const Text(
              '2023 © Student\'s Mental Health',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Sofia Pro',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
