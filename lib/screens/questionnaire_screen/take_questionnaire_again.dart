import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/screens/questionnaire_screen/questionnaire.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class TakeQuestionnaireAgain extends StatefulWidget {
  const TakeQuestionnaireAgain({super.key});

  @override
  State<TakeQuestionnaireAgain> createState() => _TakeQuestionnaireAgainState();
}

class _TakeQuestionnaireAgainState extends State<TakeQuestionnaireAgain> {
  String currentDate = DateFormat('MM-dd-yyyy').format(DateTime.now());
  String after60days = DateFormat('MM-dd-yyyy')
      .format(DateTime.now().add(const Duration(days: 7)));

  String dateAnswered = '';
  DateTime? canAnswerAgain;

  bool _isButtonVisible = false;
  int daysLeftToTakeQAgain = 0;

  @override
  void initState() {
    getDateAnswered();
    super.initState();
  }

  getDateAnswered() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getDateAnswered()
        .then((value) {
      DateTime currentDate = DateTime.now();
      DateTime dateAnswered = DateTime.parse(value);
      int daysSinceAnswered = currentDate.difference(dateAnswered).inDays;
      int daysLeft = 60 - daysSinceAnswered;

      setState(() {
        daysLeftToTakeQAgain = daysLeft;
        _isButtonVisible = daysLeft <= 0 ? true : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // automaticallyImplyLeading: false,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                daysLeftToTakeQAgain == 1
                    ? 'You can take the questionnaire\nagain in $daysLeftToTakeQAgain day.'
                    : daysLeftToTakeQAgain <= 0
                        ? 'Please click the start button to proceed.'
                        : 'You can take the questionnaire\nagain in $daysLeftToTakeQAgain days.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
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
          Visibility(
            visible: _isButtonVisible,
            child: CustomButton(
              text: 'Start',
              onPressed: () {
                nextScreen(context, const Questionnaire());
              },
              color: phoneFieldButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
