import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class StudentsResults extends StatefulWidget {
  const StudentsResults({super.key});

  @override
  State<StudentsResults> createState() => _StudentsResultsState();
}

class _StudentsResultsState extends State<StudentsResults> {
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
