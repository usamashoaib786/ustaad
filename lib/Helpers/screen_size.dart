import 'package:flutter/material.dart';

class ScreenSize {
  BuildContext context;

  ScreenSize(this.context);

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;
}
