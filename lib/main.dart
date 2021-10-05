import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wise_oms/core/check_token.dart';
import 'package:wise_oms/core/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.bottom,SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor:
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness == Brightness.dark
        ? Colors.transparent : Colors.white,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness:
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness == Brightness.dark
        ? Brightness.light : Brightness.dark,
  ));
  runApp(const MainApp());
}

// SYSTEM MAIN ----------
class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}
class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: const CheckUserLogin(),
    );
  }
}
