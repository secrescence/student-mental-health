import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/auth/signin.dart';
import 'package:student_mental_health/service/auth_service.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/message_tile.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class ChatPage extends StatefulWidget {
  final String userName;
  final String chatId;
  const ChatPage({Key? key, required this.userName, required this.chatId})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  AuthService authService = AuthService();
  final String userName = '';
  bool isTextfieldVisible = true;
  bool isYesOrNoVisible = false;
  bool isReady = false;
  String answer = '';

  @override
  void initState() {
    getChat();
    super.initState();
  }

  getChat() {
    DatabaseService().getChats(widget.chatId).then((val) {
      setState(() {
        chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset('assets/logoblue.png'),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1D3557),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await authService.signOutUser();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMesssages(),

          // textfield
          Visibility(
            visible: isTextfieldVisible,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[700],
                child: Row(children: [
                  Expanded(
                      child: TextFormField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      //send message
                      sendMessage(widget.chatId);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D3557),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                    ),
                  )
                ]),
              ),
            ),
          ),

          //yes or no button
          Visibility(
            visible: isYesOrNoVisible,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(85, 40),
                          backgroundColor: const Color(0xFF1D3557),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          )),
                      onPressed: (() {
                        setState(() {
                          answer = 'Yes';
                          sendOption(widget.chatId);
                        });
                      }),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(85, 40),
                          backgroundColor: const Color(0xFF1D3557),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          )),
                      onPressed: (() {
                        setState(() {
                          answer = 'No';
                          sendOption(widget.chatId);
                        });
                      }),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //is ready
          Visibility(
            visible: isReady,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(85, 40),
                          backgroundColor: const Color(0xFF1D3557),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          )),
                      onPressed: (() {
                        setState(() {
                          answer = 'I\'m ready';
                          sendReady(widget.chatId);
                        });
                      }),
                      child: const Text('I\'m ready'),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //display the all the chats
  chatMesssages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index]['message'],
                    sender: snapshot.data.docs[index]['sender'],
                    sentByMe:
                        widget.userName == snapshot.data.docs[index]['sender'],
                    fromChatbotYesOrNo:
                        snapshot.data.docs[index]['sender'] == 'chatbot5',
                    fromChatbotReady:
                        snapshot.data.docs[index]['sender'] == 'chatbot7',
                  );
                },
              )
            : Container();
      },
    );
  }

  // user click the send button in the textfield
  sendMessage(String chatId) async {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      await chatbotMessage(widget.chatId);

      DatabaseService().sendMessage(chatId, chatMessageMap);
      // setState(() {
      //   messageController.clear();
      // });
    }
  }

  // chatbot replies 2nd
  chatbotMessage(String chatId) async {
    // check if user replied. if true, hide textfield
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.chatId)
        .collection('messages')
        .doc(chatId)
        .get();
    // if (snapshot.data() != null && snapshot.data()!.isNotEmpty) {
    //   setState(() {
    //     isVisible = !isVisible;
    //   });
    // }
    if (!await DatabaseService(uid: chatId)
            .ifUserReplied(chatId, widget.userName) ||
        snapshot.data() != null && snapshot.data()!.isNotEmpty) {
      setState(() {
        isTextfieldVisible = !isTextfieldVisible;
      });
      Timer(
          const Duration(milliseconds: 3100),
          () => setState(() {
                isYesOrNoVisible = !isYesOrNoVisible;
              }));
      DatabaseService(uid: widget.chatId).chatbotResponse(
          widget.chatId,
          'Nice to meet you ${toBeginningOfSentenceCase(messageController.text)} :)',
          '2',
          'CHATBOT');
      Timer(
        const Duration(milliseconds: 1200),
        () => DatabaseService(uid: widget.chatId).chatbotResponse(
            widget.chatId,
            'Before we proceed I would like you to answer a 36 items questionnaire.',
            '3',
            'CHATBOT'),
      );
      Timer(
        const Duration(milliseconds: 2200),
        () => DatabaseService(uid: widget.chatId).chatbotResponse(
            widget.chatId,
            'This questionnaire will help me to know you more. Are you going to take it?',
            '4',
            'CHATBOT'),
      );
    }
  }

  //collect the answer of the user, yes or no, in 2nd
  sendOption(String chatId) async {
    Map<String, dynamic> chatMessageMap = {
      "message": answer,
      "sender": widget.userName,
      "time": DateTime.now().millisecondsSinceEpoch,
    };

    DatabaseService().sendOption(chatId, chatMessageMap);

    ifChooseYesOrNo(chatId);
  }

  //if user will answer the questionnaire or not. 3rd reply
  ifChooseYesOrNo(String chatId) async {
    if (await DatabaseService().ifUserChoosesYesOrNo(chatId, answer) &&
        answer == 'Yes') {
      setState(() {
        isYesOrNoVisible = !isYesOrNoVisible;
      });
      DatabaseService(uid: widget.chatId).chatbotResponse(widget.chatId,
          'Alright! Please click the button bellow:', '5', 'chatbot5');
    }
    if (await DatabaseService().ifUserChoosesYesOrNo(chatId, answer) &&
        answer == 'No') {
      setState(() {
        isYesOrNoVisible = !isYesOrNoVisible;
        isReady = !isReady;
      });
      DatabaseService(uid: widget.chatId).chatbotResponse(
          widget.chatId,
          'Alright! ${toBeginningOfSentenceCase(messageController.text)}. Tell me you when are ready.',
          '6',
          'chatbot6');
    }
  }

  sendReady(String chatId) async {
    Map<String, dynamic> chatMessageMap = {
      "message": answer,
      "sender": widget.userName,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
    DatabaseService().sendOption(chatId, chatMessageMap);
    ifReady(chatId);
  }

  ifReady(String chatId) async {
    if (await DatabaseService().ifUserChoosesYesOrNo(chatId, answer) &&
        answer == 'I\'m ready') {
      DatabaseService(uid: widget.chatId).chatbotResponse(widget.chatId,
          'Alright! Please click the button bellow:', '7', 'chatbot7');
      setState(() {
        isReady = !isReady;
      });
    }
  }
}
