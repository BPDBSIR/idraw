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
      quadraticBezierTo接收六个参数用于绘制三阶贝塞尔曲线
      其中前两参是控制点1,三四参是控制点2,五六参是结束点。(下图已画出蓝色辅助点线)
      relativeCubicTo是在使用相对位置来加入三阶贝塞尔曲线路径。
     */
    Offset p1 = Offset(100, -100);
    Offset p2 = Offset(160, 50);
    Offset p3 = Offset(200,50);

    Path path = Path();

    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;


    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);

    path.relativeCubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
