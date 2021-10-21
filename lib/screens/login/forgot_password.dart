import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:local_auth/local_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  //Local Variables
  final _formKeyForgot = GlobalKey<FormState>();
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final msgTextController = TextEditingController();
  final maxLines = 5;

  //Biometrics--------------------------------------------------------------
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String authMessage = "Not Authorized";

  Future<bool> checkingBiometrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    return canCheckBiometrics;
  }

  Future<void> _authMe() async {
    bool auth = false;
    try {
      auth  = await _localAuthentication.authenticate(
          localizedReason: "Authenticate your finger here.",
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true
      );
      setState(() {
        authMessage = auth ? "Authorized" : "Not Authorized";
      });
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fingerprint Sensor Error. Please reset your Smartphone!'),
        )
      );
    }
    if(!mounted) return;
  }
  //------------------------------------------------------------------------

  //Anim
  late final AnimationController _animationController;
  //Animation for 1st list
  late final Animation<double> _title;
  //Animation for 2nd list
  late final Animation<double> _form;
  //Animation for 3rd list
  late final Animation<double> _button;
  //Animation for SVG
  late final Animation<double> _svg;

  bool _indicatorLoading = false;
  void showIndicator(){
    setState(() {
      _indicatorLoading = true;
    });
  }
  void hideIndicator(){
    setState(() {
      _indicatorLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    checkingBiometrics();

    //Anim
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _svg = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );

    _title = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );

    _form = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.7, curve: Curves.easeIn),
      ),
    );

    _button = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
      ),
    );

    Timer(Duration(milliseconds: 250), () {_animationController.forward();});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (context) => Scaffold(
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: GestureDetector(
                      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                      child: SafeArea(
                        child: Container(
                          color: Colors.white,
                          child: Form(
                            key: _formKeyForgot,
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                FadeTransition(
                                  opacity: _svg,
                                  child: Container(
                                      height: 200,
                                      child: SvgPicture.asset('assets/images/forgotpassword.svg')
                                  ),
                                ),
                                FadeTransition(
                                  opacity: _title,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Forgot Your Password?',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18
                                      ),
                                    ),
                                  )
                                ),
                                const SizedBox(height: 40,),
                                //Form-----------------------------------
                                FadeTransition(
                                  opacity: _form,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextFormField(
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return 'Please enter your username';
                                        }
                                        return null;
                                      },
                                      controller: usernameTextController,
                                      textCapitalization: TextCapitalization.none,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(CupertinoIcons.person,color: Colors.black,),
                                        labelText: 'Username',
                                        labelStyle: TextStyle(color: Colors. black),
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors. black)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                FadeTransition(
                                  opacity: _form,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: TextFormField(
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                      controller: emailTextController,
                                      textCapitalization: TextCapitalization.none,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(CupertinoIcons.mail,color: Colors.black,),
                                        labelText: 'Email',
                                        labelStyle: TextStyle(color: Colors. black),
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors. black)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                FadeTransition(
                                  opacity: _form,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text('We will send the new Password into your email',
                                    style: TextStyle(fontSize: 12),
                                    )
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                //---------------------------------------
                                FadeTransition(
                                  opacity: _button,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.4),
                                      animationDuration: Duration(milliseconds: 400),
                                      elevation: 8.0,
                                    ),
                                    onPressed: (){
                                      if(_formKeyForgot.currentState!.validate()) {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        _authMe();
                                      };
                                    },
                                    child: Text('SEND', style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        letterSpacing: 2.0
                                    )),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Visibility(
                                    maintainState: true,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    visible: _indicatorLoading,
                                    child: CupertinoActivityIndicator(animating: true)
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            );
          }
          if(size.deviceScreenType == DeviceScreenType.desktop){
            return Center(child: Text("This app does not support Desktop Screen"));
          }
          if(size.deviceScreenType == DeviceScreenType.tablet){
            return Center(child: Text("This app does not support Tablet Screen"));
          }
          if(size.deviceScreenType == DeviceScreenType.watch){
            return Center(child: Text("This app does not support Watch Screen"));
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red,
            alignment: Alignment.center,
            child: Center(
              child: Text("Error : Please call the developer ASAP. Email : prasyah1998@gmail.com"),),);
        }
    );
  }
}

