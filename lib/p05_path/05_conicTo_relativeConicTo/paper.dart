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
      conicTo 接收五个参数用于绘制圆锥曲线，包括椭圆线、抛物线和双曲线
      其中前两参是控制点，三四参是结束点，第五参是权重。
      当权重< 1 时，圆锥曲线是椭圆线
      当权重= 1 时，圆锥曲线是抛物线
      当权重> 1 时，圆锥曲线是双曲线
     */
    Offset p1 = Offset(90, -100);
    Offset p2 = Offset(160, 0);

    Path path = Path();

    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.drawPath(path, paint);

    path.reset();

    canvas.translate(-190, 0);

    // 椭圆线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.drawPath(path, paint);

    path.reset();

    canvas.translate(190 + 190, 0);

    // 双曲线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
