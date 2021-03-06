import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VoltageLiveComponent extends StatefulWidget {
  const VoltageLiveComponent({Key? key}) : super(key: key);

  @override
  _VoltageLiveComponentState createState() => _VoltageLiveComponentState();
}

class _VoltageLiveComponentState extends State<VoltageLiveComponent> with SingleTickerProviderStateMixin {

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

    // var mediaQueryData = MediaQuery.of(context);
    // final double widthScreen = mediaQueryData.size.width;
    // final double appBarHeight = kToolbarHeight;
    // final double paddingTop = mediaQueryData.padding.top;
    // final double paddingBottom = mediaQueryData.padding.bottom;
    // final double heightScreen = mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;

    final PageController controller = PageController(initialPage: 0);

    //Variable Live Volt
    int min = 218;
    int max = 250;
    final valueRdVoltRSin = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltRSOut = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltSTin = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltSTout = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltTRin = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltTRout = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltRNin = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltRNout = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltSNin = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltSNout = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltTNin = min + Random().nextInt(max-min).toDouble();
    final valueRdVoltTNout = min + Random().nextInt(max-min).toDouble();

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
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          controller: controller,
                          scrollDirection: Axis.vertical,
                          children: [
                            ///VOLT-IO-RS
                            Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Input Volt R-S',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        interval: 15.0,
                                        canScaleToFit: true,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltRSin,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltRSin', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Output Volt R-S',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltRSOut,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltRSOut', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                            ///VOLT-IO-ST
                            Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Input Volt S-T',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltSTin,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltSTin', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Output Volt S-T',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltSTout,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltSTout', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                            ///VOLT-IO-TR
                            Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Input Volt T-R',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltTRin,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltTRin', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Output Volt T-R',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltTRout,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltTRout', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                            ///VOLT-IO-RN
                            Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Input Volt R-N',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltRNin,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltRNin', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Output Volt R-N',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltRNout,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltRNout', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                            ///VOLT-IO-SN
                            Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Input Volt S-N',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltSNin,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltSNin', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Output Volt S-N',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltSNout,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltSNout', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                            ///VOLT-IO-TN
                            Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Input Volt T-N',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltTNin,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltTNin', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SfRadialGauge(
                                    title: GaugeTitle(text: 'Output Volt T-N',textStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 20.0,
                                    )),
                                    axes: [
                                      RadialAxis(
                                        canScaleToFit: true,
                                        interval: 15.0,
                                        axisLineStyle: AxisLineStyle(
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        minimum: 110,
                                        maximum: 380,
                                        ranges: [
                                          GaugeRange(label: 'Very Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 110, endValue: 160, color: Colors.grey.shade600,),
                                          GaugeRange(label: 'Low',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 160, endValue: 218, color: Colors.grey.shade800,),
                                          GaugeRange(startValue: 218, endValue: 225, color: Colors.green,),
                                          GaugeRange(label: 'High',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 225, endValue: 310, color: Colors.orange,),
                                          GaugeRange(label: 'Extreme',labelStyle: GaugeTextStyle(fontSize: 10),startValue: 310, endValue: 380, color: Colors.red,),
                                        ],
                                        pointers: [
                                          NeedlePointer(
                                            value: valueRdVoltTNout,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Container(
                                                child: Text('$valueRdVoltTNout', style: TextStyle(
                                                  fontSize: 18.0,
                                                  letterSpacing: 2.0,
                                                ),)),
                                            angle: 90,
                                            positionFactor: 0.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                )
                              ],
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
