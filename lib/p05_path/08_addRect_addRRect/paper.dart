import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idraw/p05_path/coordinate.dart';

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    /*
      addOval用于在已有路径上添加椭圆路径，接受一个Rect 对象。
      addArc用于在已有路径上添加圆弧路径，接受一个Rect 对象，起始弧度、扫描弧度。
     */
    Path path = Path();

    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromPoints(Offset(100,100), Offset(160,160));

    path
      ..lineTo(100, 100)
      ..addRect(rect)
      ..relativeLineTo(100, -100)
      ..addRRect(
          RRect.fromRectXY(rect.translate(100, -100), 10, 10));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
