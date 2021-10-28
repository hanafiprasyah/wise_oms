import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PFLiveComponent extends StatefulWidget {
  const PFLiveComponent({Key? key}) : super(key: key);

  @override
  _PFLiveComponentState createState() => _PFLiveComponentState();
}
class _PFLiveComponentState extends State<PFLiveComponent> with SingleTickerProviderStateMixin {

  AnimationController ?_controller;
  Animation<double> ?_fadeAnimationPF;

  Timer? timer;
  bool isLoading = true;

  String _values = 'Calculating';
  String desc = 'Waiting for server';

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      if(mounted){
        setState(() {
          isLoading = false;
        });
        _controller!.forward();
      }
    });

    timer = Timer.periodic(const Duration(seconds: 3), (t) =>
        setState(() {
          updatePFtext();
        })
    );

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1050)
    );

    //initialising the animation
    _fadeAnimationPF = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOut,
    ));

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller!.dispose();
    super.dispose();
  }

  void updatePFtext(){
    double minPF = 0.0;
    double maxPF = 1.0;
    var _value = Random().nextDouble() * (minPF - maxPF) + maxPF;
    setState(() {
      _values = _value.toStringAsFixed(2);
    });
    if(_value < 0.7){
      setState(() {
        desc = 'Very Bad';
      });
    } else if (_value >= 0.7 && _value <= 0.8){
      setState(() {
        desc = 'Bad';
      });
    } else if (_value > 0.8){
      setState(() {
        desc = 'Normal';
      });
    } else {
      setState(() {
        desc = 'Not Detected';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // double doubleInRange(Random source, num start, num end) =>
    //     source.nextDouble() * (end - start) + start;

    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;

    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
              portrait: (_) => DefaultTabController(
                length: 5,
                child: Scaffold(
                  body: isLoading ? Center(child: CupertinoActivityIndicator()) : FadeTransition(
                    opacity: _fadeAnimationPF!,
                    child: SafeArea(
                      child: Container(
                        width: widthScreen,
                        height: heightScreen,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Center(
                              child: Text('Power Factor', style: TextStyle(
                                fontSize: 22.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                height: heightScreen * 0.3,
                                width: widthScreen,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/bgkayu.jpg',),
                                    fit: BoxFit.fill
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('$_values',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 6.0
                                    )),
                                    SizedBox(height: 20,),
                                    Text('$desc',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 6.0
                                )),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              ),
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
