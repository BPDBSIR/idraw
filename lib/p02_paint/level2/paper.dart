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
    // _drawStrokeCap(canvas);
    // _drawStrokeJoin(canvas);
    _drawStrokeMiterLimit(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /// 线帽类型
  void _drawStrokeCap(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;

    canvas.drawLine(
        Offset(50, 50), Offset(50, 150), paint..strokeCap = StrokeCap.butt);
    canvas.drawLine(Offset(50 + 50, 50), Offset(50 + 50, 150),
        paint..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(50 + 100, 50), Offset(50 + 100, 150),
        paint..strokeCap = StrokeCap.square);
  }

  /// 线接类型(只适用于Path线段的绘制 不适用于drawPoints的绘制)
  void _drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    Path path = Path();

    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(50 + 150.0, 50);
    path.lineTo(50 + 150.0, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(50 + 150.0 * 2, 50);
    path.lineTo(50 + 150.0 * 2, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  /// 斜接限制 strokeMiterLimit只适用于【StrokeJoin.miter】
  /// 它是一个对斜接的限定，如果超过阈值，会变成【StrokeJoin.bevel】。
  /// 因为考虑到锐角太尖，会影响视觉。
  void _drawStrokeMiterLimit(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50);
      path.lineTo(50 + 150.0 * i, 150);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 2);
    }
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50 + 150.0);
      path.lineTo(50 + 150.0 * i, 150 + 150.0);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 3);
    }
  }
}
