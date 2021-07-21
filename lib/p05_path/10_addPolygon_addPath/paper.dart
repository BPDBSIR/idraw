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
      addPolygon用于在已有路径上添加多边形路径，接受一个List<Offset>对象。
      addPath用于在已有路径上添加路径，接受一个Path对象和偏移量Offset。
     */
    Path path = Path();

    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var p0 = Offset(100, 100);

    path
      ..lineTo(100, 100)
      ..addPolygon([
        p0,
        p0.translate(20, -20),
        p0.translate(40, -20),
        p0.translate(60, 0),
        p0.translate(60, 20),
        p0.translate(40, 40),
        p0.translate(20, 40),
        p0.translate(0, 20),
      ], true)
      ..addPath(Path()..relativeQuadraticBezierTo(125, -100, 260, 0), Offset.zero)
      ..lineTo(160, 100);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
