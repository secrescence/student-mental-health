import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/screens/appointment_screen/appointment.dart';
import 'package:student_mental_health/screens/appointment_screen/your_appointment.dart';
import 'package:student_mental_health/screens/dashboard/articles.dart';
import 'package:student_mental_health/screens/dashboard/journal.dart';
import 'package:student_mental_health/screens/dashboard/account_settings.dart';
import 'package:student_mental_health/screens/dashboard/my_result.dart';
import 'package:student_mental_health/screens/dashboard/videos.dart';
import 'package:student_mental_health/screens/questionnaire_screen/take_questionnaire_again.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class ResultOverallAlsoDashboard extends StatefulWidget {
  const ResultOverallAlsoDashboard({super.key});

  @override
  State<ResultOverallAlsoDashboard> createState() =>
      _ResultOverallAlsoDashboardState();
}

class _ResultOverallAlsoDashboardState
    extends State<ResultOverallAlsoDashboard> {
  final TextEditingController _chatController = TextEditingController();
  //overall score
  double? overallScore;

  //what should i call you
  String whatShouldICallYou = '';

  //lottie chatbot
  bool isBotVisible = true;
  bool isRepeat = true;

  //priority dialog
  //TODO put this to firestore
  String highPriority1 =
      'As a result, I strongly encourage you\nto talk with our school\'s guidance\ncounselor. Our expert will help and\ngive the necessary support that you\nneed.';
  String highPriority2 = 'Click next to continue';
  String midPriority1 =
      'As a result, I would like you to check\nout some articles and videos that we\ngathered just for you! You can also reach\nout to our school\'s guidance counselor\nAnytime you want.';
  String midPriority2 = 'I hope you enjoy 🙂';
  String lowPriority1 =
      'As a result, I would like you to\ncheck out some articles and\nvideos that we gathered just\nfor you!';
  String lowPriority2 = 'I hope you enjoy 🙂';

  //first chat
  bool firstChatVisible = true;
  bool wholeFirstChatVisible = false;
  //second chat
  bool secondChatVisible = true;
  bool wholeSecondChatVisible = false;
  //third chat
  bool thirdChatVisible = true;
  bool wholeThirdChatVisible = false;
  //fourth chat
  bool fourthChatVisible = true;
  bool wholeFourthChatVisible = false;

  //third dialog
  String thirdDialog = '';
  //fourth dialog
  String fourthDialog = '';

  //is high mid/low priority
  bool isHighPriority = false;
  bool showHighPriority = false;
  bool isLowAndMidPriority = false;
  bool showLowAndMidPriority = false;

  String highestCategory = '';

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserData();
    setState(() {
      wholeFirstChatVisible = true;
    });
    Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      setState(() {
        firstChatVisible = false;
        isRepeat = false;
      });
    }).then((value) {
      setState(() {
        wholeSecondChatVisible = true;
      });
      Future.delayed(const Duration(milliseconds: 2000)).then((value) {
        setState(() {
          secondChatVisible = false;
        });
      }).then((value) {
        setState(() {
          wholeThirdChatVisible = true;
        });
        Future.delayed(const Duration(milliseconds: 2000)).then((value) {
          setState(() {
            thirdChatVisible = false;
          });
        }).then((value) {
          setState(() {
            wholeFourthChatVisible = true;
          });
          Future.delayed(const Duration(milliseconds: 2000)).then((value) {
            setState(() {
              fourthChatVisible = false;
            });
            if (isLowAndMidPriority == true) {
              setState(() {
                showLowAndMidPriority = true;
              });
              _showBottomSheet(context);
            } else if (isHighPriority == true) {
              setState(() {
                showHighPriority = true;
              });
            }
          });
        });
      });
    });
    super.initState();
  }

  getUserData() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .getUserWhatShouldICallYou()
        .then((value) {
      setState(() {
        whatShouldICallYou = toBeginningOfSentenceCase(value)!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .getOverallScore()
        .then((value) {
      setState(() {
        overallScore = value;
        if (overallScore! > 4) {
          thirdDialog = highPriority1;
          fourthDialog = highPriority2;
          isHighPriority = true;
        } else if (overallScore! >= 3.5 && overallScore! <= 3.9) {
          thirdDialog = midPriority1;
          fourthDialog = midPriority2;
          isLowAndMidPriority = true;
        } else if (overallScore! < 3.49) {
          thirdDialog = lowPriority1;
          fourthDialog = lowPriority2;
          isLowAndMidPriority = true;
        }
      });
    });
    _getHighestCategory().then((value) {
      setState(() {
        highestCategory = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          'assets/logo-violet.png',
          fit: BoxFit.cover,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              nextScreen(context, const AccountSettings());
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //first chat
          _visibleChat(
              isVisibleChat: firstChatVisible,
              wholeChatVisible: wholeFirstChatVisible,
              text: 'Hello again $whatShouldICallYou.'),
          const SizedBox(height: 10),
          //second chat
          _visibleChat(
              isVisibleChat: secondChatVisible,
              wholeChatVisible: wholeSecondChatVisible,
              text: 'I studied your result to understand\nand help you more. '),
          const SizedBox(height: 10),
          _visibleChat(
              isVisibleChat: thirdChatVisible,
              wholeChatVisible: wholeThirdChatVisible,
              text: thirdDialog),
          const SizedBox(height: 10),
          _visibleChat(
              isVisibleChat: fourthChatVisible,
              wholeChatVisible: wholeFourthChatVisible,
              text: fourthDialog),
          _lottieChatbot(
            context: context,
            isLottieChatbotVisible: isBotVisible,
            repeat: isRepeat,
          ),

          //next button
          Visibility(
            visible: showHighPriority,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 23),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showLowAndMidPriority = true;
                    showHighPriority = false;
                  });
                  Future.delayed(const Duration(milliseconds: 20))
                      .then((value) {
                    _showBottomSheet(context);
                  });
                  Future.delayed(const Duration(milliseconds: 50))
                      .then((value) {
                    nextScreen(context, const YourAppointment());
                  });
                },
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(350, 48)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(phoneFieldButtonColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                child: const Text('Next',
                    style: TextStyle(fontSize: 20, fontFamily: 'Sofia Pro')),
              ),
            ),
          ),
          Visibility(
              visible: showLowAndMidPriority,
              child: const SizedBox(
                height: 50,
              )),
          Visibility(
            visible: showLowAndMidPriority,
            child: GestureDetector(
              onVerticalDragStart: (details) {
                _showBottomSheet(context);
                setState(() {
                  showLowAndMidPriority = true;
                });
              },
              child: SizedBox(
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.grey[600],
                        ),
                        const Text(
                          'Swipe up to open',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Sofia Pro',
                          ),
                        ),
                      ])),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.white70,
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        builder: (context) => DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.258,
              maxChildSize: 0.258,
              minChildSize: 0.258,
              builder: (context, scrollController) => _bottomSheetUI(),
            ));
  }

  Widget _bottomSheetUI() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          GestureDetector(
            onVerticalDragDown: (details) {
              nextScreenPop(context);
            },
            child: Container(
              height: 7,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    nextScreen(
                        context, Articles(highestCategory: highestCategory));
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Articles',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontFamily: 'Sofia Pro'),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                GestureDetector(
                  onTap: () {
                    nextScreen(
                        context, Videos(highestCategory: highestCategory));
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Videos',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontFamily: 'Sofia Pro'),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, const Appointment());
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text('Appointment',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontFamily: 'Sofia Pro')),
                  ),
                ),
                const SizedBox(height: 13),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, const Journal());
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text('Journal',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontFamily: 'Sofia Pro')),
                  ),
                ),
                const SizedBox(height: 13),
                GestureDetector(
                  onTap: () async {
                    nextScreen(context, const TakeQuestionnaireAgain());
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text('Questionnaire',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontFamily: 'Sofia Pro')),
                  ),
                ),
                const SizedBox(height: 13),
                GestureDetector(
                  onTap: () async {
                    nextScreen(context, const MyResult());
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text('My Result',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontFamily: 'Sofia Pro')),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _visibleChat(
      {required bool isVisibleChat,
      required bool wholeChatVisible,
      required String text}) {
    return Visibility(
      visible: wholeChatVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Visibility(
              visible: isVisibleChat,
              replacement: _chatBubble(text: text),
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.bottomLeft,
                child: Lottie.asset(
                  'assets/lottie/chat_typing.json',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lottieChatbot(
      {required BuildContext context,
      required bool isLottieChatbotVisible,
      required bool repeat}) {
    return Visibility(
      visible: isLottieChatbotVisible,
      child: Container(
        width: 250,
        height: 250,
        alignment: Alignment.bottomLeft,
        child: Lottie.asset('assets/lottie/bot.json', repeat: repeat),
      ),
    );
  }

  Widget _chatBubble({required String text}) {
    return Row(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              height: 1.2,
              color: Colors.white,
              fontFamily: 'Sofia Pro',
            ),
          ),
        ),
      ],
    );
  }

  Future _getHighestCategory() async {
    final Map<String, dynamic>? data =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
            .getQuestionnaireResult();
    if (data != null) {
      double nonacceptance = twoDecimalPlace(data['categoryNonacceptanceMEAN']);
      double goals = twoDecimalPlace(data['categoryGoalsMEAN']);
      double impulse = twoDecimalPlace(data['categoryImpulseMEAN']);
      double awareness = twoDecimalPlace(data['categoryAwarenessMEAN']);
      double strategies = twoDecimalPlace(data['categoryStrategiesMEAN']);
      double clarity = twoDecimalPlace(data['categoryClarityMEAN']);

      List<double> categories = [
        nonacceptance,
        goals,
        impulse,
        awareness,
        strategies,
        clarity
      ];

      Map<String, double> categoryValues = {
        "Nonacceptance": nonacceptance,
        "Goals": goals,
        "Impulse": impulse,
        "Awareness": awareness,
        "Strategies": strategies,
        "Clarity": clarity
      };

      double maxValue = categories.reduce((a, b) => a > b ? a : b);
      String maxCategory = categoryValues.keys
          .firstWhere((key) => categoryValues[key] == maxValue);
      return maxCategory;
    } else {
      return null;
    }
  }

  twoDecimalPlace(double value) {
    String cut = value.toStringAsFixed(2);
    double cutDouble = double.parse(cut);
    return cutDouble;
  }

  //end of class
}
