import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/auth/signup_phone.dart';
import 'package:student_mental_health/screens/questionnaire_screen/need_to_take_quest_to_proceed.dart';
import 'package:student_mental_health/screens/questionnaire_screen/result_categories.dart';
import 'package:student_mental_health/screens/welcome_screen/welcome.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AuthLoading extends StatefulWidget {
  const AuthLoading({super.key});

  @override
  State<AuthLoading> createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  bool _isDoneWithQuestionnaire = false;
  bool _isDoneWithChatbot = false;
  bool _isSingedUpUsingEmailOnly = false;
  bool _isSignedIn = false;
  String? currentUser = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      if (_isSignedIn &&
          _isDoneWithChatbot &&
          _isSingedUpUsingEmailOnly &&
          _isDoneWithQuestionnaire) {
        nextScreen(context, const ResultCategories());
      } else if (_isSignedIn &&
          _isDoneWithChatbot &&
          _isSingedUpUsingEmailOnly) {
        nextScreen(context, const NeedToTakeQuestionnaireToProceed());
      } else if (_isSignedIn && _isSingedUpUsingEmailOnly) {
        nextScreen(context, const Welcome());
      } else if (_isSingedUpUsingEmailOnly) {
        nextScreen(context, const SignUpPhone());
      } else {
        nextScreen(context, const Onboarding());
      }
    });
  }

  getUserLoggedInStatus() async {
    if (currentUser != null) {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: SpinKitSpinningLines(color: primaryColor)),
    );
  }
}
