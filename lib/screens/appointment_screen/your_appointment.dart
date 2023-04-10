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
  bool ifLowAndMidPriority = false;

  @override
  void initState() {
    getPriority();
    super.initState();
  }

  getPriority() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .checkPriority()
        .then((value) async {
      setState(() {
        priority = value;
      });
      if (priority == 'Low Priority') {
        setState(() {
          ifLowAndMidPriority = true;
        });
      }
    });

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .whatDateTheCurrentUserIsAppointed()
        .then((value) async {
      setState(() {
        dateOfAppointmentStream = value;
      });
      // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
      //     .getOnlySpecificScheduleDate(dateThatCurrentUserIsAppointed)
      //     .then((value) {
      //   setState(() {
      //     scheduleStream = value;
      //   });
      //   print(value);
      // });
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
                              fontWeight: FontWeight.w500)),
                    ),
                    const Divider(
                        thickness: 1, color: Color(0xFFE5E5E5), height: 0),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          // SizedBox(width: 20),
                          // Spacer(),
                          Text('Date',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          // SizedBox(width: 30),
                          Text('Time',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          // SizedBox(width: 30),
                          Text('Status',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          // SizedBox(width: 10),
                          // Spacer(),
                        ],
                      ),
                    ),
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

                            return ListView.builder(
                              itemCount: document.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data = document[index]
                                    .data() as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        children: [
                                          // const SizedBox(width: 20),
                                          // const Spacer(),
                                          Text(data['date'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Sofia Pro',
                                                fontWeight: FontWeight.w400,
                                              )),
                                          // const Spacer(),
                                          // const SizedBox(width: 30),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Text(data['time'],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Sofia Pro',
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                          // const SizedBox(width: 30),
                                          Text(data['status'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Sofia Pro',
                                                fontWeight: FontWeight.w400,
                                              )),
                                          const Spacer(),
                                          // const SizedBox(width: 20),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Visibility(
              visible: ifLowAndMidPriority,
              child: const Text(
                'Note: You are now in our waiting list. Mind that appointment may take long to make way for others who needs urgent attention. For the mean time you can explore other resources while waiting. We will immediately notify you in your email once slot is available. Thank you.',
                // textAlign: TextAlign.center,
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
