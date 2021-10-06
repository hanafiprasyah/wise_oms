import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:wise_oms/core/navigation.dart';
import 'package:wise_oms/screens/login/login_screen.dart';
import 'package:wise_oms/screens/home/home_screen.dart';

class CheckUserLogin extends StatefulWidget {
  const CheckUserLogin({Key? key}) : super(key: key);

  @override
  _CheckUserLoginState createState() => _CheckUserLoginState();
}
class _CheckUserLoginState extends State<CheckUserLogin> {
  StreamSubscription? sub;
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: CupertinoActivityIndicator(animating: true)
      )
    );
  }

  @override
  void initState() {
    super.initState();
    sub = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        isConnected = (event != ConnectivityResult.none);
        Future.delayed(Duration(seconds: 2)).whenComplete(() =>
        isConnected ? checkLogin() : null
        );
      });
    });
  }

  @override
  void dispose() {
    sub!.cancel();
    super.dispose();
  }

  Future checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var val =  pref.getString('login');
    if(val != null){
      navigateAndRemove(context, const HomeScreen());
    } else {
      navigateAndRemove(context, const LoginScreen());
    }
  }
}
