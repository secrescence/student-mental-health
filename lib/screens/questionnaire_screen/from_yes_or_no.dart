import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/screens/questionnaire_screen/questionnaire.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class FromYesOrNo extends StatelessWidget {
  final String yesOrNo;
  const FromYesOrNo({super.key, required this.yesOrNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //TODO - disable back button
        //automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //yes
              Visibility(
                visible: yesOrNo == 'yes' ? true : false,
                child: Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Alright!',
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
                          nextScreenReplace(context, const Questionnaire());
                        },
                        color: phoneFieldButtonColor)
                  ],
                ),
              ),

              //no
              Visibility(
                visible: yesOrNo == 'no' ? true : false,
                child: Column(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Alright!',
                          textStyle: const TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 100),
                          cursor: '|',
                        ),
                        TypewriterAnimatedText(
                          'Tell me when you\'re ready.',
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
                    SizedBox(
                      height: 400,
                      width: 380,
                      child: Lottie.asset('assets/lottie/no.json'),
                    ),
                    const SizedBox(height: 65),
                    CustomButton(
                        text: 'Ready',
                        onPressed: () {
                          nextScreenReplace(context, const Questionnaire());
                        },
                        color: phoneFieldButtonColor)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
