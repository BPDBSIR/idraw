
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Coordinate{

  // 步长
  double step;

  // 描边宽度
  double strokeWidth;

  // 坐标颜色
  Color axisColor;

  // 网格颜色
  Color gridColor;

  Coordinate({
    this.step = 20, this.strokeWidth = .5, this.axisColor = Colors.blue, this.gridColor = Colors.grey
  });

  void paint(Canvas canvas,Size size){
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);
  }

  void _drawAxis(Canvas canvas,Size size){
    Paint axisPaint = Paint()..color = axisColor..style = PaintingStyle.stroke..strokeWidth = 2..isAntiAlias = true;
    canvas.drawLine(Offset(0,size.height / 2), Offset(size.width, size.height / 2), axisPaint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), axisPaint);
    
    canvas.drawLine(Offset(size.width / 2, size.height), Offset(size.width / 2 - 12, size.height - 12), axisPaint);
    canvas.drawLine(Offset(size.width / 2, size.height), Offset(size.width / 2 + 12, size.height - 12), axisPaint);
    
    canvas.drawLine(Offset(size.width, size.height / 2), Offset(size.width - 12,size.height / 2 - 12), axisPaint);
    canvas.drawLine(Offset(size.width, size.height / 2), Offset(size.width - 12,size.height / 2 + 12), axisPaint);

  }

  void _drawGrid(Canvas canvas,Size size){
    Paint gridPaint = Paint()..color = gridColor..strokeWidth = strokeWidth..style = PaintingStyle.stroke..isAntiAlias = true;
    canvas.save();
    for (int i = 0; i < size.height / step; i++) {
      canvas.drawLine(Offset(0, step * i), Offset(size.width, step * i), gridPaint);
      canvas.translate(0, step);
    }
    canvas.restore();
    canvas.save();
    for (int i = 0; i < size.width / step; i++) {
      canvas.drawLine(Offset(step * i, 0), Offset(step * i, size.height), gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }
}