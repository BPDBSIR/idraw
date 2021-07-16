import 'dart:ui' as ui;

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

    /// 指定一个矩形 画布在之后的绘制中仅保留矩形内的内容，可以通过save/restore存换状态
    /// 下面是在剪裁后进行渐变色的绘制，可见，只在矩形区域内有效
    /// 另外有两个可选属性:
    ///   doAntiAlias: 是否抗锯齿(默认为true)
    ///   clipOp: ClipOp.intersect 剪裁内部(默认) Clip.difference 剪裁外部
    var rect = Rect.fromCenter(center: Offset.zero, width: 360, height: 240);
    canvas.clipRect(rect,
        doAntiAlias: true, clipOp: ui.ClipOp.intersect); //剪裁画布
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    Paint paint = Paint();
    paint.shader = ui.Gradient.linear(
        rect.centerLeft, rect.centerRight,
        colors, pos, TileMode.clamp);
    paint.blendMode=BlendMode.lighten;
    canvas.drawPaint(paint);
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
