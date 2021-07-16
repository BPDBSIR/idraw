
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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

    _drawAxis(canvas,size);

    /// 阴影是根据路径绘制的 drawShadow有四个参数 path color elevation transparentOccluder(是否内部显示)
    Path path = Path();
    path.lineTo(90, 90);
    path.lineTo(-90, 90);
    path.close();

    canvas.drawShadow(path, Colors.red, 3, true);
    canvas.translate(200, 0);
    canvas.drawShadow(path, Colors.red, 3, false);
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
}
