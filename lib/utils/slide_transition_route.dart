import 'package:flutter/material.dart';

class SlideLeftTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  final Duration duration;

  SlideLeftTransitionRoute({
    required this.widget,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) => widget,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.fastLinearToSlowEaseIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child
      );
    },
  );
}

class SlideUpTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  final Duration duration;

  SlideUpTransitionRoute({
    required this.widget,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) => widget,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.fastLinearToSlowEaseIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child
      );
    },
  );
}
