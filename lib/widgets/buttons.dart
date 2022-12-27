import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(
      {super.key,
      required this.text,
      required this.color,
      this.style,
      required this.tap,
      required this.mode});

  final Color color;
  final style;
  final String text;
  final Function tap;
  final bool mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        style: style,
        onPressed: () {
          tap();
        },
        child: Text(
          text,
          style: TextStyle(
            color: mode == true ? color : color,
          ),
        ),
      ),
    );
  }
}
