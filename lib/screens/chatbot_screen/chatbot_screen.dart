import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _chatController = TextEditingController();

  //bot lottie visible
  bool isBotVisible = true;
  bool isRepeat = false;

  //hello im chatbot...
  bool helloImChatbotVisible = true;
  bool hideHelloImChatbot = true;

  //nice to meet you...
  bool niceToMeetYouVisible = true;
  bool hideNiceToMeetYou = false;

  //before we proceed i would like you to answer...
  bool beforeWeProceedVisible = true;
  bool hideBeforeWeProceed = false;

  //are you going to take it?
  bool areYouGoingToTakeItVisible = true;
  bool hideAreYouGoingToTakeIt = false;

  bool nextButtonVisible = true;
  bool nextButtonVisible2 = true;
  bool textFieldVisible = true;
  String userCallName = '';

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      setState(() {
        helloImChatbotVisible = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //hello im chatbot
          Visibility(
            visible: hideHelloImChatbot,
            replacement: const SizedBox.shrink(),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Visibility(
                    visible: helloImChatbotVisible,
                    replacement: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: const Text(
                        'Hi, I\'m Chatbot\nWhat should I call you?',
                        style: TextStyle(
                          height: 1.2,
                          color: Colors.white,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.bottomLeft,
                      child: Lottie.asset(
                        'assets/lottie/chat_typing.json',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //nice to meet you
          Visibility(
            visible: hideNiceToMeetYou,
            replacement: const SizedBox.shrink(),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Visibility(
                    visible: niceToMeetYouVisible,
                    replacement: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Text(
                        'Nice to meet you, $userCallName :)',
                        style: const TextStyle(
                          height: 1.2,
                          color: Colors.white,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.bottomLeft,
                      child: Lottie.asset(
                        'assets/lottie/chat_typing.json',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //before we proceed
          Visibility(
            visible: hideBeforeWeProceed,
            replacement: const SizedBox.shrink(),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Visibility(
                    visible: beforeWeProceedVisible,
                    replacement: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: const Text(
                        'Before we proceed, I would like\n'
                        'you to answer a 36 items\n'
                        'questionnaire.',
                        style: TextStyle(
                          height: 1.2,
                          color: Colors.white,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.bottomLeft,
                      child: Lottie.asset(
                        'assets/lottie/chat_typing.json',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //are you going to take it
          Visibility(
            visible: hideAreYouGoingToTakeIt,
            replacement: const SizedBox.shrink(),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Visibility(
                    visible: areYouGoingToTakeItVisible,
                    replacement: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: const Text(
                        'This questionnaire will help me\n'
                        'know you more. Are you going\n'
                        'to take it?',
                        style: TextStyle(
                          height: 1.2,
                          color: Colors.white,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.bottomLeft,
                      child: Lottie.asset(
                        'assets/lottie/chat_typing.json',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _lottieChatbot(
            context: context,
            isLottieChatbotVisible: isBotVisible,
            repeat: isRepeat,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: SizedBox(
              height: 55,
              child: Visibility(
                visible: textFieldVisible,
                replacement: Visibility(
                  visible: nextButtonVisible,
                  replacement: Visibility(
                    //for are you to take it
                    visible: nextButtonVisible2,
                    replacement: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //TODO
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nextButtonVisible2 = false; //hide the next button
                            });
                            Future.delayed(const Duration(milliseconds: 1500))
                                .then((value) {
                              setState(() {
                                areYouGoingToTakeItVisible = false;
                              });
                            });
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(100, 48)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                phoneFieldButtonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          child: const Text('Yes',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Sofia Pro')),
                        ),
                        const SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nextButtonVisible2 = false; //hide the next button
                            });
                            Future.delayed(const Duration(milliseconds: 1500))
                                .then((value) {
                              setState(() {
                                areYouGoingToTakeItVisible = false;
                              });
                            });
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(100, 48)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                phoneFieldButtonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                          child: const Text('No',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Sofia Pro')),
                        ),
                      ],
                      //TODO end
                    ),
                    child: ElevatedButton(
                      // next button for before we proceed
                      onPressed: () {
                        setState(() {
                          nextButtonVisible2 = false; //hide the next button
                          hideAreYouGoingToTakeIt = true;
                          isRepeat = false;
                        });
                        Future.delayed(const Duration(milliseconds: 1500))
                            .then((value) {
                          setState(() {
                            areYouGoingToTakeItVisible = false;
                          });
                        });
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(350, 48)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            phoneFieldButtonColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      child: const Text('Next',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Sofia Pro')),
                    ),
                  ),
                  child: ElevatedButton(
                    //next button for nice to meet you
                    onPressed: () {
                      setState(() {
                        hideBeforeWeProceed = true; //show the before we proceed
                        nextButtonVisible = false; //hide the next button
                      });
                      Future.delayed(const Duration(milliseconds: 1500))
                          .then((value) {
                        setState(() {
                          beforeWeProceedVisible = false;
                        });
                      });
                    },
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(350, 48)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          phoneFieldButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    child: const Text('Next',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Sofia Pro')),
                  ),
                ),
                child: TextField(
                  controller: _chatController,
                  decoration: InputDecoration(
                    hintText: 'You can call me...',
                    hintStyle: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFF1D3557), width: 1.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF1D3557), width: 1.8),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _onChatSend();
                      },
                      child: const Icon(
                        Icons.send,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChatSend() {
    String? fromChatController =
        toBeginningOfSentenceCase(_chatController.text.trim());
    if (_chatController.text.isNotEmpty) {
      setState(() {
        userCallName = fromChatController!; //to show the name of the user
        isRepeat = true; //repeat the animation of the chatbot
        textFieldVisible = false; //hide textfield and show the [Next] button
        hideHelloImChatbot = false; //false coz the default value of is true
        hideNiceToMeetYou = true; //show the nice to meet you
      });
      Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        setState(() {
          niceToMeetYouVisible = false;
        });
      });
    }
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

  Widget chatBubble({required String text}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
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
        ),
      ],
    );
  }

  //end of class
}
