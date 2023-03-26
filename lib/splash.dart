import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/auth/signup_phone.dart';
import 'package:student_mental_health/screens/dashboard/result_overall_also_dashboard.dart';
import 'package:student_mental_health/screens/questionnaire_screen/need_to_take_quest_to_proceed.dart';
import 'package:student_mental_health/screens/questionnaire_screen/result_categories.dart';
import 'package:student_mental_health/screens/welcome_screen/welcome.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isDoneWithResults = false;
  bool _isDoneWithQuestionnaire = false;
  bool _isDoneWithChatbot = false;
  bool _isSingedUpUsingEmailOnly = false;
  bool _isDoneWithOTP = false;
  bool _isSignedIn = false;
  String? currentUser = FirebaseAuth.instance.currentUser?.uid;

  StreamSubscription<QuerySnapshot>? queueSubscription;

  @override
  void initState() {
    super.initState();
    DatabaseService().listenToAppointmentsCollection();
    getUserLoggedInStatus();
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      if (_isSignedIn &&
          _isDoneWithChatbot &&
          _isSingedUpUsingEmailOnly &&
          _isDoneWithQuestionnaire &&
          _isDoneWithResults) {
        nextScreen(context, const ResultOverallAlsoDashboard());
      } else if (_isSignedIn &&
          _isDoneWithChatbot &&
          _isSingedUpUsingEmailOnly &&
          _isDoneWithQuestionnaire) {
        nextScreen(context, const ResultCategories());
      } else if (_isSignedIn &&
          _isDoneWithChatbot &&
          _isSingedUpUsingEmailOnly) {
        nextScreen(context, const NeedToTakeQuestionnaireToProceed());
      } else if (_isSignedIn &&
          _isSingedUpUsingEmailOnly &&
          _isDoneWithOTP == true) {
        nextScreen(context, const Welcome());
      } else if (_isSingedUpUsingEmailOnly &&
          _isSignedIn &&
          _isDoneWithChatbot == false &&
          _isDoneWithResults == false &&
          _isDoneWithQuestionnaire == false &&
          _isSingedUpUsingEmailOnly) {
        nextScreen(context, const SignUpPhone());
      } else {
        nextScreen(context, const Onboarding());
      }
    });
  }

  getUserLoggedInStatus() async {
    if (currentUser != null) {
      await DatabaseService(uid: currentUser)
          .getUserDoneWithResults()
          .then((value) {
        if (value != null) {
          setState(() {
            _isDoneWithResults = value;
          });
        }
      });
      await DatabaseService(uid: currentUser)
          .getDoneWithQuestionnaire()
          .then((value) {
        if (value != null) {
          setState(() {
            _isDoneWithQuestionnaire = value;
          });
        }
      });
      await DatabaseService(uid: currentUser)
          .getUserDoneChatbot()
          .then((value) {
        if (value != null) {
          setState(() {
            _isDoneWithChatbot = value;
          });
        }
      });
      await DatabaseService(uid: currentUser)
          .getUsersSignedInUsingEmailOnly()
          .then((value) {
        if (value != null) {
          setState(() {
            _isSingedUpUsingEmailOnly = value;
          });
        }
      });
      await DatabaseService(uid: currentUser)
          .getUsersDoneWithOTP()
          .then((value) {
        if (value != null) {
          setState(() {
            _isDoneWithOTP = value;
          });
        }
      });
    }
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
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
