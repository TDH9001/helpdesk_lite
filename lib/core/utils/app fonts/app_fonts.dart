import 'dart:ui';

import 'package:flutter/material.dart';

class AppFonts {
  TextStyle mobileCoreSnackBarCairo14Medium(
    BuildContext context, {
    Color? color,
  }) => TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color,
  );
}
