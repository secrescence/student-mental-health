import 'package:flutter/material.dart';

class Lower extends StatelessWidget {
  const Lower(
      {Key? key,
      required this.title,
      required this.paddingForLower,
      required this.paddingForLowerTitle})
      : super(key: key);
  final String title;
  final double paddingForLower;
  final double paddingForLowerTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingForLower),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: paddingForLowerTitle, left: 28),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 30,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D3557)),
          ),
        ),
      ),
    );
  }
}
