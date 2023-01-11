import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/lower.dart';
import 'package:student_mental_health/widgets/upper.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String studentID = "";
  final bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF1D3557)))
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    const Upper(
                      imgUrl: 'assets/logo.png',
                      paddingForUpper: 80,
                    ),
                    const Lower(
                      title: 'Sign In',
                      paddingForLower: 230,
                      paddingForLowerTitle: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: SizedBox(
                        width: size.width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black54),
                                  cursorColor: const Color(0xFF1D3557),
                                  decoration: textInputDeco.copyWith(
                                    labelStyle:
                                        const TextStyle(color: Colors.black54),
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
                                    horizontal: 30, vertical: 5),
                                child: TextFormField(
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.black54),
                                  cursorColor: const Color(0xFF1D3557),
                                  decoration: textInputDeco.copyWith(
                                    labelStyle:
                                        const TextStyle(color: Colors.black54),
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
                              const SizedBox(height: 80),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1D3557),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    //signin();
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text.rich(
                                TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: const TextStyle(
                                            color: Color(0xFF1D3557)),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (() {
                                            nextScreen(
                                                context, const SigninPage());
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
    );
  }

  // signin() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService.signIn(email, password).then((value) async {
  //       if (value == true) {
  //         QuerySnapshot snapshot =
  //             await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //                 .gettingUserPhoneNumber(email);
  //         // saving the values to our shared preferences
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSF(email);
  //         await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);

  //         // ignore: use_build_context_synchronously
  //         nextScreenReplace(context, const SigninPage());
  //       } else {
  //         print('error');
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }
}
