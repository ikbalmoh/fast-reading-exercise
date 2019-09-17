import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:baca/src/ui/intro.dart';
import 'package:baca/src/ui/home.dart';
import 'package:baca/src/ui/select-school.dart';
import 'package:baca/src/ui/select-subject.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _introHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Intro());
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Home());
  static Handler _selectSubjectSchool = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SelectSchool());
  static Handler _selectSubjectHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SelectSubject());

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
      'select-school',
      handler: _selectSubjectSchool,
      transitionType: TransitionType.fadeIn
    );
    router.define(
      'select-subject',
      handler: _selectSubjectHandler,
      transitionType: TransitionType.cupertino
    );
  }
}