import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

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


  final List<Offset> points = [
    Offset(-120, -20),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -140),
    Offset(80, -160),
    Offset(120, -100),
  ];


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


    _drawPointsWidthPoints(canvas);

    // _drawRawPoints(canvas);

    _drawAxis(canvas, size);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


  /// 绘制点需要传入点模式pointMode 一个Offset的列表和画笔
  void _drawPointsWidthPoints(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    /// PointMode.points 点模式
    canvas.drawPoints(PointMode.points, points, paint);
    // PointMode.lines 线段模式
    canvas.drawPoints(PointMode.lines, points, paint..strokeWidth = 2);
    // PointMode.polygon 多边形连选模式
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  /// 通过Float32List得到点数据信息 点绘制模式同上
  void _drawRawPoints(Canvas canvas) {
    Float32List pos = Float32List.fromList([
      -120,
      -20,
      -80,
      -80,
      -40,
      -40,
      0,
      -100,
      40,
      -140,
      80,
      -160,
      120,
      -100
    ]);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawRawPoints(PointMode.points, pos, paint);
  }

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

}
