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

  DateTime? dateAnswered;
  DateTime? canAnswerAgain;

  bool _isButtonVisible = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getDateAnswered()
        .then((dateAnswered) {
      DateTime dateAnsweredParsed =
          DateFormat('MM-dd-yyyy').parse(dateAnswered);
      setState(() {
        dateAnswered = dateAnsweredParsed;
      });
      print(dateAnswered);
      // DateTime dateCanAnswerAgain =
      //     dateAnsweredParsed.add(const Duration(days: 60));
      // if (dateAnsweredParsed.millisecondsSinceEpoch >=
      //     dateCanAnswerAgain.millisecondsSinceEpoch) {
      //   setState(() {
      //     _isButtonVisible = false;
      //   });
      // }
    });

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getDateCanAnswerAgain()
        .then((dateCanAnswerAgain) {
      DateTime dateCanAnswerAgainParsed =
          DateFormat('MM-dd-yyyy').parse(dateCanAnswerAgain);
      setState(() {
        canAnswerAgain = dateCanAnswerAgainParsed;
      });
      print(canAnswerAgain);
    });

    if (dateAnswered!.millisecondsSinceEpoch >=
        canAnswerAgain!.millisecondsSinceEpoch) {
      setState(() {
        _isButtonVisible = false;
      });
    }
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
            children: const [
              Text(
                'Take the questionnaire again.',
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
            replacement: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'You have already taken the questionnaire recently. Please come back for some more time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontSize: 20.0,
                ),
              ),
            ),
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
