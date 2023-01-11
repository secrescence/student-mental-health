import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/questionnaire_page.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final bool fromChatbotYesOrNo;
  final bool fromChatbotReady;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.sentByMe,
      required this.sender,
      required this.fromChatbotYesOrNo,
      required this.fromChatbotReady})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sentByMe ? 0 : 24,
          right: widget.sentByMe ? 24 : 0),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.sentByMe ? const Color(0xFF1D3557) : Colors.grey,
                spreadRadius: 0.5,
                blurRadius: widget.sentByMe ? 0.5 : 2,
              )
            ],
            borderRadius: widget.sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            color:
                widget.sentByMe ? const Color(0xFF1D3557) : Colors.grey[200]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   widget.sender.toUpperCase(),
            //   textAlign: TextAlign.start,
            //   style: const TextStyle(
            //       fontSize: 13,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white,
            //       letterSpacing: -0.5),
            // ),
            const SizedBox(
              height: 8,
            ),
            // widget.fromChatbot
            //     ? Text('sseq')
            //     :
            widget.fromChatbotYesOrNo || widget.fromChatbotReady
                ? SizedBox(
                    width: 230,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/questionnaire.png',
                          scale: 2,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Answer this questions',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(130, 40),
                            backgroundColor: const Color(0xFF1D3557),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          onPressed: (() {
                            nextScreen(context, const QuestionnairePage());
                          }),
                          child: const Text('Start'),
                        ),
                      ],
                    ),
                  )
                : Text(
                    widget.message,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        color: widget.sentByMe ? Colors.white : Colors.black),
                  ),
          ],
        ),
      ),
    );
  }
}
