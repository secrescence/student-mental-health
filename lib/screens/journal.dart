import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/video_player.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
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
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('journal')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: primaryColor,
                      size: 50,
                    ),
                  );
                }
                Map<String, dynamic> journalData =
                    snapshot.data!.data() as Map<String, dynamic>;
                List<String> noteIds = journalData.keys
                    .where((key) => key.startsWith('note'))
                    .toList();

                return ListView.builder(
                  itemCount: noteIds.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> noteData =
                        journalData[noteIds[index]] as Map<String, dynamic>;
                    return ListTile(
                      onTap: () {},
                      title: Text(
                        noteData['title'],
                        style: const TextStyle(fontFamily: 'Sofia Pro'),
                      ),
                      subtitle: Text(
                        noteData['content'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Spacer(),
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
                        await FirebaseFirestore.instance
                            .collection('journal')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get()
                            .then((value) =>
                                print(value.data()!['note1']['title']));
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
    );
  }
}
