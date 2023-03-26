import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class ArticlesViewer extends StatefulWidget {
  final String articleLink;
  const ArticlesViewer({super.key, required this.articleLink});

  @override
  State<ArticlesViewer> createState() => _ArticlesViewerState();
}

class _ArticlesViewerState extends State<ArticlesViewer> {
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
      body: Center(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.articleLink),
          ),
        ),
      ),
    );
  }
}
