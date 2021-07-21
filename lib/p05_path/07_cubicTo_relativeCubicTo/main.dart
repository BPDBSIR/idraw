import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw/p05_path/07_cubicTo_relativeCubicTo/paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}