import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/screens/welcome_screen/your_privacy_matters.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AuthService().signOutUser().then(
                (value) => nextScreenReplace(context, const Onboarding()));
          },
          icon: const Icon(
            Icons.logout,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Container(child: Lottie.asset('assets/lottie/welcome_lottie.json')),
            const SizedBox(height: 30),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontFamily: 'Sofia Pro',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Explore the resources we collected just for you and get in touch with your school\'s guidance counselor',
              style: TextStyle(
                fontFamily: 'Sofia Pro',
                fontSize: 20,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            CustomButton(
                text: 'Okay',
                onPressed: () {
                  nextScreen(context, const YourPrivacyMatters());
                },
                color: phoneFieldButtonColor)
          ],
        ),
      ),
    );
  }
}
