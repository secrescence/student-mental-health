import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/lower.dart';
import 'package:student_mental_health/widgets/upper.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String studentID = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1D3557)))
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      const Upper(
                        imgUrl: 'assets/logo.png',
                        paddingForUpper: 50,
                      ),
                      const Lower(
                        title: 'Sign Up',
                        paddingForLower: 200,
                        paddingForLowerTitle: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 260),
                        child: SizedBox(
                          width: size.width,
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 3),
                                  child: TextFormField(
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    cursorColor: const Color(0xFF1D3557),
                                    decoration: textInputDeco.copyWith(
                                      labelStyle: const TextStyle(
                                          color: Colors.black54),
                                      labelText: 'Full Name',
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Color(0xFF1D3557),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "Name cannot be empty";
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        fullName = val;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 3),
                                  child: TextFormField(
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    cursorColor: const Color(0xFF1D3557),
                                    decoration: textInputDeco.copyWith(
                                      labelStyle: const TextStyle(
                                          color: Colors.black54),
                                      labelText: 'Email',
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Color(0xFF1D3557),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val!)
                                          ? null
                                          : "Please enter a valid email";
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 3),
                                  child: TextFormField(
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    cursorColor: const Color(0xFF1D3557),
                                    decoration: textInputDeco.copyWith(
                                      labelStyle: const TextStyle(
                                          color: Colors.black54),
                                      labelText: 'Student ID',
                                      prefixIcon: const Icon(
                                        Icons.vpn_key,
                                        color: Color(0xFF1D3557),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.length < 6) {
                                        return "Please enter a valid Student ID";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        studentID = val;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 3),
                                  child: TextFormField(
                                    obscureText: true,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    cursorColor: const Color(0xFF1D3557),
                                    decoration: textInputDeco.copyWith(
                                      labelStyle: const TextStyle(
                                          color: Colors.black54),
                                      labelText: 'Password',
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Color(0xFF1D3557),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.length < 6) {
                                        return "Password must be at least 6 characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 3),
                                  child: TextFormField(
                                    obscureText: true,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    cursorColor: const Color(0xFF1D3557),
                                    decoration: textInputDeco.copyWith(
                                      labelStyle: const TextStyle(
                                          color: Colors.black54),
                                      labelText: 'Confirm Password',
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Color(0xFF1D3557),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.length < 6) {
                                        return "Password must be at least 6 characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        confirmPassword = val;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF1D3557),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      // signup();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text.rich(
                                  TextSpan(
                                      text: 'Already have an account? ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Sign In',
                                          style: const TextStyle(
                                              color: Color(0xFF1D3557)),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = (() {
                                              nextScreen(
                                                  context, const SignupPage());
                                            }),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // signup() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService
  //         .signupUser(fullName, studentID, email, password)
  //         .then((value) async {
  //       if (value == true) {
  //         // saving the shared preference state
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSF(email);
  //         await HelperFunctions.saveUserNameSF(fullName);

  //         // ignore: use_build_context_synchronously
  //         nextScreenReplace(context, const HomePage());
  //       } else {
  //         showSnackbar(context, Colors.red, value);
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }
}
