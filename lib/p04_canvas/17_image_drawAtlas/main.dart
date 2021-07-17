import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw/p04_canvas/17_image_drawAtlas/paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}