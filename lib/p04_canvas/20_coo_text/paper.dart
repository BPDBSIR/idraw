import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:idraw/p04_canvas/14_image/coordinate.dart';

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
  final Coordinate coordinate = Coordinate();

  late Paint _paint;

  var step = 25.0;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..color = Colors.blue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    /// 通过ParagraphBuilder构造基本二样式pushStyle和条件文字addText
    /// builder.build()可以创建Paragraph对象，之后必须对其排布layout限制区域。
    // _drawTextPaintShowSize(canvas);

    _drawText(canvas, size);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) => false;

  /// 文字添加边框
  void _drawTextPaintShowSize(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: "Flutter Paint\nBPDBSIR",
            // 和color属性互斥
            style: TextStyle(fontSize: 40, foreground: textPaint)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));
    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  void _drawText(Canvas canvas, Size size) {
    canvas.save();

    // y > 0 轴文字
    for (int i = 0; i < size.height / 2 / step; i++) {
      // 如果小于30并且为奇数 或者 == 0不进行绘制
      if (step < 30 && i.isOdd || i == 0) {
        // 移动画布
        canvas.translate(0, step);
        continue;
      } else {
        // 需要绘制的文本
        var str = (i * step).toInt().toString();

        _drawAxisText(canvas, str, color: Colors.green);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();

    for (int i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "O", color: Colors.black, x: null);
        canvas.translate(step, 0);
        continue;
      }
      if (step < 30 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: true);
      }
      canvas.translate(step, 0);
    }
    canvas.restore();
    // y < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green);
      }
      canvas.translate(0, -step);
    }
    canvas.restore();
    // x < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        var str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: true);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }


  /// 绘制文字
  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black, bool? x = false}) {
    /// 文本样式
    TextSpan text =
        TextSpan(text: str, style: TextStyle(fontSize: 11, color: color));
    _textPainter.text = text;
    _textPainter.layout(); // 进行布局
    // 文本大小
    Size size = _textPainter.size;

    // 偏移
    Offset offset = Offset.zero;
    if (x == null) {
      offset = Offset(8, 8);
    } else if (x) {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }
    _textPainter.paint(canvas, offset);
  }
}
