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
    _drawRelativeMoveToRelativeLineTo(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /*如果点位已经知道,使用 moveTo 和 lineTo 会比较方便，但很多情况下是不能直接知道的。
    比如在某点的基础上,画一条线，要求左移 10，上移 60，这样点位很难直接确定。
    使用 relative 系列方法就会非常简单。如下图形的路径绘制，不用相对坐标会很复杂。
    使用相对的坐标会更方便调整(左侧只需移动起始点即可全部移动)*/
  void _drawRelativeMoveToRelativeLineTo(Canvas canvas){
    Paint paint = Paint()..color = Colors.pink..isAntiAlias = true..style = PaintingStyle.fill;

    Path path = Path()
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)..close();
    canvas.drawPath(path, paint);
    // 重置路径
    path.reset();
    path..relativeMoveTo(-200, 0)// 移动位置避免两次绘制图形重合
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo( 60,-10,)..close();
    canvas.drawPath(path, paint..strokeWidth = 2..style = PaintingStyle.stroke);
  }
}