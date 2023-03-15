import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscureText = true;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    studentIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (() {
                nextScreenPop(context);
              }),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF000000),
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                    child: Text(
                      'Welcome back!',
                      style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 30,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 23,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //email
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: primaryColor,
                      decoration: textInputDeco.copyWith(
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(
                            height: 0, color: Colors.transparent, fontSize: 0),
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
                        labelText: 'Email Address',
                        hintText: 'Enter your email address',
                        hintStyle: const TextStyle(
                            fontSize: 13, fontFamily: 'Sofia Pro'),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 0, right: 7, bottom: 0, left: 7),
                          child: Icon(
                            Icons.email,
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
                  const SizedBox(height: 20),
                  //student id
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: studentIdController,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: primaryColor,
                      decoration: textInputDeco.copyWith(
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(
                            height: 0, color: Colors.transparent, fontSize: 0),
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
                        labelText: 'Student ID',
                        hintText: 'Enter your Student ID',
                        hintStyle: const TextStyle(
                            fontSize: 13, fontFamily: 'Sofia Pro'),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 0, right: 7, bottom: 0, left: 7),
                          child: Icon(
                            Icons.credit_card,
                            color: Color(0xFF1D3557),
                            size: 20,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!studentIdController.text.startsWith('2024-32') &&
                            !studentIdController.text.startsWith('2023-32') &&
                            !studentIdController.text.startsWith('2022-32') &&
                            !studentIdController.text.startsWith('2021-32') &&
                            !studentIdController.text.startsWith('2020-32') &&
                            !studentIdController.text.startsWith('2019-32')) {
                          return '';
                        } else if (value == null ||
                            value.isEmpty ||
                            value.length != 11) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  //password
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: isObscureText,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: primaryColor,
                      decoration: textInputDeco.copyWith(
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(
                            height: 0, color: Colors.transparent, fontSize: 0),
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
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    child: CustomButton(
                        text: 'Sign In',
                        onPressed: () {
                          signIn();
                        },
                        color: phoneFieldButtonColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String studentId = studentIdController.text.trim();
    if (formKey.currentState!.validate()) {
      await AuthService().signIn(
          email: email,
          studentId: studentId,
          password: password,
          context: context);
    } else {
      errorSnackbar(context, 'Oops!', 'Please fill all the fields correctly');
    }
  }
}
