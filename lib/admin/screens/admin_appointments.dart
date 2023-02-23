import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Stream<QuerySnapshot>? userAppointmentStream;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await DatabaseService().getUserAppointment().then((snapshot) {
      setState(() {
        userAppointmentStream = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Appointments',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Sofia Pro'),
        ),
        leading: IconButton(
            onPressed: (() {
              //TODO: Add back button functionality
            }),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream: userAppointmentStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: primaryColor,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    // final String fullName =
                    //     '${data['firstName']} ${data['lastName']}';
                    if (data['status'] == null) {
                      return const SizedBox.shrink();
                    }

                    final String userId = data['appointedUser'];
                    final String status = data['status'];
                    print(userId);
                    print(status);
                    return Container(
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 2, horizontal: 0),
                      color: Colors.grey[50],
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          print(snapshot);
                          if (!snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitChasingDots(
                                color: primaryColor,
                                size: 50,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }

                          Map<String, dynamic> userData =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return Column(
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                        '${userData['firstName']} ${userData['lastName']}'),
                                    const Spacer(),
                                    const Text(
                                      'view',
                                      style: TextStyle(
                                        fontFamily: 'Sofia Pro',
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: status == 'pending'
                                          ? Colors.red
                                          : status == 'completed'
                                              ? Colors.green
                                              : Colors.yellow,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        fontFamily: 'Sofia Pro',
                                        fontSize: 13,
                                        color: status == 'pending'
                                            ? Colors.red
                                            : status == 'completed'
                                                ? Colors.green
                                                : Colors.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
