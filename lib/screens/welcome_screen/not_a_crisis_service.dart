import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/chatbot_screen/chatbot_screen.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/utils/loading.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class NotACrisisService extends StatelessWidget {
  const NotACrisisService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: (() {
              nextScreenPop(context);
            }),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF000000),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text('This app is not a crisis service',
                  style: TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '\u2022',
                  style:
                      TextStyle(fontSize: 55, height: 0.8, color: primaryColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'No human is monitoring these live conversations',
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 18,
                      color: Colors.black,
                      height: 1.50,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '\u2022',
                  style:
                      TextStyle(fontSize: 55, height: 0.8, color: primaryColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'If you experience a crisis while using this app, please contact your local crisis services',
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 18,
                      color: Colors.black,
                      height: 1.50,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '\u2022',
                  style: TextStyle(
                      fontSize: 55, height: 0.8, color: Colors.transparent),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(height: 230),
            ElevatedButton(
              onPressed: () => nextScreen(
                  context,
                  const LoadingWidget(
                    thenMoveToThisWidget: ChatBotScreen(),
                  )),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(125, 48)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(phoneFieldButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              child: const Text('I understand',
                  style: TextStyle(fontSize: 16, fontFamily: 'Sofia Pro')),
            )
          ],
        ),
      ),
    );
  }
}
