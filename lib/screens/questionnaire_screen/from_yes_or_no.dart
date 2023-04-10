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
                    const Text(
                      'Great! Let\'s get started.',
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
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
                    const Text(
                      'Alright! Tell me when you\'re ready.',
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
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
