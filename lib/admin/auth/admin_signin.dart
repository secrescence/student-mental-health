import 'package:flutter/material.dart';
import 'package:student_mental_health/admin/screens/admin_navigation.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            nextScreen(context, const AdminDashboard());
          },
          child: const Text('Admin Sign In'),
        ),
      ),
    );
  }
}
