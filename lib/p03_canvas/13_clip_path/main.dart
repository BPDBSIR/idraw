import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw/p03_canvas/13_clip_path//paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}