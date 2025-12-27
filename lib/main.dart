import 'dart:developer';

import 'package:flutter/material.dart';
import 'app.dart';
import 'navigation/MyNavigator.dart';

void main() async {
  log('started app');
  WidgetsFlutterBinding.ensureInitialized();

  MyNavigator();

  runApp(const MyApp());
}
