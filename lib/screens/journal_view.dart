import 'package:flutter/material.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class JournalView extends StatefulWidget {
  final int selectedMoodIndex;
  final String journalId;
  final String journalTitle;
  final String journalContent;
  final String journalDate;
  const JournalView({
    super.key,
    required this.selectedMoodIndex,
    required this.journalId,
    required this.journalTitle,
    required this.journalContent,
    required this.journalDate,
  });

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  String noteTitle = '';
  String noteContent = '';

  List<bool> _isSelected = [false, false, false, false, false, false];
  final List<String> _buttonImages = [
    "https://i.ibb.co/kqhgWSZ/neutral.png",
    "https://i.ibb.co/5jvNmMG/happy.png",
    "https://i.ibb.co/YQkPfCP/sad.png",
    "https://i.ibb.co/Sc01N34/angry.png",
    "https://i.ibb.co/W0rbnfB/scared.png",
    "https://i.ibb.co/dDh3M0K/stressed.png",
  ];
  final List _mood = [
    "neutral",
    "happy",
    "sad",
    "angry",
    "scared",
    "stressed",
  ];

  @override
  void initState() {
    _isSelected[widget.selectedMoodIndex] = true;
    super.initState();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.journalDate,
                    style: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'What\'s your mood today?',
                  style: TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ToggleButtons(
                isSelected: _isSelected,
                onPressed: (int index) async {
                  setState(() {
                    _isSelected =
                        List.generate(_isSelected.length, (i) => i == index);
                  });
                  int selectedIndex = _isSelected.indexOf(true);
                  await DatabaseService().updateJournalMood(
                      widget.journalId, _mood[selectedIndex]);
                },
                renderBorder: false,
                constraints: const BoxConstraints(minWidth: 65, minHeight: 60),
                color: Colors.black,
                selectedColor: Colors.white,
                fillColor: primaryColor.withOpacity(0.9),
                highlightColor: Colors.white,
                splashColor: Colors.white,
                disabledColor: Colors.blue,
                disabledBorderColor: Colors.amber,
                children: List.generate(
                  _buttonImages.length,
                  (index) => Column(
                    children: [
                      Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_buttonImages[index]),
                            // fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onChanged: (value) async {
                    await DatabaseService()
                        .updateJournalTitle(widget.journalId, value);
                  },
                  initialValue: widget.journalTitle,
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
                child: TextFormField(
                  onChanged: (value) async {
                    await DatabaseService()
                        .updateJournalContent(widget.journalId, value);
                  },
                  initialValue: widget.journalContent,
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
                  maxLines: 25,
                  cursorColor: primaryColor,
                ),
              ),
            ],
          ),
        ));
  }
}
