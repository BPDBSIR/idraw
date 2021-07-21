import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw/p05_path/11_path_coo/paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}