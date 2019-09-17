import 'package:flutter/material.dart';
import 'package:baca/src/app.dart';
import 'package:baca/src/routes.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  FluroRouter.defineRoutes();
  runApp(MyApp());
}
