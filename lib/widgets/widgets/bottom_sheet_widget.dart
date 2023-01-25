import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  final VoidCallback onGuidancePressed;
  final VoidCallback onArticlesPressed;
  final VoidCallback onVideosPressed;
  final VoidCallback onJournalPressed;
  final VoidCallback onMoodTrackerPressed;

  const BottomSheetWidget({
    super.key,
    required this.onGuidancePressed,
    required this.onArticlesPressed,
    required this.onVideosPressed,
    required this.onJournalPressed,
    required this.onMoodTrackerPressed,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildBottomSheetItem(
              title: 'Articles', onPressed: widget.onArticlesPressed),
          _buildBottomSheetItem(
              title: 'Videos', onPressed: widget.onVideosPressed),
        ],
      ),
    );
  }

  Widget _buildBottomSheetItem({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: onPressed,
              child: Text(title),
            ),
          ],
        ));
  }
}
