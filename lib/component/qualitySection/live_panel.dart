import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';

class LivePanel extends StatefulWidget {
  const LivePanel({Key? key}) : super(key: key);

  @override
  _LivePanelState createState() => _LivePanelState();
}
class _LivePanelState extends State<LivePanel> {
  late List<VoltageData>? _charData;
  late ChartSeriesController _controller;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    _charData = getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          title: ChartTitle(text: 'Live Voltage'),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            LineSeries<VoltageData, int>(
                color: const Color.fromRGBO(192, 108, 132, 1),
                onRendererCreated: (ChartSeriesController controller){
                  _controller = controller;
                },
                dataSource: _charData!,
                xValueMapper: (VoltageData voldat, _) => voldat.time,
                yValueMapper: (VoltageData voldat, _) => voldat.speed,
                enableTooltip: true
            ),
          ],
          primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(width: 0),
              interval: 3,
              title: AxisTitle(text: 'Time(seconds)'),
              name: 'Time(seconds)'
          ),
          primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            name: 'Internet speed (Mbps)',
            title: AxisTitle(text: 'Internet speed (Mbps)'),
          ),
        ),
      ),
    );
    // var mediaQueryData = MediaQuery.of(context);
    // final double widthScreen = mediaQueryData.size.width;
    // final double appBarHeight = kToolbarHeight;
    // final double paddingTop = mediaQueryData.padding.top;
    // final double paddingBottom = mediaQueryData.padding.bottom;
    // final double heightScreen = mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;
    // return SafeArea(
    //   child: GridView.count(
    //       childAspectRatio: widthScreen/heightScreen,
    //       reverse: false,
    //       crossAxisCount: 2,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 10,
    //       physics: BouncingScrollPhysics(),
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
    //             border: Border(
    //                 right: BorderSide(
    //                   color: Colors.black
    //                 ),
    //                 bottom: BorderSide(
    //                   color: Colors.black
    //                 )
    //             )
    //           ),
    //             child: Center(
    //               child: SfRadialGauge(
    //                 title: GaugeTitle(text: "Voltage"),
    //               animationDuration: 2500,
    //               axes: <RadialAxis>[
    //                 RadialAxis(
    //                   minimum: 100,
    //                   maximum: 300,
    //                   ranges: <GaugeRange>[
    //                     GaugeRange(startValue: 100, endValue: 219, color: Colors.red,),
    //                     GaugeRange(startValue: 210, endValue: 215, color: Colors.yellow,),
    //                     GaugeRange(startValue: 215, endValue: 224, color: Colors.green,),
    //                     GaugeRange(startValue: 224, endValue: 230, color: Colors.yellow,),
    //                     GaugeRange(startValue: 230, endValue: 300, color: Colors.red,),
    //                   ],
    //                   pointers: const <GaugePointer>[
    //                     NeedlePointer(needleStartWidth: 1,needleEndWidth: 5,value: 245,enableAnimation: true,animationType: AnimationType.ease,animationDuration: 1000),
    //                   ],
    //                   annotations: <GaugeAnnotation>[
    //                     GaugeAnnotation(
    //                       horizontalAlignment: GaugeAlignment.center,
    //                       verticalAlignment: GaugeAlignment.center,
    //                       widget: Container(color: Colors.transparent,child:
    //                         const Text('High', style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),),),
    //                         angle: 90, positionFactor: 0.9,
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //               color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
    //               border: Border(
    //                   left: BorderSide(
    //                       color: Colors.black
    //                   ),
    //                   bottom: BorderSide(
    //                       color: Colors.black
    //                   )
    //               )
    //           ),
    //           child: Center(
    //             child: SfRadialGauge(
    //               title: GaugeTitle(text: "Ampere"),
    //               animationDuration: 2500,
    //               axes: <RadialAxis>[
    //                 RadialAxis(
    //                   minimum: 100,
    //                   maximum: 300,
    //                   ranges: <GaugeRange>[
    //                     GaugeRange(startValue: 100, endValue: 219, color: Colors.red,),
    //                     GaugeRange(startValue: 210, endValue: 215, color: Colors.yellow,),
    //                     GaugeRange(startValue: 215, endValue: 224, color: Colors.green,),
    //                     GaugeRange(startValue: 224, endValue: 230, color: Colors.yellow,),
    //                     GaugeRange(startValue: 230, endValue: 300, color: Colors.red,),
    //                   ],
    //                   pointers: const <GaugePointer>[
    //                     NeedlePointer(needleStartWidth: 1,needleEndWidth: 5,value: 245,enableAnimation: true,animationType: AnimationType.ease,animationDuration: 1000),
    //                   ],
    //                   annotations: <GaugeAnnotation>[
    //                     GaugeAnnotation(
    //                       horizontalAlignment: GaugeAlignment.center,
    //                       verticalAlignment: GaugeAlignment.center,
    //                       widget: Container(color: Colors.transparent,child:
    //                       const Text('High', style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),),),
    //                       angle: 90, positionFactor: 0.9,
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //               color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
    //               border: Border(
    //                   right: BorderSide(
    //                       color: Colors.black
    //                   ),
    //                   top: BorderSide(
    //                       color: Colors.black
    //                   )
    //               )
    //           ),
    //           child: Center(
    //             child: SfRadialGauge(
    //               title: GaugeTitle(text: "Power Factor"),
    //               animationDuration: 2500,
    //               axes: <RadialAxis>[
    //                 RadialAxis(
    //                   minimum: 100,
    //                   maximum: 300,
    //                   ranges: <GaugeRange>[
    //                     GaugeRange(startValue: 100, endValue: 219, color: Colors.red,),
    //                     GaugeRange(startValue: 210, endValue: 215, color: Colors.yellow,),
    //                     GaugeRange(startValue: 215, endValue: 224, color: Colors.green,),
    //                     GaugeRange(startValue: 224, endValue: 230, color: Colors.yellow,),
    //                     GaugeRange(startValue: 230, endValue: 300, color: Colors.red,),
    //                   ],
    //                   pointers: const <GaugePointer>[
    //                     NeedlePointer(needleStartWidth: 1,needleEndWidth: 5,value: 245,enableAnimation: true,animationType: AnimationType.ease,animationDuration: 1000),
    //                   ],
    //                   annotations: <GaugeAnnotation>[
    //                     GaugeAnnotation(
    //                       horizontalAlignment: GaugeAlignment.center,
    //                       verticalAlignment: GaugeAlignment.center,
    //                       widget: Container(color: Colors.transparent,child:
    //                       const Text('High', style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),),),
    //                       angle: 90, positionFactor: 0.9,
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //               color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
    //               border: Border(
    //                   left: BorderSide(
    //                       color: Colors.black
    //                   ),
    //                   top: BorderSide(
    //                       color: Colors.black
    //                   )
    //               ),
    //           ),
    //           child: Center(
    //             child: SfRadialGauge(
    //               title: GaugeTitle(text: "Grounding"),
    //               animationDuration: 2500,
    //               axes: <RadialAxis>[
    //                 RadialAxis(
    //                   minimum: 100,
    //                   maximum: 300,
    //                   ranges: <GaugeRange>[
    //                     GaugeRange(startValue: 100, endValue: 219, color: Colors.red,),
    //                     GaugeRange(startValue: 210, endValue: 215, color: Colors.yellow,),
    //                     GaugeRange(startValue: 215, endValue: 224, color: Colors.green,),
    //                     GaugeRange(startValue: 224, endValue: 230, color: Colors.yellow,),
    //                     GaugeRange(startValue: 230, endValue: 300, color: Colors.red,),
    //                   ],
    //                   pointers: const <GaugePointer>[
    //                     NeedlePointer(needleStartWidth: 1,needleEndWidth: 5,value: 245,enableAnimation: true,animationType: AnimationType.ease,animationDuration: 1000),
    //                   ],
    //                   annotations: <GaugeAnnotation>[
    //                     GaugeAnnotation(
    //                       horizontalAlignment: GaugeAlignment.center,
    //                       verticalAlignment: GaugeAlignment.center,
    //                       widget: Container(color: Colors.transparent,child:
    //                       const Text('High', style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),),),
    //                       angle: 90, positionFactor: 0.9,
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //   ),
    // );
  }

  int times = 19;
  void updateDataSource(Timer timer){
    _charData!.add(VoltageData(times++, (math.Random().nextInt(60) + 30)));
    _charData!.removeAt(0);
    _controller.updateDataSource(
        addedDataIndex: _charData!.length - 1,
        removedDataIndex: 0
    );
  }

  List<VoltageData>? getChartData(){
    final List<VoltageData> chartData = [
      VoltageData(0, 42),
      VoltageData(1, 47),
      VoltageData(2, 43),
      VoltageData(3, 49),
      VoltageData(4, 54),
      VoltageData(5, 41),
      VoltageData(6, 58),
      VoltageData(7, 51),
      VoltageData(8, 98),
      VoltageData(9, 41),
      VoltageData(10, 53),
      VoltageData(11, 72),
      VoltageData(12, 86),
      VoltageData(13, 52),
      VoltageData(14, 94),
      VoltageData(15, 92),
      VoltageData(16, 86),
      VoltageData(17, 72),
      VoltageData(18, 94),
    ];
    return chartData;
  }
}
class VoltageData {
  VoltageData(this.time, this.speed);
  final int time;
  final int speed;
}