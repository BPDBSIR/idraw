

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawGrid{

  double step;

  DrawGrid({this.step = 28.7});

  late Canvas canvas;

  late Size size;


  Path path = Path();

  Paint paint = Paint()..color = Colors.grey..style = PaintingStyle.stroke..strokeWidth = 0.5;


  void draw(Canvas canvas,Size size){
    this.canvas = canvas;
    this.size = size;
    print('宽度 => ${size.width}  高度 => ${size.height}');
    _drawGrid();
    _drawAxis();
  }

  void _drawGrid(){
    var widthCount = 32;
    for (double i = 0; i < widthCount; i++) {
      path..moveTo(size.width / widthCount * i, 0)..relativeLineTo(0, size.height);
      _drawText(Offset(size.width / 2 + 20, size.width / widthCount * i),"${100}");
    }

    var heightCount = 16;
    for(int i = 0; i < heightCount; i++){
      path..moveTo(0, size.height / heightCount * i)..relativeLineTo(size.width, 0);
    }
    canvas.drawPath(path, paint);
  }

  void _drawAxis(){
    paint..color = Colors.blue..strokeWidth = 2;
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
  }


  void _drawText(Offset offset,String text,{double fontSize = 14}){
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(fontSize: fontSize, color: Colors.pink)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(offset.dx - textPainter.width / 2, offset.dy - textPainter.height / 2));
  }
}