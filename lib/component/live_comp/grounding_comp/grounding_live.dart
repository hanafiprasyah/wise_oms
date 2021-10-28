import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GroundingLiveComponent extends StatefulWidget {
  const GroundingLiveComponent({Key? key}) : super(key: key);

  @override
  _GroundingLiveComponentState createState() => _GroundingLiveComponentState();
}
class _GroundingLiveComponentState extends State<GroundingLiveComponent> with SingleTickerProviderStateMixin {

  AnimationController ?_controller;
  Animation<double> ?_fadeAnimationGrounding;

  Timer? timer;
  bool isLoading = true;

  String _descGrInput = '0.0';
  String _descGrOutput = '0.0';

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      if(mounted){
        loadWidget();
        _controller!.forward();
      }
    });

    // Timer.periodic(const Duration(seconds: 1), generateRandDouble());
    timer = Timer.periodic(const Duration(seconds: 5), (t) =>
        setState(() {})
    );

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1050)
    );

    //initialising the animation
    _fadeAnimationGrounding = Tween<double>(
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

  void loadWidget(){
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final PageController controllerGr = PageController(initialPage: 0);

    //Variable Live Grounding
    double minGr = 0.0;
    double maxGr = 10.0;
    final valueGroundInput = minGr + Random().nextDouble() * (minGr - maxGr) + maxGr;
    final valueGroundOutput = minGr + Random().nextDouble() * (minGr - maxGr) + maxGr;

    _descGrInput = valueGroundInput.toStringAsFixed(2);
    _descGrOutput = valueGroundOutput.toStringAsFixed(2);

    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
              portrait: (_) => DefaultTabController(
                length: 5,
                child: Scaffold(
                  body: isLoading ? Center(child: CupertinoActivityIndicator()) : FadeTransition(
                    opacity: _fadeAnimationGrounding!,
                    child: SafeArea(
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: controllerGr,
                        scrollDirection: Axis.vertical,
                        children: [
                          ///INPUT
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: SfRadialGauge(
                              title: GaugeTitle(text: 'Input Grounding',textStyle: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                              )),
                              axes: [
                                RadialAxis(
                                  startAngle: 90,
                                  endAngle: 270,
                                  interval: 20.0,
                                  canScaleToFit: true,
                                  axisLineStyle: AxisLineStyle(
                                    cornerStyle: CornerStyle.bothCurve,
                                  ),
                                  minimum: 0,
                                  maximum: 10,
                                  ranges: [
                                    GaugeRange(startValue: 0, endValue: 0.1, color: Colors.green,),
                                    GaugeRange(startValue: 0.1, endValue: 10.0, color: Colors.red,),
                                  ],
                                  pointers: [
                                    NeedlePointer(
                                      value: valueGroundInput,
                                    ),
                                  ],
                                  annotations: [
                                    GaugeAnnotation(
                                      widget: Container(
                                          child: Text('$_descGrInput', style: TextStyle(
                                            fontSize: 18.0,
                                            letterSpacing: 2.0,
                                          ),)),
                                      angle: 90,
                                      positionFactor: 0.5,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ///OUTPUT
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: SfRadialGauge(
                              title: GaugeTitle(text: 'Output Grounding',textStyle: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                              )),
                              axes: [
                                RadialAxis(
                                  startAngle: 90,
                                  endAngle: 270,
                                  interval: 20.0,
                                  canScaleToFit: true,
                                  axisLineStyle: AxisLineStyle(
                                    cornerStyle: CornerStyle.bothCurve,
                                  ),
                                  minimum: 0,
                                  maximum: 10,
                                  ranges: [
                                    GaugeRange(startValue: 0, endValue: 0.1, color: Colors.green,),
                                    GaugeRange(startValue: 0.1, endValue: 10.0, color: Colors.red,),
                                  ],
                                  pointers: [
                                    NeedlePointer(
                                      value: valueGroundOutput,
                                    ),
                                  ],
                                  annotations: [
                                    GaugeAnnotation(
                                      widget: Container(
                                          child: Text('$_descGrOutput', style: TextStyle(
                                            fontSize: 18.0,
                                            letterSpacing: 2.0,
                                          ),)),
                                      angle: 90,
                                      positionFactor: 0.5,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
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
