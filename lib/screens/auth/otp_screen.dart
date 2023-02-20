import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? userOtp;
  Timer? _timer;
  int timerStart = 20;
  bool timerStop = false;
  bool sendCodeAgainVisible = true;

  final defaultPinTheme = const PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontFamily: 'Sofia Pro',
      fontSize: 28,
      color: primaryColor,
    ),
    decoration: BoxDecoration(),
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 45,
        height: 3,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 45,
        height: 3,
        decoration: BoxDecoration(
          color: const Color(0xFFA5A5A5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  @override
  void initState() {
    resendOtpTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            if (mounted) {
              setState(() {
                timerStop = true;
              });
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    padding: const EdgeInsets.all(20.0),
                    child: SvgPicture.asset('assets/phone_signup.svg'),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Verify Your Number",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Please enter your Code sent to",
                    style: TextStyle(
                      height: 1.2,
                      fontFamily: 'Sofia Pro',
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${widget.phoneNumber.substring(0, 3)} ${widget.phoneNumber.substring(3, 6)} ${widget.phoneNumber.substring(6, 9)} ${widget.phoneNumber.substring(9, 13)}',
                    style: const TextStyle(
                      letterSpacing: 0.5,
                      height: 1.3,
                      fontFamily: 'Sofia Pro',
                      fontSize: 18,
                      color: phoneNumberInOtpColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 6,
                    pinAnimationType: PinAnimationType.slide,
                    defaultPinTheme: defaultPinTheme,
                    showCursor: true,
                    cursor: cursor,
                    preFilledWidget: preFilledWidget,
                    onCompleted: (value) {
                      setState(() {
                        userOtp = value;
                      });
                    },
                  ),
                  const SizedBox(height: 90),
                  SizedBox(
                    width: 118,
                    height: 46,
                    child: CustomButton(
                      text: "Verify",
                      onPressed: () {
                        if (userOtp != null && userOtp!.length == 6) {
                          verifyOTP();
                          setState(() {
                            timerStop = true;
                          });
                        } else {
                          errorSnackbar(
                              context, 'Oh Snap!', 'OTP Code is not valid');
                        }
                      },
                      color: phoneFieldButtonColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: sendCodeAgainVisible,
                    replacement: GestureDetector(
                      child: const Text('Resend',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 16,
                            color: phoneNumberInOtpColor,
                            fontWeight: FontWeight.w600,
                          )),
                      onTap: () {
                        AuthService().signUpPhone(
                            context: context, phoneNumber: widget.phoneNumber);
                      },
                    ),
                    child: RichText(
                        text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Send Code again in ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontFamily: 'Sofia Pro'),
                        ),
                        TextSpan(
                          text: "$timerStart",
                          style: const TextStyle(
                              fontSize: 16,
                              color: phoneNumberInOtpColor,
                              fontFamily: 'Sofia Pro',
                              fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                          text: " seconds ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontFamily: 'Sofia Pro'),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifyOTP() async {
    await AuthService()
        .verifyOtp(
            context: context,
            verificationId: widget.verificationId,
            userOtp: userOtp!)
        .then((value) async {
      if (value != null) {
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .addPhoneNumber(widget.phoneNumber);
      }
    });
    await HelperFunctions.saveUserLoggedInStatus(true);
  }

  void resendOtpTimer() {
    const onsec = Duration(seconds: 1);
    _timer = Timer.periodic(onsec, (timer) {
      if (timerStart == 0 || timerStop || !mounted) {
        timer.cancel();
        setState(() {
          sendCodeAgainVisible = false;
        });
      } else {
        if (mounted) {
          setState(() {
            timerStart--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
