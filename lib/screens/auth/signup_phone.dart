import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';

class SignUpPhone extends StatefulWidget {
  const SignUpPhone({super.key});

  @override
  State<SignUpPhone> createState() => _SignUpPhoneState();
}

class _SignUpPhoneState extends State<SignUpPhone> {
  final TextEditingController phoneController = TextEditingController();
  final countryPicker = const FlCountryCodePicker();
  bool isEmpty = false;
  CountryCode? countryCode;
  CountryCode defaultCountryCode = const CountryCode(
    code: 'PH',
    name: 'Philippines',
    dialCode: '+63',
  );

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                    child: SvgPicture.asset(
                      'assets/phone_signup.svg',
                    ),
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
                    "Please enter your 10 digit phone number",
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: phoneFieldBGColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  child: InkWell(
                                    onTap: () async {
                                      final code =
                                          await countryPicker.showPicker(
                                        pickerMaxHeight: 400,
                                        context: context,
                                        initialSelectedLocale: 'PH',
                                      );
                                      setState(() {
                                        countryCode = code;
                                      });
                                    },
                                    child: SizedBox(
                                      width: 200,
                                      height: 10,
                                      child: countryCode == null
                                          ? defaultCountryCode.flagImage
                                          : countryCode?.flagImage,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 46,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: primaryColor,
                              controller: phoneController,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  phoneController.text = value;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: phoneFieldBGColor,
                                hintText: "Enter phone number",
                                hintStyle: TextStyle(
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: primaryColor.withOpacity(0.6),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                suffixIcon: phoneController.text.length == 10
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                    : phoneController.text.isEmpty
                                        ? Visibility(
                                            visible: isEmpty,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              margin:
                                                  const EdgeInsets.all(10.0),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: const Icon(
                                                Icons.error,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 30,
                                            width: 30,
                                            margin: const EdgeInsets.all(10.0),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            child: const Icon(
                                              Icons.error,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                  SizedBox(
                    width: 118,
                    height: 46,
                    child: CustomButton(
                      text: "Send",
                      onPressed: () => sendPhoneNumber(context),
                      color: phoneFieldButtonColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber(BuildContext context) async {
    String fromController = phoneController.text.trim();
    String? phoneNumberCollected = countryCode == null
        ? '${defaultCountryCode.dialCode}$fromController'
        : '${countryCode?.dialCode}$fromController';
    if (fromController.length == 10 && fromController.startsWith('9', 0)) {
      await HelperFunctions.saveUserLoggedInStatus(true);
      if (!mounted) return;
      await AuthService().signUpPhone(
        context: context,
        phoneNumber: phoneNumberCollected,
      );
    } else {
      setState(() {
        isEmpty = true;
      });
      errorSnackbar(context, 'Oops!',
          'The phone number is invalid. Make sure to enter a 10 digit phone number. Ex. 945*******');
    }
  }
}
