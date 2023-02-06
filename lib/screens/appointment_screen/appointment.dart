import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List<Map<String, dynamic>> listOfSchedule = [];
  bool scheduleIsNotEmpty = true;

  Stream<QuerySnapshot>? scheduleStream;

  @override
  void initState() {
    getListOfSchedule();
    super.initState();
  }

  getListOfSchedule() async {
    await DatabaseService().getSchedulesOfDateNow().then((value) {
      if (value == null) {
        setState(() {
          listOfSchedule = value;
        });
      } else {
        setState(() {
          scheduleIsNotEmpty = false;
        });
      }
    });

    await DatabaseService().getSchedules().then((snapshot) {
      setState(() {
        scheduleStream = snapshot;
      });
      print(snapshot);
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
              nextScreenPop(context);
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
                          SizedBox(width: 45),
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
                          SizedBox(width: 28),
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
                              child: SpinKitSpinningLines(
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 35),
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
                                        const SizedBox(width: 40),
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
                ElevatedButton(
                  onPressed: () async {
                    // await DatabaseService()
                    //     .getUidScheduleOfDateNow()
                    //     .then((value) async {
                    //   if (!value.toString().contains(
                    //       "${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}")) {
                    //     setState(() {
                    //       incrementForDateOfAppointment = 1;
                    //     });
                    //     await DatabaseService().addSchedule(
                    //         schedule, incrementForDateOfAppointment);
                    //   } else {
                    //     setState(() {
                    //       incrementForDateOfAppointment++;
                    //     });
                    //     await DatabaseService().addSchedule(
                    //         schedule, incrementForDateOfAppointment);
                    //     print('w');
                    //   }
                    // });
                    // await DatabaseService()
                    //     .getAllSchedules()
                    //     .then((value) => print(value));
                    await DatabaseService().addSchedule('01-01-2023', '11:23');
                  },
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(190, 48)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(phoneFieldButtonColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  child: const Text('Create Appointment',
                      style: TextStyle(fontSize: 16, fontFamily: 'Sofia Pro')),
                ),
              ],
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
