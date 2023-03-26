import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

const textInputDeco = InputDecoration(
  labelStyle: TextStyle(color: Colors.white),
  border: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF1D3557), width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(10))),
);

const textInputDecoForSettings = InputDecoration(
  border: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF1D3557), width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(5))),
  disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(5))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(5))),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(5))),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: errorColor, width: 1.8),
      borderRadius: BorderRadius.all(Radius.circular(5))),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenPop(context) {
  Navigator.pop(context);
}

void nextScreenRemoveUntil(context, page) {
  Navigator.pushAndRemoveUntil(context, page, (route) => false);
}
