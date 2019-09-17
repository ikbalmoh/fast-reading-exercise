import 'package:flutter/material.dart';
import 'package:baca/src/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Ubuntu',
        brightness: Brightness.light
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'intro',
      onGenerateRoute: FluroRouter.router.generator,
    );
  }
}