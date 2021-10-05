import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class QualitySection extends StatefulWidget {
  const QualitySection({Key? key}) : super(key: key);

  @override
  _QualitySectionState createState() => _QualitySectionState();
}
class _QualitySectionState extends State<QualitySection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    bottomOpacity: 0,
                    elevation: 0,
                    leadingWidth: MediaQuery.of(context).size.width,
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton.icon(
                        icon: Icon(Ionicons.refresh,color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white),
                        onPressed: (){
                          setState(() {});
                        },
                        label: Text('Refresh',style: TextStyle(fontSize: 10)),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          )
                        ),
                      ),
                    ),
                    actions: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: LeadingContent(),
                      )
                    ],
                  ),
                  body: PageView(
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      LivePanel(),
                      Voltage(),
                      PowerFactor(),
                      Grounding(),
                    ],
                  ),
                )
            );
          }
          return Container();
        }
    );
  }
}

//Leading
class LeadingContent extends StatefulWidget {
  const LeadingContent({Key? key}) : super(key: key);

  @override
  _LeadingContentState createState() => _LeadingContentState();
}
class _LeadingContentState extends State<LeadingContent> {
  String dropDownValue = "Recently";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Ionicons.list,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.white : Colors.black,),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(fontSize: 12,
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.white : Colors.black),
        underline: Container(
          height: 1,
        ),
        onChanged: (String? newValue){
          setState(() {
            dropDownValue = newValue!;
          });
        },
        items: <String>['Recently', 'Weekly', 'Monthly'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value+'   '),
          );
        }).toList(),
    );
  }
}

//LivePanel
class LivePanel extends StatefulWidget {
  const LivePanel({Key? key}) : super(key: key);

  @override
  _LivePanelState createState() => _LivePanelState();
}
class _LivePanelState extends State<LivePanel> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen = mediaQueryData.size.height - paddingBottom - paddingTop - appBarHeight;
    return SafeArea(
      child: GridView.count(
          childAspectRatio: widthScreen/heightScreen,
          reverse: false,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                border: Border(
                    right: BorderSide(
                      color: Colors.black
                    ),
                    bottom: BorderSide(
                      color: Colors.black
                    )
                )
              ),
                child: Center(
                  child: SfRadialGauge(
                    title: GaugeTitle(text: "Voltage"),
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
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                  border: Border(
                      left: BorderSide(
                          color: Colors.black
                      ),
                      bottom: BorderSide(
                          color: Colors.black
                      )
                  )
              ),
              child: Center(
                child: SfRadialGauge(
                  title: GaugeTitle(text: "Ampere"),
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
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                  border: Border(
                      right: BorderSide(
                          color: Colors.black
                      ),
                      top: BorderSide(
                          color: Colors.black
                      )
                  )
              ),
              child: Center(
                child: SfRadialGauge(
                  title: GaugeTitle(text: "Power Factor"),
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
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                  border: Border(
                      left: BorderSide(
                          color: Colors.black
                      ),
                      top: BorderSide(
                          color: Colors.black
                      )
                  ),
              ),
              child: Center(
                child: SfRadialGauge(
                  title: GaugeTitle(text: "Grounding"),
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
              ),
            ),
          ],
      ),
    );
    // SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       const SizedBox(height: 20),
    //       Center(child: Text("LIVE PANEL",style: TextStyle(fontSize: 22),)),
    //       const SizedBox(height: 20),
    //       //LivePanelVolt
    //       Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text("Voltage Live Panel",style: TextStyle(fontSize: 16))
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: const BorderRadius.all(Radius.circular(20)),
    //             image: DecorationImage(
    //                 image: AssetImage("assets/images/papanhitam.jpg"),
    //                 fit: BoxFit.cover
    //             ),
    //             border: Border.all(color: Colors.grey.shade500,width: 3),
    //             color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade300 : Colors.grey.shade500,
    //                   offset: const Offset(20, 20),
    //                   blurRadius: 1,
    //                   spreadRadius: -15)
    //             ],
    //           ),
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height * 0.2,
    //           child: Center(
    //             child: Text('245',style: TextStyle(
    //                 fontSize: 60,
    //                 letterSpacing: 10,
    //                 color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
    //             ),),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 20),
    //       //LivePanelPF
    //       Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text("Power Factor Live Panel",style: TextStyle(fontSize: 16))
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: const BorderRadius.all(Radius.circular(20)),
    //             image: DecorationImage(
    //                 image: AssetImage("assets/images/papanhitam.jpg"),
    //                 fit: BoxFit.cover
    //             ),
    //             border: Border.all(color: Colors.grey.shade500,width: 3),
    //             color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade300 : Colors.grey.shade500,
    //                   offset: const Offset(20, 20),
    //                   blurRadius: 1,
    //                   spreadRadius: -15)
    //             ],
    //           ),
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height * 0.2,
    //           child: Center(
    //             child: Text('0.5',style: TextStyle(
    //                 fontSize: 60,
    //                 letterSpacing: 10,
    //                 color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
    //             ),),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 20),
    //       //LivePanelGrounding
    //       Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text("Grounding Live Panel",style: TextStyle(fontSize: 16))
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: const BorderRadius.all(Radius.circular(20)),
    //             image: DecorationImage(
    //                 image: AssetImage("assets/images/papanhitam.jpg"),
    //                 fit: BoxFit.cover
    //             ),
    //             border: Border.all(color: Colors.grey.shade500,width: 3),
    //             color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade300 : Colors.grey.shade500,
    //                   offset: const Offset(20, 20),
    //                   blurRadius: 1,
    //                   spreadRadius: -15)
    //             ],
    //           ),
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height * 0.2,
    //           child: Center(
    //             child: Text('212',style: TextStyle(
    //                 fontSize: 60,
    //                 letterSpacing: 10,
    //                 color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
    //             ),),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 80),
    //
    //     ],
    //   ),
    // );
  }
}

