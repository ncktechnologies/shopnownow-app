import 'package:flutter/cupertino.dart';

Widget XBox(double width) => XYBox(width: width);

Widget YBox(double height) => XYBox(height: height);

class XYBox extends StatelessWidget {
  final double width, height;

  const XYBox({Key? key, this.width = 0, this.height = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}