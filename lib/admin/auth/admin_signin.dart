import 'package:flutter/material.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscureText = true;
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: primaryColor,
              width: 420,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/logo-white-splash.png', height: 90),
                  const SizedBox(height: 200),
                  Image.asset('assets/admin_logo.png', scale: 0.8),
                  const SizedBox(height: 10),
                  const Text(
                    'Capsu Dayao Guidance\nand Counseling Office',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sofia Pro',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(width: 20),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 5,
                //     blurRadius: 7,
                //     offset: const Offset(0, 3),
                //   ),
                // ],
                //TODO
              ),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sofia Pro',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 120),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: primaryColor,
                        decoration: textInputDeco.copyWith(
                          errorMaxLines: 1,
                          errorStyle: const TextStyle(
                              height: 0,
                              color: Colors.transparent,
                              fontSize: 0),
                          contentPadding: const EdgeInsets.all(0),
                          prefixIconConstraints:
                              const BoxConstraints(maxHeight: 20),
                          suffixIconConstraints:
                              const BoxConstraints(maxHeight: 20),
                          floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sofia Pro',
                              fontSize: 17),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sofia Pro',
                              fontSize: 17),
                          labelText: 'Email',
                          hintText: 'Enter your Email Address',
                          hintStyle: const TextStyle(
                              fontSize: 13, fontFamily: 'Sofia Pro'),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(
                                top: 0, right: 7, bottom: 0, left: 7),
                            child: Icon(
                              Icons.mail,
                              color: Color(0xFF1D3557),
                              size: 20,
                            ),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!) &&
                                  value.isNotEmpty
                              ? null
                              : '';
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: isObscureText,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: primaryColor,
                        decoration: textInputDeco.copyWith(
                          errorMaxLines: 1,
                          errorStyle: const TextStyle(
                              height: 0,
                              color: Colors.transparent,
                              fontSize: 0),
                          contentPadding: const EdgeInsets.all(0),
                          prefixIconConstraints:
                              const BoxConstraints(maxHeight: 20),
                          suffixIconConstraints:
                              const BoxConstraints(maxHeight: 35),
                          floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sofia Pro',
                              fontSize: 17),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sofia Pro',
                              fontSize: 17),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                              fontSize: 13, fontFamily: 'Sofia Pro'),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(
                                top: 0, right: 7, bottom: 0, left: 7),
                            child: Icon(
                              Icons.lock,
                              color: Color(0xFF1D3557),
                              size: 20,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: primaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () => adminSignIn(),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(140, 55)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            phoneFieldButtonColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      child: const Text('Log In',
                          style:
                              TextStyle(fontSize: 25, fontFamily: 'Sofia Pro')),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  adminSignIn() async {
    if (formkey.currentState!.validate()) {
      await AuthService().adminSignIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context);
    } else {
      errorSnackbar(context, 'Oops!', 'Fill all fields correctly!');
    }
  }
}
