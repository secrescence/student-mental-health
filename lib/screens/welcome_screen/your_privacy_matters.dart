import 'package:flutter/material.dart';
import 'package:student_mental_health/screens/welcome_screen/not_a_crisis_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/custom_button.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class YourPrivacyMatters extends StatefulWidget {
  const YourPrivacyMatters({super.key});

  @override
  State<YourPrivacyMatters> createState() => _YourPrivacyMattersState();
}

class _YourPrivacyMattersState extends State<YourPrivacyMatters> {
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
              child: const Text('Your privacy matters',
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
                    'Your data allows us to customize your experience',
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
                    'By reviewing anonymized data, we can improve Student\'s Mental Health Information for everyone',
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
              children: [
                const Text(
                  '\u2022',
                  style: TextStyle(
                      fontSize: 55, height: 0.8, color: Colors.transparent),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Read our full privacy policy ',
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.7),
                          height: 1.50,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Privacy Policy'),
                              content: const SizedBox(
                                height: 350,
                                child: SingleChildScrollView(
                                  child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu ex in tellus auctor fermentum congue eu nunc. Orci varius. Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu ex in tellus auctor fermentum congue eu nunc. Orci varius. Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tortor consequat id porta nibh venenatis cras sed felis eget. Suspendisse in est ante in nibh mauris cursus mattis. Tortor consequat id porta nibh venenatis. Nam at lectus urna duis convallis convallis tellus id. Ac tortor vitae purus faucibus. Non enim praesent elementum facilisis leo vel fringilla est ullamcorper. Egestas tellus rutrum tellus pellentesque eu. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique. Ac ut consequat semper viverra nam libero justo laoreet sit. Pharetra convallis posuere morbi leo urna molestie. At varius vel pharetra vel turpis. Arcu non odio euismod lacinia at quis risus. Malesuada fames ac turpis egestas maecenas pharetra. Sed velit dignissim sodales ut eu sem integer. Massa tincidunt dui ut ornare lectus sit amet est placerat. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Varius vel pharetra vel turpis nunc eget. Amet volutpat consequat mauris nunc. Arcu non odio euismod lacinia at. Quam nulla porttitor massa id neque aliquam. Bibendum neque egestas congue quisque egestas diam. Arcu dui vivamus arcu felis. Sed id semper risus in hendrerit gravida rutrum quisque. Et tortor at risus viverra adipiscing at in. Mi in nulla posuere sollicitudin. Feugiat vivamus at augue eget. Lacinia quis vel eros donec ac odio tempor orci. Sagittis id consectetur purus ut faucibus. Aliquam ultrices sagittis orci a scelerisque purus semper. Diam volutpat commodo sed egestas. Pulvinar etiam non quam lacus suspendisse faucibus. Nec sagittis aliquam malesuada bibendum. Quam adipiscing vitae proin sagittis nisl rhoncus mattis.'),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      nextScreenPop(context);
                                    },
                                    child: const Text(
                                      'Agree',
                                      style: TextStyle(color: primaryColor),
                                    )),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'here',
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Sofia Pro',
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.7),
                            height: 1.50,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 250),
            CustomButton(
                text: 'Got It',
                onPressed: () {
                  nextScreen(context, const NotACrisisService());
                },
                color: phoneFieldButtonColor)
          ],
        ),
      ),
    );
  }
}
