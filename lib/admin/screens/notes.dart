import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      body: Center(
        child: Text('Notes'),
      ),
    );
  }
}
