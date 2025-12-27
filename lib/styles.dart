//mainly store fonts, Color, and TextStyle

import 'package:flutter/material.dart';

class MyColors {
  static const Color blue = const Color.fromRGBO(37, 150, 190, 1);
}

class MyFonts {
  static const TextStyle title = TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 32, height: 1.1);
  static const TextStyle header = TextStyle(fontFamily: 'Montserrat', fontSize: 32, height: 2);
  static const TextStyle regular = TextStyle(fontFamily: 'Montserrat', fontSize: 20, height: 2);
  static const TextStyle regular_underline = TextStyle(fontFamily: 'Montserrat', fontSize: 20, decoration: TextDecoration.underline, height: 2);
  static const TextStyle bold = TextStyle(fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.w700, height: 2);
}
