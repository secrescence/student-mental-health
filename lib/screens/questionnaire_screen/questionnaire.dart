import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/questionnaire_screen/from_yes_or_no.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
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
        //TODO - disable back button
        //automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (() {
              nextScreen(context, const FromYesOrNo(yesOrNo: 'no'));
            }),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            )),
      ),
    );
  }
}
