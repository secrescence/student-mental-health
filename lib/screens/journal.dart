import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (() {
              nextScreenPop(context);
            }),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            )),
      ),
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
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: primaryColor,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Add your action here
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
