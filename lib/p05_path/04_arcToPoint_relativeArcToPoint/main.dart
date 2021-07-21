import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw/p05_path/04_arcToPoint_relativeArcToPoint/paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}