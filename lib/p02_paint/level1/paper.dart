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
  @override
  void paint(Canvas canvas, Size size) {
    // _drawIsAntiAliasColor(canvas);
    _drawStyleStrokeWidth(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /// 颜色以及是否抗锯齿
  void _drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        Offset(180, 180),
        170,
        paint
          ..color = Colors.blue
          ..isAntiAlias = true
          ..strokeWidth = 5);
    canvas.drawCircle(
        Offset(180 + 360, 180),
        170,
        paint
          ..isAntiAlias = false
          ..color = Colors.red);
  }

  /// 画笔样式和线宽
  void _drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red;

    canvas.drawCircle(
        Offset(180, 180),
        150,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 50);

    canvas.drawCircle(
        Offset(180 + 360, 180),
        150,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
  }
}
