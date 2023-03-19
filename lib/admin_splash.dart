import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/admin/auth/admin_signin.dart';
import 'package:student_mental_health/admin/screens/admin_navigation.dart';
import 'package:student_mental_health/helper/helper_function.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AdminSplash extends StatefulWidget {
  const AdminSplash({super.key});

  @override
  State<AdminSplash> createState() => _AdminSplashState();
}

class _AdminSplashState extends State<AdminSplash> {
  bool _isAdminSignedIn = false;

  StreamSubscription<QuerySnapshot>? queueSubscription;

  @override
  void initState() {
    handleAppointments();
    getAdminLoggedInStatus();
    Future.delayed(const Duration(milliseconds: 500)).then((value) =>
        _isAdminSignedIn
            ? nextScreen(context, const AdminNavigation())
            : nextScreen(context, const AdminSignIn()));
    super.initState();
  }

  getAdminLoggedInStatus() async {
    await HelperFunctions.getAdminLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isAdminSignedIn = value;
        });
      }
    });
  }

  Future<void> handleAppointments() async {
    queueSubscription = FirebaseFirestore.instance
        .collection('appointmentsQueue')
        .orderBy('priority')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) async {
      // Find an available slot
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        final int priority = doc.get('priority');
        final String userId = doc.get('userId');
        final QuerySnapshot appointmentsSnapshot = await FirebaseFirestore
            .instance
            .collection('appointments')
            .where('appointedUser', isEqualTo: '')
            .where('appointedUserPriority', isEqualTo: priority)
            .orderBy('date')
            .orderBy('time')
            .limit(1)
            .get();
        if (appointmentsSnapshot.docs.isNotEmpty) {
          final String appointmentId = appointmentsSnapshot.docs[0].id;
          await FirebaseFirestore.instance
              .collection('appointments')
              .doc(appointmentId)
              .update({
            'appointedUser': userId,
          });
          await doc.reference.delete();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(
                'assets/logo-white-splash.png',
              ),
            ),
            const Expanded(
              child: SpinKitChasingDots(
                color: Colors.white,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
