import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/screens/auth/otp_screen.dart';
import 'package:student_mental_health/screens/auth/signup_phone.dart';
import 'package:student_mental_health/screens/welcome_screen/welcome.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/splash.dart';
import 'package:student_mental_health/widgets/utils/loading.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AuthService {
  bool isLoading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //phone auth
  Future signUpPhone({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 20),
        verificationCompleted: (AuthCredential phoneAuthCredential) async {
          await firebaseAuth.currentUser!
              .linkWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          nextScreen(
              context,
              OtpScreen(
                  verificationId: verificationId, phoneNumber: phoneNumber));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      errorSnackbar(context, 'Oh Snap!', e.message);
    }
  }

  //verify otp in phone auth
  Future verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      bool mounted = true}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      await firebaseAuth.currentUser!.linkWithCredential(phoneAuthCredential);
      if (!mounted) return;
      nextScreenReplace(
          context, const LoadingWidget(thenMoveToThisWidget: Welcome()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code' ||
          e.code == 'invalid-verfication-id') {
        errorSnackbar(context, 'Oh Snap!',
            'The sms verification code you entered is invalid. Please resend the verification code and try again.');
      } /* else if (e.code == 'credential-already-in-use') {
        errorSnackbar(context, 'Uh-oh!', 'Phone number already in use');
      }  */
      else {
        errorSnackbar(context, 'Oh Snap!', e.message!);
      }
    }
  }

  // getCredential(
  //   BuildContext context,
  //   String verificationId,
  //   String userOtp,
  // ) {
  //   AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: userOtp);
  //   return phoneAuthCredential;
  // }

  // sign in with email and password
  Future signIn(
      {required String email,
      required String password,
      required BuildContext context,
      bool mounted = true}) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        if (!mounted) return;
        nextScreen(context, const Splash());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorSnackbar(
            context, 'Oh Snap!', 'Wrong email or password. Please try again');
      } else {
        errorSnackbar(context, 'Oh Snap!', e.message!);
      }
    }
  }

  //sign up with user details
  Future signUpUserInfo({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String department,
    required String year,
    required String section,
    required String studentId,
    required String password,
    bool mounted = true,
  }) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await DatabaseService(uid: firebaseAuth.currentUser!.uid)
            .savingUserData(
          firstName,
          lastName,
          email,
          department,
          year,
          section,
          studentId,
        );
        if (!mounted) return;
        nextScreenReplace(context, const SignUpPhone());
      }
    } on FirebaseAuthException catch (e) {
      errorSnackbar(context, 'Oops!', e.message!);
    }
  }

  // sign out
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
