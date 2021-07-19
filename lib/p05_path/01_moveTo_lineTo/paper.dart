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
    _drawMoveToLineTo(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /*想象一下，你现在手里拿着一只笔。
    moveTo相当于提起笔落到纸上的位置坐标，且坐标以画布原点为参考系。
    lineTo相当于从落笔点画直线到期望的坐标点，且坐标以画布原点为参考系*/
  void _drawMoveToLineTo(Canvas canvas){
    Paint paint = Paint()..color = Colors.pink..isAntiAlias = true..style = PaintingStyle.fill;
    Path path = Path();
    // 将笔移动到坐标原点(moveTo lineTo都是根据画布的原点进行绘制的)
    path.moveTo(0, 0);
    // 画线
    path.lineTo(60, 82);
    path.lineTo(60, 0);
    path.lineTo(0, -82);
    // 闭合路径
    path.close();

    // 实际绘制
    canvas.drawPath(path, paint);
    
    Path path2 = Path();
    
    path2.moveTo(0, 0);
    path2.lineTo(-60, 82);
    path2.lineTo(-60, 0);
    path2.lineTo(0, -82);
    path2.close();

    canvas.drawPath(path2, paint..style = PaintingStyle.stroke..strokeWidth = 2);
  }
}