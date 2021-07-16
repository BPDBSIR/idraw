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

    _drawAxis(canvas, size);

    // _drawRect(canvas);
    // _drawRRect(canvas);
    _drawDRRect(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawAxis(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(-(size.width / 2), 0), Offset(size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(0, -(size.height / 2)), Offset(0, size.height / 2), paint);

    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), paint);
  }

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

  /// 矩形绘制
  void _drawRect(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    // 以中心点向外绘制
    Rect centerFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(centerFromCenter, paint);

    // 通过四个点绘制成矩形
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, paint..color = Colors.red);

    // 左上宽高绘制
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, paint..color = Colors.pink);

    // 内切圆绘制
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, paint..color = Colors.amber);

    // 矩形两点绘制
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, paint..color = Colors.purple);
  }

  /// 圆角矩形绘制
  void _drawRRect(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    Rect centerFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(centerFromCenter, 40, 20), paint);

    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10), paint);

    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
        paint..color = Colors.orange);

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: Radius.elliptical(10, 10)),
        paint);

    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomLeft: Radius.elliptical(10, 10)),
        paint..color = Colors.teal);
  }

  // 两个圆角矩形差
  void _drawDRRect(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    Rect outRect =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);

    Rect inRect =
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);

    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20),
        RRect.fromRectXY(inRect, 20, 20), paint);


    Rect outRect2 =
    Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
    Rect inRect2 =
    Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
    canvas.drawDRRect(RRect.fromRectXY(outRect2, 15, 15),
        RRect.fromRectXY(inRect2, 10, 10), paint..color=Colors.green);

  }
}
