import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      body: Center(
        child: Text('Students Results'),
      ),
    );
  }
}
