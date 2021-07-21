import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw/p05_path/05_conicTo_relativeConicTo/paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}