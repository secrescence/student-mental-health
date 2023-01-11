// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_mental_health/screens/chat_page.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Welcome extends StatefulWidget {
  final String userName;
  final String chatId;
  const Welcome({super.key, required this.chatId, required this.userName});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/welcomesvg.svg'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            'We care about your mental well-being. Start now and we’ll get you through.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 60),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              backgroundColor: const Color(0xFF1D3557),
              shape: const StadiumBorder(),
            ),
            onPressed: () async {
              //check kung na send na ang welcome msg
              final snapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.chatId)
                  .collection('messages')
                  .get();
              if (snapshot.docs.isEmpty) {
                // if not, excute this
                Timer(
                  const Duration(seconds: 1),
                  () => DatabaseService(uid: widget.chatId).chatbotResponse(
                      widget.chatId,
                      'Hello I am Chatbot, What\'s your name?',
                      '1',
                      'CHATBOT'),
                );
                nextScreen(context,
                    ChatPage(userName: widget.userName, chatId: widget.chatId));
              } else {
                nextScreen(context,
                    ChatPage(userName: widget.userName, chatId: widget.chatId));
              }
            },
            child: const Text(
              "Let's Go",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
