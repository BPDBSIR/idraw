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
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImageNine(canvas);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;

  /// drawImageNine中主要是两个矩形区域，center和dst
  /// center表示从资源图片image上一块可以缩放的矩形区域，所以原点是图片上的左上角
  /// dst表示将抠出的图片 填充到画布的哪个矩形域中，所以原是画布原点
  void _drawImageNine(Canvas canvas) {
    canvas.drawImageNine(
        image,
        Rect.fromCenter(
            center: Offset(image.width / 2, image.height - 6.0),
            width: image.width - 20,
            height: 2.0),
        Rect.fromCenter(center: Offset(0, 0), width: 300, height: 120),
        _paint);

    canvas.drawImageNine(
        image,
        Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
            width: image.width-20.0, height: 2.0),
        Rect.fromCenter(center: Offset(0, 0,), width:100, height: 50).translate(250, 0),
        _paint);

    canvas.drawImageNine(
        image,
        Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
            width: image.width-20.0, height: 2.0),
        Rect.fromCenter(center: Offset(0, 0,), width:80, height: 250).translate(-250, 0),
        _paint);
  }
}
