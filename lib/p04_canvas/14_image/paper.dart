import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:idraw/p04_canvas/14_image/coordinate.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  late ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets("assets/images/img02.jpg");

    /// 刷新状态
    setState(() {});
  }

  /// 从Assets内获取图片对象
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_image),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();

  late final ui.Image image;

  late Paint _paint;

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0.5
      ..color = Colors.blue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制坐标系
    coordinate.paint(canvas, size);
    // 将坐标平移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);

    _drawImage(canvas);
  }

  /// 是否重新调用paint方法 当新旧Image不同时则调用
  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;

  /// 绘制图片
  void _drawImage(Canvas canvas) {
    print('图片宽度 => ${image.width} 图片高度 => ${image.width}');
    // 第二个参数为图片左上角的顶点
    canvas.drawImage(
        image, Offset(-image.width / 2, -image.height / 2), _paint);
  }
}
