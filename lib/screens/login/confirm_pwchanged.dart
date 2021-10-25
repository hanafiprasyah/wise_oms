import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wise_oms/core/navigation.dart';
import 'package:wise_oms/screens/login/forgot_password.dart';
import 'package:wise_oms/screens/login/login_screen.dart';

class ConfirmPwChanged extends StatefulWidget {
  const ConfirmPwChanged({Key? key}) : super(key: key);

  @override
  _ConfirmPwChangedState createState() => _ConfirmPwChangedState();
}
class _ConfirmPwChangedState extends State<ConfirmPwChanged> with SingleTickerProviderStateMixin{

  //Anim
  late final AnimationController _animationController;
  //Animation for 1st list
  late final Animation<double> _title;
  //Animation for 2nd list
  late final Animation<double> _button;
  //Animation for SVG
  late final Animation<double> _svg;

  //Countdown
  Timer? _timer;
  int _start = 10;

  bool _isButtonDisabled = true;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isButtonDisabled = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();

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
    _timer!.cancel();
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
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              FadeTransition(
                                opacity: _svg,
                                child: Container(
                                    height: 200,
                                    child: SvgPicture.asset('assets/images/newemail.svg')
                                ),
                              ),
                              const SizedBox(height: 20,),
                              FadeTransition(
                                  opacity: _title,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Do you receive an email from us?',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18
                                      ),
                                    ),
                                  )
                              ),
                              FadeTransition(
                                  opacity: _title,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "$_start",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FadeTransition(
                                    opacity: _button,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black,
                                        animationDuration: Duration(milliseconds: 400),
                                        elevation: 8.0,
                                      ),
                                      onPressed: (){
                                        navigateAndRemove(context, LoginScreen());
                                      },
                                      child: Text('Yes, I do', style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          letterSpacing: 2.0
                                      )),
                                    ),
                                  ),
                                  FadeTransition(
                                    opacity: _button,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black,
                                        animationDuration: Duration(milliseconds: 400),
                                        elevation: 8.0,
                                      ),
                                      onPressed: _isButtonDisabled ? null : (){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Sorry for our mistake. Please re-type your username and email in order to re-send your new password into your email. This page will destroy him-selves automatically.",
                                                style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                              backgroundColor: Colors.black,
                                              duration: Duration(seconds: 5),
                                            )
                                        );
                                        Future.delayed(Duration(milliseconds: 5200)).whenComplete(() => navigateAndRemove(context, ForgotPasswordScreen()));
                                      },
                                      child: Text(_isButtonDisabled ? 'Wait for a seconds' : 'No, I do not', style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          letterSpacing: 2.0
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                            ],
                          )
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
