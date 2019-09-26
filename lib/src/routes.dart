import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:baca/src/ui/intro.dart';
import 'package:baca/src/ui/home.dart';
import 'package:baca/src/ui/about.dart';
import 'package:baca/src/ui/select-school.dart';
import 'package:baca/src/ui/select-subject.dart';
import 'package:baca/src/ui/read.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _introHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Intro());
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Home());
  static Handler _aboutHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => About(id: params["id"][0],));
  static Handler _selectSubjectSchool = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SelectSchool());
  static Handler _selectSubjectHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return SelectSubject(type: params["type"][0],);
  });
  static Handler _readHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return Read();
  });

  static void defineRoutes() {
    router.define(
      'intro',
      handler: _introHandler,
      transitionType: TransitionType.fadeIn
    );
    router.define(
      'home',
      handler: _homeHandler,
      transitionType: TransitionType.fadeIn
    );
    router.define(
      'about/:id',
      handler: _aboutHandler,
      transitionType: TransitionType.fadeIn
    );
    router.define(
      'select-school',
      handler: _selectSubjectSchool,
      transitionType: TransitionType.cupertino
    );
    router.define(
      'select-subject/:type',
      handler: _selectSubjectHandler,
      transitionType: TransitionType.cupertino
    );
    router.define(
      'read',
      handler: _readHandler,
      transitionType: TransitionType.cupertino
    );
  }
}