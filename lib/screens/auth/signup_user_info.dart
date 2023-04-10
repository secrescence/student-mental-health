import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class SignUpUserInfo extends StatefulWidget {
  const SignUpUserInfo({super.key});

  @override
  State<SignUpUserInfo> createState() => _SignUpUserInfoState();
}

class _SignUpUserInfoState extends State<SignUpUserInfo> {
  //constructor for dropdown values
  _SignUpUserInfoState() {
    _schoolYearSelectedValue = _schoolYear[0];
    _classSectionSelectedValue = _classSection[0];
    _departmentSelectedValue = _department[0];
  }

  //dropdown
  final _schoolYear = ['1', '2', '3', '4'];
  final _classSection = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
  ];
  final _department = [
    'Computer Science',
    'Criminology',
    'Education',
    'Fisheries',
    'Food Technology'
  ];
  String? _schoolYearSelectedValue = '';
  String? _classSectionSelectedValue = '';
  String? _departmentSelectedValue = '';

  // controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isObscureTextPassword = true;
  bool isObscureTextConfirmPassword = true;

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    studentIdController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                Navigator.pop(context);
              }),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF000000),
              )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Personal Details',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 21,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          //first name
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: firstNameController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: primaryColor,
                                textCapitalization: TextCapitalization.words,
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
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  alignLabelWithHint: true,
                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Sofia Pro',
                                      fontSize: 17),
                                  labelText: 'First Name',
                                  hintText: 'Enter your first name',
                                  hintStyle: const TextStyle(
                                      fontSize: 13, fontFamily: 'Sofia Pro'),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 0, right: 7, bottom: 0, left: 7),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xFF1D3557),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          //last name
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: lastNameController,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: primaryColor,
                                textCapitalization: TextCapitalization.words,
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
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.start,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  alignLabelWithHint: true,
                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Sofia Pro',
                                      fontSize: 17),
                                  labelText: 'Last Name',
                                  hintText: 'Enter your last name',
                                  hintStyle: const TextStyle(
                                      fontSize: 13, fontFamily: 'Sofia Pro'),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 0, right: 7, bottom: 0, left: 7),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xFF1D3557),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sofia Pro',
                                fontSize: 17),
                            labelText: 'Email',
                            hintText: 'Enter your email',
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'School Details',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 21,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      //department
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField(
                            decoration: textInputDeco.copyWith(
                              contentPadding: const EdgeInsets.all(0),
                              prefixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              suffixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 12, bottom: 0, left: 2),
                              ),
                              floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 17),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: false,
                              labelText: 'Department',
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 17),
                              hintStyle: const TextStyle(
                                  fontSize: 13, fontFamily: 'Sofia Pro'),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 10.5, bottom: 0, left: 2),
                              ),
                            ),
                            value: _departmentSelectedValue,
                            items: _department
                                .map((e) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: e,
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: SizedBox(
                                          child: Text(e),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: ((value) {
                              setState(() {
                                _departmentSelectedValue = value;
                              });
                            })),
                      ),
                      // school year
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 5),
                          child: DropdownButtonFormField(
                              decoration: textInputDeco.copyWith(
                                contentPadding: const EdgeInsets.all(0),
                                prefixIconConstraints:
                                    const BoxConstraints(maxHeight: 20),
                                suffixIconConstraints:
                                    const BoxConstraints(maxHeight: 20),
                                floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 17),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                alignLabelWithHint: false,
                                labelText: 'Year',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 17),
                                hintStyle: const TextStyle(
                                    fontSize: 13, fontFamily: 'Sofia Pro'),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, right: 13, bottom: 0, left: 2),
                                ),
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, right: 12, bottom: 0, left: 2),
                                ),
                              ),
                              value: _schoolYearSelectedValue,
                              items: _schoolYear
                                  .map((e) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.center,
                                        value: e,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 3),
                                          child: SizedBox(
                                            child: Text(e),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: ((value) {
                                setState(() {
                                  _schoolYearSelectedValue = value;
                                });
                              })),
                        ),
                      ),
                      //section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 5),
                          child: DropdownButtonFormField(
                              decoration: textInputDeco.copyWith(
                                contentPadding: const EdgeInsets.all(0),
                                prefixIconConstraints:
                                    const BoxConstraints(maxHeight: 20),
                                suffixIconConstraints:
                                    const BoxConstraints(maxHeight: 20),
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, right: 12, bottom: 0, left: 2),
                                ),
                                floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 17),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                alignLabelWithHint: false,
                                labelText: 'Section',
                                labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 17),
                                hintStyle: const TextStyle(
                                    fontSize: 13, fontFamily: 'Sofia Pro'),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, right: 10.5, bottom: 0, left: 2),
                                ),
                              ),
                              value: _classSectionSelectedValue,
                              items: _classSection
                                  .map((e) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.center,
                                        value: e,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 3),
                                          child: SizedBox(
                                            child: Text(e),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: ((value) {
                                setState(() {
                                  _classSectionSelectedValue = value;
                                });
                              })),
                        ),
                      ),
                    ],
                  ),
                ),
                //student id
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: studentIdController,
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
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
                            if (!studentIdController.text
                                    .startsWith('2024-32') &&
                                !studentIdController.text
                                    .startsWith('2023-32') &&
                                !studentIdController.text
                                    .startsWith('2022-32') &&
                                !studentIdController.text
                                    .startsWith('2021-32') &&
                                !studentIdController.text
                                    .startsWith('2020-32') &&
                                !studentIdController.text
                                    .startsWith('2019-32')) {
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Security',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 21,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //password
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: isObscureTextPassword,
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sofia Pro',
                                fontSize: 17),
                            labelText: 'Password',
                            hintText: 'Create your password',
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
                                isObscureTextPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: primaryColor,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscureTextPassword =
                                      !isObscureTextPassword;
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
                      const SizedBox(height: 10),
                      //confirm password
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: isObscureTextConfirmPassword,
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sofia Pro',
                                fontSize: 17),
                            labelText: 'Confirm Password',
                            hintText: 'Re-enter Password',
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
                                isObscureTextConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: primaryColor,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscureTextConfirmPassword =
                                      !isObscureTextConfirmPassword;
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
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  child: CustomButton(
                    color: phoneFieldButtonColor,
                    onPressed: () {
                      if (firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          studentIdController.text.isEmpty) {
                        errorSnackbar(context, 'Oops!',
                            'Please fill in all fields correctly');
                      } else if (passwordController.text.trim().length < 8) {
                        errorSnackbar(context, 'Oops!',
                            'Password must be at least 8 characters');
                      } else if (studentIdController.text.trim().length != 11) {
                        errorSnackbar(context, 'Oops!',
                            'Please enter a valid student ID');
                      } else if (passwordController.text.trim() !=
                          confirmPasswordController.text.trim()) {
                        errorSnackbar(
                            context, 'Oops!', 'Passwords do not match');
                      } else if (passwordController.text.trim() ==
                          confirmPasswordController.text.trim()) {
                        signUp();
                      }
                    },
                    text: 'Sign Up',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    String? firstName = toBeginningOfSentenceCase(
        firstNameController.text.trim().toLowerCase());
    String? lastName =
        toBeginningOfSentenceCase(lastNameController.text.trim().toLowerCase());

    if (formKey.currentState!.validate()) {
      AuthService().signUpUserInfo(
        firstName: firstName!,
        lastName: lastName!,
        email: emailController.text.trim(),
        department: _departmentSelectedValue!,
        year: _schoolYearSelectedValue!,
        section: _classSectionSelectedValue!,
        studentId: studentIdController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
      );
    } else {
      errorSnackbar(context, 'Uh-oh!', 'Please fill all the fields correctly');
    }
  }
}
