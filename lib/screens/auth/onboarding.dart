import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_mental_health/screens/auth/signin.dart';
import 'package:student_mental_health/screens/auth/signup_user_info.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  //controller to keep track which page is active
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(
            controller: _controller,
            children: [
              //page 1
              Container(
                  color: const Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 50),
                        child: SvgPicture.asset(
                          'assets/onboarding1.svg',
                          height: 300,
                          width: 300,
                        ),
                      ),
                      //title
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          'Improve your Mental Health',
                          style: TextStyle(
                            color: Color(0xFF35598B),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'Sofia',
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),

                      //description
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            bottom: 80, left: 50, right: 50),
                        child: const Text(
                          'We care about your mental well-being. Start now and we’ll get you through.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            // fontFamily: 'Sofia',
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  )),
              //page 2
              Container(
                  color: const Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 50),
                        child: SvgPicture.asset(
                          'assets/onboarding2.svg',
                          height: 300,
                          width: 300,
                        ),
                      ),
                      //title
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          'Talk to the Experts',
                          style: TextStyle(
                            color: Color(0xFF35598B),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'Sofia',
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),

                      //description
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            bottom: 80, left: 50, right: 50),
                        child: const Text(
                          'Need some help? Schedule an appointment and talk to your counselor.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            // fontFamily: 'Sofia',
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  )),
              //page 3
              Container(
                  color: const Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 50),
                        child: SvgPicture.asset(
                          'assets/onboarding3.svg',
                          height: 300,
                          width: 300,
                        ),
                      ),
                      //title
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: const Text(
                          'Join our Community!',
                          style: TextStyle(
                            color: Color(0xFF35598B),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'Sofia',
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),

                      //description
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            bottom: 80, left: 50, right: 50),
                        child: const Text(
                          'Interact with your peers in the forum and discover activities that can improve yourself.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            // fontFamily: 'Sofia',
                            // fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),

          //dot indicator
          Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 170),
              child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 26.0,
                    dotHeight: 5.0,
                    strokeWidth: 1.5,
                    dotColor: Color(0xFF5D7AA2),
                    activeDotColor: Color(0xFF35598B),
                  ))),

          //log in and sign up button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //sign up button
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 50),
                child: OutlinedButton(
                  onPressed: () {
                    nextScreen(context, const SignUpUserInfo());
                  },

                  //button style
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xFF35598B), width: 2),
                    ),

                    //button shape
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    //button padding
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                  ),

                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF35598B),
                      fontSize: 18,
                      // fontFamily: 'Sofia',
                      // fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),

              //log in button
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    nextScreen(context, const SignIn());
                  },

                  //button style
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xFF2F4C74), width: 2),
                    ),

                    //button shape
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    //button padding
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),

                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF35598B),
                    ),
                  ),

                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      // fontFamily: 'Sofia',
                      // fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
