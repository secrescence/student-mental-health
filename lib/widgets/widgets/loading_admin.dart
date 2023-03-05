import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class LoadingAdmin extends StatelessWidget {
  const LoadingAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1350,
      height: 750,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
        ),
      ),
    );
  }
}
