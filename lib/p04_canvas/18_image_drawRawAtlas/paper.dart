import 'dart:async';
import 'dart:typed_data';
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
    _image = await loadImageFromAssets("assets/images/img03.jpg");

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

  // Sprite列表
  final List<Sprite> allSprites = [];

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

    allSprites
        .add(Sprite(Rect.fromLTWH(0, 325, 257, 166), Offset(0, 0), 255, 0));

    allSprites
        .add(Sprite(Rect.fromLTWH(0, 325, 257, 166), Offset(257, 130), 255, 0));

    Float32List rectList = Float32List(allSprites.length * 4);
    Float32List transformList = Float32List(allSprites.length * 4);

    for (int i = 0; i < allSprites.length; i++) {
      final Sprite sprite = allSprites[i];
      rectList[i * 4 + 0] = sprite.position.left;
      rectList[i * 4 + 1] = sprite.position.top;
      rectList[i * 4 + 2] = sprite.position.right;
      rectList[i * 4 + 3] = sprite.position.bottom;
      final RSTransform transform = RSTransform.fromComponents(
        rotation: sprite.rotation,
        scale: 1.0,
        anchorX: /*sprite.anchor.dx*/0,
        anchorY: /*sprite.anchor.dy*/0,
        translateX: sprite.offset.dx,
        translateY: sprite.offset.dy,
      );
      transformList[i * 4 + 0] = transform.scos;
      transformList[i * 4 + 1] = transform.ssin;
      transformList[i * 4 + 2] = transform.tx;
      transformList[i * 4 + 3] = transform.ty;
    }
    canvas.drawRawAtlas(
        image, transformList, rectList, null, null, null, _paint);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;
}

/// 每个Sprite类封装图片元素数据
class Sprite {
  // 雪碧图中图图片矩形区域
  Rect position;

  // 移动偏移
  Offset offset;

  // 透明度
  int alpha;

  // 旋转角度
  double rotation;

  Sprite(this.position, this.offset, this.alpha, this.rotation);
}
