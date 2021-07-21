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

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    /*
      当想要画圆弧到某个点，用 arcToPoint 会非常方便
      接受一个点位入参 Offset，是圆弧的终点，可指定圆弧半径radius、是否使用优弧、是否顺时针
      左侧: 使用优弧: largeArc: true ,逆时针:clockwise: false
      中间: 使用劣弧: largeArc: false ,顺时针:clockwise: true
      右侧: 使用优弧: largeArc: true ,顺时针:clockwise: true
     */
    Path path = Path();

    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.lineTo(90, -40);

    // 绘制中间 以点为定位弧线
    path
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    // 绘制左边
    canvas.translate(-150, 0);
    path.lineTo(90, -40);
    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)..close();

    canvas.drawPath(path, paint);

    path.reset();

    // 绘制右边
    canvas.translate(150 + 150, 0);
    path.lineTo(90, -40);
    // path..arcToPoint(Offset(40, 40),radius: Radius.circular(60),largeArc: true)..close();
    path..relativeArcToPoint(Offset(-40, 90),radius: Radius.circular(60),largeArc: true)..close();

    canvas.drawPath(path, paint);

    /*
    * relativeArcToPoint方法即使用相对位置来加入圆弧路径，参数含义与上面一致。
    * */

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
