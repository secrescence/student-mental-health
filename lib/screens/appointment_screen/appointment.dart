import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/appointment_screen/your_appointment.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  Map<String, dynamic> schedule = {
    "date": "8-23-20",
    "time": "1:00",
    "availability": false,
  };

  Stream<QuerySnapshot>? scheduleStream;

  bool isCreateAppointmentButtonVisible = true;

  @override
  void initState() {
    getListOfSchedule();
    checkPriority();
    super.initState();
  }

  getListOfSchedule() async {
    await DatabaseService().getSchedules().then((snapshot) {
      setState(() {
        scheduleStream = snapshot;
      });
    });
  }

  checkPriority() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .checkPriority()
        .then((value) async {
      if (value == 'High Priority' || value == 'Mid Priority') {
        setState(() {
          isCreateAppointmentButtonVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          'assets/logo-violet.png',
          fit: BoxFit.cover,
        ),
        leading: IconButton(
            onPressed: (() {
              //TODO change this to navigate pop
              nextScreenPop(context);
              // nextScreenPop(context);
            }),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Guidance and Counseling',
            style: TextStyle(
              color: phoneNumberInOtpColor,
              fontSize: 18,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Appointment and Schedule',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Sofia Pro',
            ),
          ),
          Container(
            width: double.infinity,
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                      child: const Text('Schedule',
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'Sofia Pro',
                            fontWeight: FontWeight.w500,
                          )),
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
                          Spacer(),
                          Text('Date',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                          SizedBox(width: 70),
                          Text('Time',
                              style: TextStyle(
                                fontSize: 15.5,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w400,
                              )),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: scheduleStream,
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
                          List<DocumentSnapshot> schedule = snapshot.data!.docs;
                          if (schedule.isEmpty) {
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
                            itemCount: schedule.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = schedule[index].data()
                                  as Map<String, dynamic>;
                              return Column(
                                children: [
                                  // const Divider(
                                  //   height: 0,
                                  //   thickness: 0.7,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: Row(
                                      children: [
                                        // const SizedBox(width: 35),
                                        const Spacer(),
                                        Text(data['date'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const Spacer(),
                                        const SizedBox(width: 40),
                                        Text(data['time'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Sofia Pro',
                                              fontWeight: FontWeight.w400,
                                            )),
                                        // const SizedBox(width: 40),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                  // const Divider(
                                  //   height: 0,
                                  //   thickness: 0.7,
                                  // ),
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
          Visibility(
            visible: isCreateAppointmentButtonVisible,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'Create Appointment',
                            style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w600),
                          ),
                          content: const SizedBox(
                            height: 50,
                            child: SingleChildScrollView(
                              child: Text(
                                  'Are you sure you want to create an appointment?',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    height: 1.50,
                                  )),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  nextScreenPop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Sofia Pro'),
                                )),
                            ElevatedButton(
                                onPressed: () async {
                                  await DatabaseService(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .appointUser(context, '3')
                                      .then((value) {
                                    nextScreenPop(context);
                                    nextScreen(
                                        context, const YourAppointment());
                                  });
                                },
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(80, 40)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          phoneFieldButtonColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Okay',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sofia Pro'),
                                ))
                          ],
                        ),
                      );
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
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              nextScreen(context, const YourAppointment());
            },
            child: Container(
              width: double.infinity,
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: const [
                      Text(
                        'Your Appointment',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontFamily: 'Sofia Pro',
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black87,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
