import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

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
                    .collection('articles')
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
