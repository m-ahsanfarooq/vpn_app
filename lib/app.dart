import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/preferences.dart';
import 'package:vpn_basic_project/screens/home_page_vu.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true, elevation: 3
        ),
      ),
      themeMode: Preferences.isModeDark? ThemeMode.dark: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            centerTitle: true, elevation: 3
        ),
      ),
      debugShowCheckedModeBanner: true,
      home: HomePage()
    );
  }
}

extension AppTheme on ThemeData{
  Color get lightTextColor => Preferences.isModeDark? Colors.white : Colors.black;
  Color get bottomSheetColor => Preferences.isModeDark? Colors.white : Colors.redAccent;
}