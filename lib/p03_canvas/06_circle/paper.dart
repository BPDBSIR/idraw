import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  // 步长
  double step = 20;

  // 描边宽度
  double lineWidth = .5;

  //绘制颜色
  Color lineColor = Colors.grey;

  late Paint customPaint;

  PaperPainter() {
    customPaint = Paint()
      ..isAntiAlias = true
      ..color = lineColor
      ..strokeWidth = lineWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    _drawBottomRight(canvas, size);

    canvas.save();
    // 沿x轴镜像
    canvas.scale(1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    // 沿y轴镜像
    canvas.scale(-1, 1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    // 沿原点镜像
    canvas.scale(-1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    // _drawFill(canvas);
    _drawArcDetail(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), customPaint);
      canvas.translate(0, step);
    }
    canvas.restore();
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), customPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawFill(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.save();

    canvas.translate(-200, 0);
    canvas.drawCircle(Offset(0, 0), 60, paint);
    canvas.restore();

    var rect = Rect.fromCenter(center: Offset(0, 0), width: 150, height: 120);
    canvas.drawOval(rect, paint);

    canvas.save();
    canvas.translate(200, 0);
    // drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, true, paint);
    canvas.restore();
  }

  void _drawArcDetail(Canvas canvas) {
    var rect = Rect.fromCenter(center: Offset(0, 0), height: 100, width: 100);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawArc(rect, 0, pi / 2 * 3, false, paint);
    canvas.restore();
    canvas.drawArc(rect, 0, pi / 2 * 3, true, paint);
    canvas.save();
    canvas.translate(200, 0);
    var a = pi / 8;
    canvas.drawArc(
        rect,
        a,
        2 * pi - a.abs() * 2,
        true,
        paint
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill);
    canvas.translate(40, 0);
    canvas.drawCircle(Offset(0, 0), 6, paint);
    canvas.translate(25, 0);
    canvas.drawCircle(Offset(0, 0), 6, paint);
    canvas.restore();
  }
}
