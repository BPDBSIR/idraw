import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idraw/p05_path/11_path_coo/coordinate_pro.dart';
import 'package:idraw/p05_path/11_path_coo/draw_grid.dart';

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

  DrawGrid drawGrid = DrawGrid();
  @override
  void paint(Canvas canvas, Size size) {
    drawGrid.draw(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}
