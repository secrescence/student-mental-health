import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/admin_splash.dart';
import 'package:student_mental_health/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAJLrPJ6NGUikXqvhtg0VBTFk5ih6rV95k",
        authDomain: "students-mental-health-app.firebaseapp.com",
        projectId: "students-mental-health-app",
        storageBucket: "students-mental-health-app.appspot.com",
        messagingSenderId: "421430700553",
        appId: "1:421430700553:web:ec62f7cffb4fab856da6d8",
        measurementId: "G-VF7MY06B59",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(kIsWeb ? const AdminApp() : const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

class AdminApp extends StatefulWidget {
  const AdminApp({super.key});

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const AdminSplash(),
    );
  }
}
