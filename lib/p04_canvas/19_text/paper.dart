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
    // _drawTextWithParagraph(canvas,TextAlign.center);
    // _drawTextPaint(canvas);
    _drawTextPaintShowSize(canvas);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) => false;

  void _drawTextWithParagraph(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: textAlign,
        fontSize: 40,
        textDirection: TextDirection.ltr,
        maxLines: 1));
    builder.pushStyle(ui.TextStyle(
        color: Colors.black, textBaseline: ui.TextBaseline.alphabetic));

    builder.addText("DrawText");
    ui.Paragraph paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset(0, 0));
    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  /// 对上一种方式的封装
  void _drawTextPaint(Canvas canvas) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: "drawTextPaint",
            style: TextStyle(fontSize: 40, color: Colors.pink)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(0, 0)); // 绘制
  }

  void _drawTextPaintShowSize(Canvas canvas) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: "Flutter Paint",
            style: TextStyle(fontSize: 40, color: Colors.redAccent)),
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
}
