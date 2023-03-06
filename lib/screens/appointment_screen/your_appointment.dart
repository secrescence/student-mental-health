import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(width: 20),
                          Text('Date',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          Text('Time',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          Text('Status',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(
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
                                'No schedule available',
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
                              Map<String, dynamic> data = document[index].data()
                                  as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: Row(
                                      children: [
                                        // const SizedBox(width: 20),
                                        Text(data['date'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const Spacer(),
                                        Text(data['time'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 35),
                                        Text(data['status'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(width: 20),
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
                  ],
                )),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: ifLowAndMidPriority,
                  child: ElevatedButton(
                    onPressed: () async {
                      await DatabaseService()
                          .addSchedule(context, '01-01-2023', '10:00 AM');
                    },
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(190, 48)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          phoneFieldButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    child: const Text('Create Appointment',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'Sofia Pro')),
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
