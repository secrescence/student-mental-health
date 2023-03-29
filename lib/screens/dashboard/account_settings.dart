import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool _isFirstNameEditing = false;
  bool _isLastNameEditing = false;
  bool _isEmailEditing = false;
  bool _isPhoneEditing = false;

  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    getUserData();
    passwordController.text = '**********';
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  getUserData() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getFirstName()
        .then((value) {
      firstNameController.text = value;
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getLastName()
        .then((value) {
      lastNameController.text = value;
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getEmail()
        .then((value) {
      emailController.text = value;
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserPhoneNumber()
        .then((value) {
      phoneController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Image.asset(
            'assets/logo-violet.png',
            fit: BoxFit.cover,
          ),
          leading: IconButton(
            onPressed: () {
              nextScreenPop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Sofia Pro',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Sofia Pro',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //first name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: firstNameController,
                    readOnly: !_isFirstNameEditing,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Sofia Pro',
                    ),
                    cursorColor: primaryColor,
                    decoration: textInputDecoForSettings.copyWith(
                      prefixText: 'First Name: ',
                      prefixStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Sofia Pro',
                        color: Colors.black,
                      ),
                      suffixIconColor: primaryColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isFirstNameEditing = !_isFirstNameEditing;
                          });
                          if (_isFirstNameEditing == false) {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updateFirstName(firstNameController.text);
                          }
                        },
                        icon: _isFirstNameEditing
                            ? const Icon(Icons.save)
                            : const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ),
              //last name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: lastNameController,
                    readOnly: !_isLastNameEditing,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Sofia Pro',
                    ),
                    cursorColor: primaryColor,
                    decoration: textInputDecoForSettings.copyWith(
                      prefixText: 'Last Name: ',
                      prefixStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Sofia Pro',
                        color: Colors.black,
                      ),
                      suffixIconColor: primaryColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isLastNameEditing = !_isLastNameEditing;
                          });
                          if (_isLastNameEditing == false) {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updateLastName(lastNameController.text);
                          }
                        },
                        icon: _isLastNameEditing
                            ? const Icon(Icons.save)
                            : const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ),
              //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    readOnly: !_isEmailEditing,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Sofia Pro',
                      overflow: TextOverflow.ellipsis,
                    ),
                    cursorColor: primaryColor,
                    decoration: textInputDecoForSettings.copyWith(
                      prefixText: 'Email: ',
                      prefixStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Sofia Pro',
                        color: Colors.black,
                      ),
                      suffixIconColor: primaryColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isEmailEditing = !_isEmailEditing;
                          });
                          if (_isEmailEditing == false) {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updateEmail(emailController.text);
                          }
                        },
                        icon: _isEmailEditing
                            ? const Icon(Icons.save)
                            : const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ),
              //phone number
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: phoneController,
                    readOnly: !_isPhoneEditing,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Sofia Pro',
                      overflow: TextOverflow.ellipsis,
                    ),
                    cursorColor: primaryColor,
                    decoration: textInputDecoForSettings.copyWith(
                      prefixText: 'Phone Number: ',
                      prefixStyle: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'Sofia Pro',
                        color: Colors.black,
                      ),
                      suffixIconColor: primaryColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPhoneEditing = !_isPhoneEditing;
                          });
                          if (_isPhoneEditing == false) {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .updatePhone(phoneController.text);
                          }
                        },
                        icon: _isPhoneEditing
                            ? const Icon(Icons.save)
                            : const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ),
              //change password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: primaryColor,
                    decoration: textInputDecoForSettings.copyWith(
                      // contentPadding: const EdgeInsets.all(0),
                      // prefixIconConstraints:
                      //     const BoxConstraints(maxHeight: 15),
                      // suffixIconConstraints:
                      //     const BoxConstraints(maxHeight: 40),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                            top: 15, right: 0, bottom: 0, left: 10),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Sofia Pro',
                          ),
                        ),
                      ),
                      suffixIconColor: primaryColor,
                      suffixIcon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),

              //support
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: const Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Sofia Pro',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: primaryColor,
                      decoration: textInputDecoForSettings.copyWith(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 15),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 40),
                        hintStyle: const TextStyle(
                            fontSize: 13, fontFamily: 'Sofia Pro'),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 10),
                          child: Text(
                            'Help',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Sofia Pro',
                            ),
                          ),
                        ),
                        suffixIconColor: primaryColor,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: primaryColor,
                      decoration: textInputDecoForSettings.copyWith(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 15),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 40),
                        hintStyle: const TextStyle(
                            fontSize: 13, fontFamily: 'Sofia Pro'),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 10),
                          child: Text(
                            'Terms of Service',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Sofia Pro',
                            ),
                          ),
                        ),
                        suffixIconColor: primaryColor,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: primaryColor,
                      decoration: textInputDecoForSettings.copyWith(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIconConstraints:
                            const BoxConstraints(maxHeight: 15),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 40),
                        hintStyle: const TextStyle(
                            fontSize: 13, fontFamily: 'Sofia Pro'),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              top: 0, right: 0, bottom: 0, left: 10),
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Sofia Pro',
                            ),
                          ),
                        ),
                        suffixIconColor: primaryColor,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              Center(
                child: CustomButton(
                    text: 'Sign out',
                    onPressed: () => FirebaseAuth.instance.signOut().then(
                        (value) =>
                            nextScreenReplace(context, const Onboarding())),
                    color: phoneFieldButtonColor),
              ),
              const SizedBox(height: 50),
              const Text(
                '2023 © Student\'s Mental Health',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Sofia Pro',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
