import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalGap extends StatelessWidget {

  final double? gap;

  VerticalGap({@required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap,);
  }
}

class HorizontalGap extends StatelessWidget {

  final double? gap;
  HorizontalGap({@required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: gap,);
  }
}

class LineBg extends StatelessWidget {
  final double? strokeWidth;
  final Color? color;
  LineBg({@required this.strokeWidth, @required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: strokeWidth,
      child: Container(
        color: color,
        // margin: EdgeInsets.only(left: dimen5, right: dimen5),
      ),
    );
  }
}