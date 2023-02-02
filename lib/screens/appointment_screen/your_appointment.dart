import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';

class YourAppointment extends StatefulWidget {
  const YourAppointment({super.key});

  @override
  State<YourAppointment> createState() => _YourAppointmentState();
}

class _YourAppointmentState extends State<YourAppointment> {
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
        .then((value) {
      setState(() {
        priority = value;
      });
      if (priority == 'Low Priority') {
        setState(() {
          ifLowAndMidPriority = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Your Appointment',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Sofia Pro'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                priority ?? 'No Appointment',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Sofia Pro'),
              ),
              const Spacer(),
              Visibility(
                visible: ifLowAndMidPriority,
                replacement: const SizedBox.shrink(),
                child: CustomButton(
                  text: 'Add Appointment',
                  onPressed: () {},
                  color: phoneFieldButtonColor,
                ),
              )
            ],
          ),
        ));
  }
}
