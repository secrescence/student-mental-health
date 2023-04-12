import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class YourAppointment extends StatefulWidget {
  const YourAppointment({super.key});

  @override
  State<YourAppointment> createState() => _YourAppointmentState();
}

class _YourAppointmentState extends State<YourAppointment> {
  Stream<QuerySnapshot>? dateOfAppointmentStream;
  String dateThatCurrentUserIsAppointed = '';
  String? priority;
  bool ifLowPriority = false;
  bool ifInWaitingList = false;

  @override
  void initState() {
    getPriority();
    super.initState();
  }

  getPriority() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getIsInWaitingList()
        .then((value) async {
      if (value == true) {
        setState(() {
          ifInWaitingList = true;
        });
      }
    });

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .whatDateTheCurrentUserIsAppointed()
        .then((value) async {
      setState(() {
        dateOfAppointmentStream = value;
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
        leading: IconButton(
            onPressed: () {
              nextScreenPop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            )),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      alignment: Alignment.topLeft,
                      child: const Text('Your Appointment',
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: 'Sofia Pro',
                              fontWeight: FontWeight.w700)),
                    ),
                    const Divider(
                        thickness: 1, color: Color(0xFFE5E5E5), height: 0),
                    Expanded(
                      child: SizedBox(
                        height: 300,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: dateOfAppointmentStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return const Center(
                                child: SpinKitChasingDots(
                                  color: primaryColor,
                                  size: 50,
                                ),
                              );
                            }
                            final List<DocumentSnapshot> document =
                                snapshot.data!.docs;

                            if (document.isEmpty) {
                              return const Center(
                                child: Text(
                                  'You have no appointment yet.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Sofia Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }

                            return Table(
                              children: [
                                const TableRow(
                                  children: [
                                    TableCell(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Date',
                                            style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Time',
                                            style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ...document.map((snapshot) {
                                  Map<String, dynamic> data =
                                      snapshot.data() as Map<String, dynamic>;
                                  return TableRow(
                                    children: [
                                      TableCell(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data['date'],
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data['time'],
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data['status'],
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 40),
          Visibility(
            visible: ifLowPriority,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Note: You are now in our waiting list. Mind that appointment may take long to make way for others who needs urgent attention. For the mean time you can explore other resources while waiting. We will immediately notify you in your email once slot is available. Thank you.',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 15,
                  fontFamily: 'Sofia Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Visibility(
            visible: ifInWaitingList,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Note: The appointment slots are full as of the moment. We will notify you via email once you get a slot. You are our priority so waiting won\'t take that long. Thank you for understanding.',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 15,
                  fontFamily: 'Sofia Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
