import 'package:flutter/material.dart';

class ArticlesAndVideos extends StatefulWidget {
  const ArticlesAndVideos({super.key});

  @override
  State<ArticlesAndVideos> createState() => _ArticlesAndVideosState();
}

class _ArticlesAndVideosState extends State<ArticlesAndVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF1D3557),
      ),
      body: const Center(
        child: Text(
          'Articles and Videos',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
