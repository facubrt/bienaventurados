import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FloatingModal extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  State<FloatingModal> createState() => _FloatingModalState();
}

class _FloatingModalState extends State<FloatingModal> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Material(
          color: widget.backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: widget.child,),
      ),),
    );
  }
}

Future<T> showFloatingModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(

    animationCurve: Curves.fastLinearToSlowEaseIn,
    duration: Duration(milliseconds: 300),
    context: context,
    builder: builder,
    containerWidget: (_, animation, child) => FloatingModal(
      child: child,
    ),
    expand: false);

  return result;
}
