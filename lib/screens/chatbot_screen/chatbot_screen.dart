import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _chatController = TextEditingController();
  bool chatTypingVisible = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      setState(() {
        chatTypingVisible = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Visibility(
                    visible: chatTypingVisible,
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
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset('assets/lottie/bot.json', repeat: false),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: SizedBox(
                height: 55,
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
                        print('Send');
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
          ],
        ));
  }
}
