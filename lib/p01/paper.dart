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


class PaperPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    var paint = Paint();
    // 绘制圆
    canvas.drawCircle(Offset(100, 100), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}