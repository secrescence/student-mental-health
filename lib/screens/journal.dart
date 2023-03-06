import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Journal',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 25,
                    )),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: 100,
        child: Card(
          elevation: 3,
          color: primaryColor,
        ),
      ),
    );
  }
}
