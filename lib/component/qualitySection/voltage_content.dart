import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Voltage extends StatefulWidget {
  const Voltage({Key? key}) : super(key: key);

  @override
  _VoltageState createState() => _VoltageState();
}
class _VoltageState extends State<Voltage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Center(
                  child: Text('Recently', style: TextStyle(fontSize: 20,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                ),
                const SizedBox(height: 20,),
                //Gauge
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                        border: Border.all(color: Colors.grey.shade500,width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade300 : Colors.grey.shade500,
                              offset: const Offset(20, 20),
                              blurRadius: 1,
                              spreadRadius: -15)
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SfRadialGauge(
                        enableLoadingAnimation: true,
                        animationDuration: 2500,
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 100,
                            maximum: 300,
                            ranges: <GaugeRange>[
                              GaugeRange(startValue: 100, endValue: 219, color: Colors.red,),
                              GaugeRange(startValue: 210, endValue: 215, color: Colors.yellow,),
                              GaugeRange(startValue: 215, endValue: 224, color: Colors.green,),
                              GaugeRange(startValue: 224, endValue: 230, color: Colors.yellow,),
                              GaugeRange(startValue: 230, endValue: 300, color: Colors.red,),
                            ],
                            pointers: const <GaugePointer>[
                              NeedlePointer(needleStartWidth: 1,needleEndWidth: 5,value: 245,enableAnimation: true,animationType: AnimationType.ease,animationDuration: 1000),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                horizontalAlignment: GaugeAlignment.center,
                                verticalAlignment: GaugeAlignment.center,
                                widget: Container(color: Colors.transparent,child:
                                const Text('High', style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),),),
                                angle: 90, positionFactor: 0.9,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}