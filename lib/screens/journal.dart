import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/journal_view.dart';
import 'package:student_mental_health/screens/video_player.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  String docId = '';
  String noteTitle = '';
  String noteContent = '';
  String noteDate = '';

  final List<String> _buttonImages = [
    "https://i.ibb.co/kqhgWSZ/neutral.png",
    "https://i.ibb.co/5jvNmMG/happy.png",
    "https://i.ibb.co/YQkPfCP/sad.png",
    "https://i.ibb.co/Sc01N34/angry.png",
    "https://i.ibb.co/W0rbnfB/scared.png",
    "https://i.ibb.co/dDh3M0K/stressed.png",
  ];
  final List _mood = [
    "Neutral",
    "Happy",
    "Sad",
    "Angry",
    "Scared",
    "Stressed",
  ];

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
            children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Journal',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 25,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('journal')
                  .where('id',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                  if (documents.isEmpty) {
                    return const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'There\'s nothing here yet,\ntap + to add one',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 20,
                        ),
                      ),
                    );
                  }

                  final List<Map<String, dynamic>> journalData = snapshot
                      .data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = journalData[index];

                      String mood = data['mood'];
                      String moodImage = _buttonImages[0];
                      if (mood == 'Neutral') {
                        moodImage = _buttonImages[0];
                      } else if (mood == 'Happy') {
                        moodImage = _buttonImages[1];
                      } else if (mood == 'Sad') {
                        moodImage = _buttonImages[2];
                      } else if (mood == 'Angry') {
                        moodImage = _buttonImages[3];
                      } else if (mood == 'Scared') {
                        moodImage = _buttonImages[4];
                      } else if (mood == 'Stressed') {
                        moodImage = _buttonImages[5];
                      }

                      return ListTile(
                        onTap: () {
                          nextScreen(
                              context,
                              JournalView(
                                journalId: documents[index].id,
                                journalTitle: data['title'],
                                journalContent: data['content'],
                                journalDate: data['date'],
                              ));
                          setState(() {
                            docId = documents[index].id;
                            noteTitle = data['title'];
                            noteContent = data['content'];
                            noteDate = data['date'];
                          });
                        },
                        leading: Container(
                          width: 60,
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(moodImage),
                            ),
                          ),
                        ),
                        title: Text(
                          data['title'] == '' ? 'Untitled' : data['title'],
                          style: const TextStyle(
                            fontFamily: 'Sofia Pro',
                          ),
                        ),
                        subtitle: Text(
                            data['content'] == '' ? 'empty' : data['content'],
                            style: const TextStyle(
                              fontFamily: 'Sofia Pro',
                            )),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('journal')
                                .doc(documents[index].id)
                                .delete();
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: primaryColor,
                      size: 50.0,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 80,
                // color: Colors.red,
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 300,
                        width: 200,
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
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FloatingActionButton(
                          elevation: 5,
                          onPressed: () async {
                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .addJournalNotes();
                            if (!mounted) return;
                            nextScreen(
                                context,
                                JournalView(
                                  journalId: docId,
                                  journalTitle: noteTitle,
                                  journalContent: noteContent,
                                  journalDate: noteDate,
                                ));
                          },
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          child: const Icon(
                            Icons.add,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
