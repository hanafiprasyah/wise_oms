import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:flutter_thermometer/label.dart';
import 'package:flutter_thermometer/thermometer.dart';
import 'package:flutter_thermometer/thermometer_widget.dart';


class TempLiveComponent extends StatefulWidget {
  const TempLiveComponent({Key? key}) : super(key: key);

  @override
  _TempLiveComponentState createState() => _TempLiveComponentState();
}
class _TempLiveComponentState extends State<TempLiveComponent> with TickerProviderStateMixin {

  AnimationController ?_controller;
  Animation<double> ?_fadeAnimationVolt;

  Timer? timer;
  bool isLoading = true;

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

    // Timer.periodic(const Duration(seconds: 1), generateRandDouble());
    timer = Timer.periodic(const Duration(seconds: 3), (t) =>
        setState(() {})
    );

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500)
    );

    //initialising the animation
    _fadeAnimationVolt = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    ));

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen = mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;

    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
              portrait: (_) => DefaultTabController(
                length: 5,
                child: Scaffold(
                  body: isLoading ? Center(child: CupertinoActivityIndicator()) : FadeTransition(
                    opacity: _fadeAnimationVolt!,
                    child: SafeArea(
                        child: GridView.count(
                          padding: EdgeInsets.all(20.0),
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: widthScreen/heightScreen*1.2,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Thermometer(
                                      value: 70, //max 70 min -10
                                      minValue: -10,
                                      maxValue: 70,
                                      radius: 30.0,
                                      barWidth: 30.0,
                                      outlineThickness: 5.0,
                                      outlineColor: Colors.black,
                                      mercuryColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                      mirrorScale: false,
                                      label: ThermometerLabel.celsius(),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text('70' + " \u2103",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  Text('Temperature A')
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Thermometer(
                                      value: 33, //max 70 min -10
                                      minValue: -10,
                                      maxValue: 70,
                                      radius: 30.0,
                                      barWidth: 30.0,
                                      outlineThickness: 5.0,
                                      outlineColor: Colors.black,
                                      mercuryColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                      mirrorScale: false,
                                      label: ThermometerLabel.celsius(),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text('33' + " \u2103",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  Text('Temperature B')
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Thermometer(
                                      value: 40, //max 70 min -10
                                      minValue: -10,
                                      maxValue: 70,
                                      radius: 30.0,
                                      barWidth: 30.0,
                                      outlineThickness: 5.0,
                                      outlineColor: Colors.black,
                                      mercuryColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                      mirrorScale: false,
                                      label: ThermometerLabel.celsius(),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text('40' + " \u2103",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  Text('Temperature C')
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Thermometer(
                                      value: 56, //max 70 min -10
                                      minValue: -10,
                                      maxValue: 70,
                                      radius: 30.0,
                                      barWidth: 30.0,
                                      outlineThickness: 5.0,
                                      outlineColor: Colors.black,
                                      mercuryColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                      mirrorScale: false,
                                      label: ThermometerLabel.celsius(),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text('56' + " \u2103",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  Text('Temperature D')
                                ],
                              ),
                            ),
                          ],
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
