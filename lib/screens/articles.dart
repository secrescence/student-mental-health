import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/screens/articles_viewer.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Articles extends StatefulWidget {
  final String highestCategory;
  const Articles({super.key, required this.highestCategory});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
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
                  'Articles',
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
                        ? 'awarenessArticles'
                        : widget.highestCategory == 'Goals'
                            ? 'goalsArticles'
                            : widget.highestCategory == 'Impulse'
                                ? 'impulseArticles'
                                : widget.highestCategory == 'Nonacceptance'
                                    ? 'nonAcceptanceArticles'
                                    : widget.highestCategory == 'Strategies'
                                        ? 'strategiesArticles'
                                        : widget.highestCategory == 'Clarity'
                                            ? 'clarityArticles'
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
                  final List<Map<String, dynamic>> articlesData = snapshot
                      .data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();

                  return ListView.builder(
                    itemCount: articlesData.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = articlesData[index];

                      return Card(
                        child: ListTile(
                          onTap: () {
                            nextScreen(context,
                                ArticlesViewer(articleLink: data['link']));
                          },
                          title: Text(
                            data['title'],
                            style: const TextStyle(fontFamily: 'Sofia Pro'),
                          ),
                          subtitle: Text(
                            data['subtitle'],
                            style: const TextStyle(
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
}
