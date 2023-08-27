import 'package:flutter/material.dart';
import 'package:vpn_basic_project/preferences.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initHive();
  runApp(const MyApp());
}
