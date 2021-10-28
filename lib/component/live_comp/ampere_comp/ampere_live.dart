import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AmpereLiveComponent extends StatefulWidget {
  const AmpereLiveComponent({Key? key}) : super(key: key);

  @override
  _AmpereLiveComponentState createState() => _AmpereLiveComponentState();
}
class _AmpereLiveComponentState extends State<AmpereLiveComponent> with SingleTickerProviderStateMixin {

  AnimationController ?_controller;
  Animation<double> ?_fadeAnimationAmpere;

  Timer? timer;
  bool isLoading = true;

  String _annotationValueR = '0 %';
  String _annotationValueS = '0 %';
  String _annotationValueT = '0 %';
  double _pointerValueR = 50;
  double _pointerValueS = 50;
  double _pointerValueT = 50;

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
    _fadeAnimationAmpere = Tween<double>(
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

    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen = mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;

    //Variable Live Ampere
    int minA = 0;
    int maxA = 5;

    // final valueRdVoltRSin = min + Random().nextInt(max-min).toDouble();
    int _valueR = minA + Random().nextInt(maxA-minA);
    if (_valueR > 0 && _valueR < 5) {
      _pointerValueR = _valueR.toDouble();
      _annotationValueR = _valueR.toString() + ' A';
    }
    int _valueS = minA + Random().nextInt(maxA-minA);
    if (_valueS > 0 && _valueS < 5) {
      _pointerValueS = _valueS.toDouble();
      _annotationValueS = _valueS.toString() + ' A';
    }
    int _valueT = minA + Random().nextInt(maxA-minA);
    if (_valueT > 0 && _valueT < 5) {
      _pointerValueT = _valueT.toDouble();
      _annotationValueT = _valueT.toString() + ' A';
    }

    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
              portrait: (_) => DefaultTabController(
                length: 5,
                child: Scaffold(
                  body: isLoading ? Center(child: CupertinoActivityIndicator()) : FadeTransition(
                    opacity: _fadeAnimationAmpere!,
                    child: SafeArea(
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: widthScreen/heightScreen*1.2,
                        children: [
                          ///Ampere R
                          Center(
                            child: SfRadialGauge(
                              title: GaugeTitle(text: 'Ampere R',alignment: GaugeAlignment.center,borderWidth: 20.0),
                              enableLoadingAnimation: true,
                              axes: [
                                RadialAxis(
                                  showLabels: false,
                                  showTicks: false,
                                  startAngle: 270,
                                  endAngle: 270,
                                  minimum: 0,
                                  maximum: 5,
                                  radiusFactor: 0.85,
                                  axisLineStyle: AxisLineStyle(
                                      color: Color.fromRGBO(106, 110, 246, 0.2),
                                      thicknessUnit: GaugeSizeUnit.factor,
                                      thickness: 0.1
                                  ),
                                  pointers: [
                                    RangePointer(
                                        value: _pointerValueR,
                                        cornerStyle: CornerStyle.bothCurve,
                                        enableAnimation: true,
                                        animationDuration: 1200,
                                        animationType: AnimationType.ease,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: const Color(0xFF6A6EF6),
                                        width: 0.1),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 0,
                                        positionFactor: 0.25,
                                        widget: Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: Text(
                                                _annotationValueR,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Times',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.italic),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ),
                          ///Ampere S
                          Center(
                            child: SfRadialGauge(
                              title: GaugeTitle(text: 'Ampere S',alignment: GaugeAlignment.center,borderWidth: 20.0),
                              enableLoadingAnimation: true,
                              axes: [
                                RadialAxis(
                                  showLabels: false,
                                  showTicks: false,
                                  startAngle: 270,
                                  endAngle: 270,
                                  minimum: 0,
                                  maximum: 5,
                                  radiusFactor: 0.85,
                                  axisLineStyle: AxisLineStyle(
                                      color: Color.fromRGBO(106, 110, 246, 0.2),
                                      thicknessUnit: GaugeSizeUnit.factor,
                                      thickness: 0.1
                                  ),
                                  pointers: [
                                    RangePointer(
                                        value: _pointerValueS,
                                        cornerStyle: CornerStyle.bothCurve,
                                        enableAnimation: true,
                                        animationDuration: 1200,
                                        animationType: AnimationType.ease,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: const Color(0xFF6A6EF6),
                                        width: 0.1),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 0,
                                        positionFactor: 0.25,
                                        widget: Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: Text(
                                                _annotationValueS,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Times',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.italic),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ),
                          ///Ampere T
                          Center(
                            child: SfRadialGauge(
                              title: GaugeTitle(text: 'Ampere T',alignment: GaugeAlignment.center,borderWidth: 20.0),
                              enableLoadingAnimation: true,
                              axes: [
                                RadialAxis(
                                  showLabels: false,
                                  showTicks: false,
                                  startAngle: 270,
                                  endAngle: 270,
                                  minimum: 0,
                                  maximum: 5,
                                  radiusFactor: 0.85,
                                  axisLineStyle: AxisLineStyle(
                                      color: Color.fromRGBO(106, 110, 246, 0.2),
                                      thicknessUnit: GaugeSizeUnit.factor,
                                      thickness: 0.1
                                  ),
                                  pointers: [
                                    RangePointer(
                                        value: _pointerValueT,
                                        cornerStyle: CornerStyle.bothCurve,
                                        enableAnimation: true,
                                        animationDuration: 1200,
                                        animationType: AnimationType.ease,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: const Color(0xFF6A6EF6),
                                        width: 0.1),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 0,
                                        positionFactor: 0.25,
                                        widget: Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: Text(
                                                _annotationValueT,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Times',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.italic),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ),
                          ///Desc
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6A6EF6),
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Text('Usage Color'),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(106, 110, 246, 0.2),
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Text('Unusage Color'),
                                  ],
                                )
                              ],
                            )
                          ),
                        ],
                      ),
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
