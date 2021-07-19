import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idraw/p05_path/coordinate.dart';

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


class PaperPainter extends CustomPainter{

  Coordinate coordinate = Coordinate();
  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawArcTo(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /*arcTo 用于圆弧路径，指定一个矩形域，形成椭圆。
    指定起始弧度，和扫描弧度，就可以从椭圆上截取出圆弧。
    最后一参代表是否强行移动，如果为true，如图左，绘制圆弧时会先移动到起点*/
  void _drawArcTo(Canvas canvas){
    Paint paint = Paint()..color = Colors.pink..isAntiAlias = true..style = PaintingStyle.stroke..strokeWidth = 2;
    
    Path path = Path();
    
    var rect = Rect.fromCenter(center: Offset(0,0), width: 160, height: 100);
    
    path.lineTo(30,30);
    path.arcTo(rect, 0, pi * 1.5, true);
    canvas.drawPath(path, paint);

    path.reset();

    canvas.translate(200, 0);
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
  }
}