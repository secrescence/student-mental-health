import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class LoadingWidget extends StatefulWidget {
  final Widget thenMoveToThisWidget;
  const LoadingWidget({super.key, required this.thenMoveToThisWidget});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  void initState() {
    toNextScreen(widget.thenMoveToThisWidget);
    super.initState();
  }

  toNextScreen(Widget widget) async {
    Future.delayed(const Duration(milliseconds: 1300))
        .then((value) => nextScreenReplace(context, widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: SpinKitSpinningLines(color: primaryColor)),
    );
  }
}
