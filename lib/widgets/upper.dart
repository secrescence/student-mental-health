import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Upper extends StatelessWidget {
  const Upper({Key? key, required this.imgUrl, required this.paddingForUpper})
      : super(key: key);
  final String imgUrl;
  final double paddingForUpper;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: const Color(0xFF1D3557),
          child: Padding(
            padding: EdgeInsets.only(top: paddingForUpper),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: 0.9,
            ),
          ),
        ),
        iconBackButton(context),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
