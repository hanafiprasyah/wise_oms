import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            child: Container()
          // Container(
          //   color: Colors.transparent,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 10,),
          //       Center(
          //         child: Text('Live Grounding', style: TextStyle(fontSize: 20,
          //             color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
          //       ),
          //       const SizedBox(height: 20,),
          //       //LineGraphChart
          //       Container(
          //           padding: EdgeInsets.symmetric(horizontal: 20),
          //           margin: EdgeInsets.symmetric(horizontal: 20),
          //           height: MediaQuery.of(context).size.height*0.4,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20.0),
          //               color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
          //               border: Border.all(color: Colors.grey.shade500,width: 2),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade300 : Colors.grey.shade500,
          //                     offset: const Offset(20, 20),
          //                     blurRadius: 1,
          //                     spreadRadius: -15)
          //               ]
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 20.0),
          //             child: LineChartWidGrounding(isShowingData: true,),
          //           )
          //       ),
          //     ],
          //   ),
          // ),
        )
    );
  }
}

// class LineChartWidGrounding extends StatelessWidget {
//   LineChartWidGrounding({Key? key, required this.isShowingData}) : super(key: key);
//
//   final bool isShowingData;
//
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       isShowingData ? data1 : data2,
//       swapAnimationCurve: Curves.fastOutSlowIn,
//       swapAnimationDuration: const Duration(milliseconds: 250),
//     );
//   }
//
//   LineChartData get data1 => LineChartData(
//       lineTouchData: lineTouchData1,
//       gridData: gridData,
//       titlesData: titlesData1,
//       borderData: borderData,
//       lineBarsData: lineBarsData1,
//       minX: 0,
//       maxX: 14,
//       maxY: 4,
//       minY: 0
//   );
//
//   LineChartData get data2 => LineChartData(
//       lineTouchData: lineTouchData2,
//       gridData: gridData,
//       titlesData: titlesData2,
//       borderData: borderData,
//       lineBarsData: lineBarsData2,
//       minX: 0,
//       maxX: 14,
//       maxY: 6,
//       minY: 0
//   );
//
//   LineTouchData get lineTouchData1 => LineTouchData(
//       handleBuiltInTouches: true,
//       touchTooltipData: LineTouchTooltipData(
//           tooltipBgColor: Colors.blueGrey.withOpacity(0.8)
//       )
//   );
//
//   FlTitlesData get titlesData1 => FlTitlesData(
//     bottomTitles: bottomTitles,
//     rightTitles: SideTitles(showTitles: false),
//     topTitles: SideTitles(showTitles: false),
//     leftTitles: leftTitles(
//       getTitles: (value) {
//         switch (value.toInt()) {
//           case 1:
//             return '1m';
//           case 2:
//             return '2m';
//           case 3:
//             return '3m';
//           case 4:
//             return '5m';
//         }
//         return '';
//       },
//     ),
//   );
//
//   List<LineChartBarData> get lineBarsData1 => [
//     lineChartBarData1_1,
//     lineChartBarData1_2,
//     lineChartBarData1_3,
//   ];
//
//   LineTouchData get lineTouchData2 => LineTouchData(
//     enabled: false,
//   );
//
//   FlTitlesData get titlesData2 => FlTitlesData(
//     bottomTitles: bottomTitles,
//     rightTitles: SideTitles(showTitles: false),
//     topTitles: SideTitles(showTitles: false),
//     leftTitles: leftTitles(
//       getTitles: (value) {
//         switch (value.toInt()) {
//           case 1:
//             return '1m';
//           case 2:
//             return '2m';
//           case 3:
//             return '3m';
//           case 4:
//             return '5m';
//           case 5:
//             return '6m';
//         }
//         return '';
//       },
//     ),
//   );
//
//   List<LineChartBarData> get lineBarsData2 => [
//     lineChartBarData2_1,
//     lineChartBarData2_2,
//     lineChartBarData2_3,
//   ];
//
//   SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
//     getTitles: getTitles,
//     showTitles: true,
//     margin: 8,
//     interval: 1,
//     reservedSize: 40,
//     getTextStyles: (context, value) => const TextStyle(
//       color: Color(0xff75729e),
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     ),
//   );
//
//   SideTitles get bottomTitles => SideTitles(
//     showTitles: true,
//     reservedSize: 22,
//     margin: 10,
//     interval: 1,
//     getTextStyles: (context, value) => const TextStyle(
//       color: Color(0xff72719b),
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     ),
//     getTitles: (value) {
//       switch (value.toInt()) {
//         case 2:
//           return 'SEPT';
//         case 7:
//           return 'OCT';
//         case 12:
//           return 'DEC';
//       }
//       return '';
//     },
//   );
//
//   FlGridData get gridData => FlGridData(show: false);
//
//   FlBorderData get borderData => FlBorderData(
//     show: true,
//     border: const Border(
//       bottom: BorderSide(color: Color(0xff4e4965), width: 4),
//       left: BorderSide(color: Colors.transparent),
//       right: BorderSide(color: Colors.transparent),
//       top: BorderSide(color: Colors.transparent),
//     ),
//   );
//
//   LineChartBarData get lineChartBarData1_1 => LineChartBarData(
//     isCurved: true,
//     colors: [const Color(0xff4af699)],
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: [
//       FlSpot(1, 1),
//       FlSpot(3, 1.5),
//       FlSpot(5, 1.4),
//       FlSpot(7, 3.4),
//       FlSpot(10, 2),
//       FlSpot(12, 2.2),
//       FlSpot(13, 1.8),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData1_2 => LineChartBarData(
//     isCurved: true,
//     colors: [const Color(0xffaa4cfc)],
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: false),
//     belowBarData: BarAreaData(show: false, colors: [
//       const Color(0x00aa4cfc),
//     ]),
//     spots: [
//       FlSpot(1, 1),
//       FlSpot(3, 2.8),
//       FlSpot(7, 1.2),
//       FlSpot(10, 2.8),
//       FlSpot(12, 2.6),
//       FlSpot(13, 3.9),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData1_3 => LineChartBarData(
//     isCurved: true,
//     colors: const [Color(0xff27b6fc)],
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: [
//       FlSpot(1, 2.8),
//       FlSpot(3, 1.9),
//       FlSpot(6, 3),
//       FlSpot(10, 1.3),
//       FlSpot(13, 2.5),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData2_1 => LineChartBarData(
//     isCurved: true,
//     curveSmoothness: 0,
//     colors: const [Color(0x444af699)],
//     barWidth: 4,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: [
//       FlSpot(1, 1),
//       FlSpot(3, 4),
//       FlSpot(5, 1.8),
//       FlSpot(7, 5),
//       FlSpot(10, 2),
//       FlSpot(12, 2.2),
//       FlSpot(13, 1.8),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData2_2 => LineChartBarData(
//     isCurved: true,
//     colors: const [Color(0x99aa4cfc)],
//     barWidth: 4,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: false),
//     belowBarData: BarAreaData(
//       show: true,
//       colors: [
//         const Color(0x33aa4cfc),
//       ],
//     ),
//     spots: [
//       FlSpot(1, 1),
//       FlSpot(3, 2.8),
//       FlSpot(7, 1.2),
//       FlSpot(10, 2.8),
//       FlSpot(12, 2.6),
//       FlSpot(13, 3.9),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData2_3 => LineChartBarData(
//     isCurved: true,
//     curveSmoothness: 0,
//     colors: const [Color(0x4427b6fc)],
//     barWidth: 2,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: true),
//     belowBarData: BarAreaData(show: false),
//     spots: [
//       FlSpot(1, 3.8),
//       FlSpot(3, 1.9),
//       FlSpot(6, 5),
//       FlSpot(10, 3.3),
//       FlSpot(13, 4.5),
//     ],
//   );
// }