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
  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser!.uid);
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
                        },
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
                            print(Random().nextInt(90000) + 10000);
                            String documentId =
                                "P4RadET3HpW7p8aduPMwJ9ty6f22-14121";
                            String userId = documentId.split("-")[0];
                            print(userId);
                            // nextScreen(context, const JournalView());
                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .addJournalNotes();
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
