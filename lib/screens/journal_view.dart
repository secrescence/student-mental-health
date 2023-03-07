import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class JournalView extends StatefulWidget {
  final String journalId;
  final String journalTitle;
  final String journalContent;
  final String journalDate;
  const JournalView({
    super.key,
    required this.journalId,
    required this.journalTitle,
    required this.journalContent,
    required this.journalDate,
  });

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  List<bool> _isSelected = [false, false, false, false, false, false];
  List<String> _buttonTexts = [
    "Undecided",
    "Happy",
    "Sad",
    "Angry",
    "Anxious",
    "Stressed",
  ];
  List<String> _buttonImages = [
    "https://via.placeholder.com/150/FF0000/FFFFFF",
    "https://via.placeholder.com/150/00FF00/FFFFFF",
    "https://via.placeholder.com/150/0000FF/FFFFFF",
    "https://via.placeholder.com/150/FFFF00/FFFFFF",
    "https://via.placeholder.com/150/00FFFF/FFFFFF",
    "https://via.placeholder.com/150/FF00FF/FFFFFF",
  ];

  int _selectedIndex = -1;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              ToggleButtons(
                isSelected: _isSelected,
                onPressed: (int index) {
                  setState(() {
                    if (_selectedIndex == index) {
                      // The button is already selected, so deselect it
                      _isSelected[index] = false;
                      _selectedIndex = -1;
                    } else {
                      // Deselect the currently selected button (if any)
                      if (_selectedIndex != -1) {
                        _isSelected[_selectedIndex] = false;
                      }
                      // Select the clicked button
                      _isSelected[index] = true;
                      _selectedIndex = index;
                    }
                  });
                },
                renderBorder: false,
                constraints: const BoxConstraints(minWidth: 68, minHeight: 36),
                color: Colors.black,
                selectedColor: Colors.black,
                fillColor: Colors.red,
                highlightColor: Colors.white,
                splashColor: Colors.green,
                disabledColor: Colors.blue,
                disabledBorderColor: Colors.amber,
                borderWidth: 60,
                children: List.generate(
                  _buttonTexts.length,
                  (index) => Column(
                    children: [
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_buttonImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _buttonTexts[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Sofia Pro',
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  cursorColor: primaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // color: Colors.amber,
                child: TextField(
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Write your thoughts here...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Sofia Pro',
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 15,
                  cursorColor: primaryColor,
                ),
              ),
            ],
          ),
        ));
  }
}
