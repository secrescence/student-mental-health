import 'package:flutter/material.dart';

import 'package:student_mental_health/screens/auth/onboarding.dart';
import 'package:student_mental_health/service/auth_service.dart';

import 'package:student_mental_health/widgets/welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  String userName = "";
  String chatId = "";

  // @override
  // void initState() {
  //   super.initState();
  //   gettingUserName();
  //   gettingUserChatId();
  // }

  // gettingUserName() async {
  //   await HelperFunctions.getUserNameFromSF().then((val) {
  //     setState(() {
  //       userName = val!;
  //     });
  //   });
  // }

  // gettingUserChatId() async {
  //   String get = FirebaseAuth.instance.currentUser!.uid;
  //   setState(() {
  //     chatId = get;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 130,
          child: Image.asset('assets/logoblue.png'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1D3557),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await authService.signOutUser();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Onboarding()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Welcome(chatId: chatId, userName: userName),
    );
  }
}
