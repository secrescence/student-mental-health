import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/screens/questionnaire_screen/questionnaire.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class NeedToTakeQuestionnaireToProceed extends StatelessWidget {
  const NeedToTakeQuestionnaireToProceed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AuthService().signOut().then(
                (value) => nextScreenReplace(context, const Onboarding()));
          },
          icon: const Icon(
            Icons.logout,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome back!',
                    textStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                    cursor: '|',
                  ),
                  TypewriterAnimatedText(
                    'Before you can proceed,',
                    textStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                    cursor: '|',
                  ),
                  TypewriterAnimatedText(
                    'you need to take the questionnaire.',
                    textStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                    cursor: '|',
                  ),
                  TypewriterAnimatedText(
                    'Please click the button below.',
                    textStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                    cursor: '|',
                  ),
                ],
                totalRepeatCount: 1,
                // pause: const Duration(milliseconds: 500),
                // displayFullTextOnTap: true,
                // stopPauseOnTap: true,
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 400,
            width: 350,
            child: Lottie.asset('assets/lottie/yes.json'),
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: 'Start',
            onPressed: () {
              nextScreen(context, const Questionnaire());
            },
            color: phoneFieldButtonColor,
          ),
        ],
      ),
    );
  }
}
