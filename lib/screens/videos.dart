import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/video_player.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Videos extends StatefulWidget {
  final String highestCategory;
  const Videos({
    Key? key,
    required this.highestCategory,
  }) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  bool listVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1D3557),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: const [
                Text(
                  'Videos',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.highestCategory == 'Awareness'
                        ? 'awarenessVideos'
                        : widget.highestCategory == 'Goals'
                            ? 'goalsVideos'
                            : widget.highestCategory == 'Impulse'
                                ? 'impulseVideos'
                                : widget.highestCategory == 'Nonacceptance'
                                    ? 'nonAcceptanceVideos'
                                    : widget.highestCategory == 'Strategies'
                                        ? 'strategiesVideos'
                                        : widget.highestCategory == 'Clarity'
                                            ? 'clarityVideos'
                                            : '')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitChasingDots(
                        color: primaryColor,
                        size: 50,
                      ),
                    );
                  }
                  final List<Map<String, dynamic>> videosData = snapshot
                      .data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();

                  return ListView.builder(
                    itemCount: videosData.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = videosData[index];

                      return Card(
                        child: ListTile(
                          onTap: () {
                            nextScreen(
                                context,
                                VideoPlayer(
                                    videoLink: data['link'],
                                    videoTitle: data['title'],
                                    videoSubtitle: data['subtitle']));
                          },
                          title: Text(
                            data['title'],
                            style: const TextStyle(fontFamily: 'Sofia Pro'),
                          ),
                          subtitle: Text(
                            data['subtitle'],
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Sofia Pro',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  //end of class
}
