import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  String titleText;
  String subTitleText;
  Widget roundWidget;

  CustomWidget(
      {required this.roundWidget,
      required this.titleText,
      required this.subTitleText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width *.46,
      child: Column(
        children: [
          roundWidget,
          const SizedBox(
            height: 8,
          ),
          Text(
            titleText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subTitleText,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
