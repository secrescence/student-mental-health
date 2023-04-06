import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class LoadingAdmin extends StatelessWidget {
  const LoadingAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(height: 300),
        SpinKitChasingDots(color: primaryColor, size: 50),
        SizedBox(height: 20),
        Text(
          'Loading...',
          style: TextStyle(
            fontSize: 15,
            color: primaryColor,
            fontFamily: 'Sofia Pro',
          ),
        ),
      ],
    );
  }
}