//Chart Content
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
                  child: Text('Live Voltage', style: TextStyle(fontSize: 20,
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

class PowerFactor extends StatefulWidget {
  const PowerFactor({Key? key}) : super(key: key);

  @override
  _PowerFactorState createState() => _PowerFactorState();
}
class _PowerFactorState extends State<PowerFactor> {
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
                  child: Text('Live Power Factor', style: TextStyle(fontSize: 20,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                ),
                const SizedBox(height: 20,),
                //LineChart
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xff232d37),
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
                      padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          curve: Curves.linear,
                          child: LineChartWidPowerFactor()
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

class Grounding extends StatefulWidget {
  const Grounding({Key? key}) : super(key: key);

  @override
  _GroundingState createState() => _GroundingState();
}
class _GroundingState extends State<Grounding> {
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
                  child: Text('Live Grounding', style: TextStyle(fontSize: 20,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                ),
                const SizedBox(height: 20,),
                //LineGraphChart
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
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: LineChartWidGrounding(isShowingData: true,),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}

class LineChartWidPowerFactor extends StatelessWidget {
  LineChartWidPowerFactor({Key? key}) : super(key: key);

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 23,
        minY: 0,
        maxY: 1,
        titlesData: LineTitlesChart.getTitleData(),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: const Color(0xff3743d),
              strokeWidth: 1
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine: (value){
            return FlLine(
                color: const Color(0xff3743d),
                strokeWidth: 1
            );
          }
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff3743d), width: 1)
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 0),
              FlSpot(2, 0.9),
              FlSpot(5, 0.7),
              FlSpot(8, 0.8),
              FlSpot(11, 0.4),
              FlSpot(14, 0.8),
              FlSpot(17, 0.7),
              FlSpot(20, 0.5),
              FlSpot(23, 0.9),
            ],
            isCurved: true,
            colors: gradientColors,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            )
          )
        ]
      )
    );
  }
}
class LineTitlesChart {
  static getTitleData() => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 12,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10
        ),
        getTitles: (value){
          switch(value.toInt()){
            case 2:
              return 'JAN';
            case 5:
              return 'FEB';
            case 8:
              return 'MAR';
            case 11:
              return 'APR';
            case 14:
              return 'MEI';
            case 17:
              return 'JUN';
            case 20:
              return 'JUL';
            case 23:
              return 'AUG';
          }
          return '';
        },
        margin: 8,
        interval: 1
      ),
      leftTitles: SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return '0';
          case 1:
            return '1';
        }
        return '';
      },
      reservedSize: 24,
      interval: 1,
    ),
      rightTitles: SideTitles(),
      topTitles: SideTitles()
  );
}

class LineChartWidGrounding extends StatelessWidget {
  LineChartWidGrounding({Key? key, required this.isShowingData}) : super(key: key);

  final bool isShowingData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingData ? data1 : data2,
      swapAnimationCurve: Curves.fastOutSlowIn,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get data1 => LineChartData(
    lineTouchData: lineTouchData1,
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 14,
    maxY: 4,
    minY: 0
  );

  LineChartData get data2 => LineChartData(
      lineTouchData: lineTouchData2,
      gridData: gridData,
      titlesData: titlesData2,
      borderData: borderData,
      lineBarsData: lineBarsData2,
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8)
    )
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: bottomTitles,
    rightTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    leftTitles: leftTitles(
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return '1m';
          case 2:
            return '2m';
          case 3:
            return '3m';
          case 4:
            return '5m';
        }
        return '';
      },
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
    lineChartBarData1_3,
  ];

  LineTouchData get lineTouchData2 => LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: bottomTitles,
    rightTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    leftTitles: leftTitles(
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return '1m';
          case 2:
            return '2m';
          case 3:
            return '3m';
          case 4:
            return '5m';
          case 5:
            return '6m';
        }
        return '';
      },
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    lineChartBarData2_1,
    lineChartBarData2_2,
    lineChartBarData2_3,
  ];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
    getTitles: getTitles,
    showTitles: true,
    margin: 8,
    interval: 1,
    reservedSize: 40,
    getTextStyles: (context, value) => const TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 22,
    margin: 10,
    interval: 1,
    getTextStyles: (context, value) => const TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    getTitles: (value) {
      switch (value.toInt()) {
        case 2:
          return 'SEPT';
        case 7:
          return 'OCT';
        case 12:
          return 'DEC';
      }
      return '';
    },
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Color(0xff4e4965), width: 4),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    colors: [const Color(0xff4af699)],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    colors: [const Color(0xffaa4cfc)],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false, colors: [
      const Color(0x00aa4cfc),
    ]),
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
    isCurved: true,
    colors: const [Color(0xff27b6fc)],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: [
      FlSpot(1, 2.8),
      FlSpot(3, 1.9),
      FlSpot(6, 3),
      FlSpot(10, 1.3),
      FlSpot(13, 2.5),
    ],
  );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    colors: const [Color(0x444af699)],
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 4),
      FlSpot(5, 1.8),
      FlSpot(7, 5),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
  );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
    isCurved: true,
    colors: const [Color(0x99aa4cfc)],
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      colors: [
        const Color(0x33aa4cfc),
      ],
    ),
    spots: [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    colors: const [Color(0x4427b6fc)],
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: [
      FlSpot(1, 3.8),
      FlSpot(3, 1.9),
      FlSpot(6, 5),
      FlSpot(10, 3.3),
      FlSpot(13, 4.5),
    ],
  );
}