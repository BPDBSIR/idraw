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

/// 主要增对于画布变换的练习
/// 画布的变换是持久性的，变换之后所有的绘制会在变换后的画布上进行
/// 变化不是永久性的变化，需要使用状态的储存[save]和恢复[restore]回到之前的画布状态
class PaperPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    // 将画布的左上坐标移动到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    // 此时画布的坐标以及在屏幕中心
    canvas.drawCircle(Offset(0, 0), 50, paint);
    // 同理 画线
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


}
