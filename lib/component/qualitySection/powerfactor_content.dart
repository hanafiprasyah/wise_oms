import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            child: Container()
          // Container(
          //   color: Colors.transparent,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 10,),
          //       Center(
          //         child: Text('Live Power Factor', style: TextStyle(fontSize: 20,
          //             color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
          //       ),
          //       const SizedBox(height: 20,),
          //       //LineChart
          //       Container(
          //           margin: EdgeInsets.symmetric(horizontal: 20),
          //           height: MediaQuery.of(context).size.height*0.4,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20.0),
          //               color: Color(0xff232d37),
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
          //             padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
          //             child: AnimatedContainer(
          //                 duration: Duration(milliseconds: 150),
          //                 curve: Curves.linear,
          //                 child: LineChartWidPowerFactor()
          //             ),
          //           )
          //       ),
          //     ],
          //   ),
          // ),
        )
    );
  }
}

// class LineChartWidPowerFactor extends StatelessWidget {
//   LineChartWidPowerFactor({Key? key}) : super(key: key);
//
//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//         LineChartData(
//             minX: 0,
//             maxX: 23,
//             minY: 0,
//             maxY: 1,
//             titlesData: LineTitlesChart.getTitleData(),
//             gridData: FlGridData(
//                 show: true,
//                 getDrawingHorizontalLine: (value){
//                   return FlLine(
//                       color: const Color(0xff3743d),
//                       strokeWidth: 1
//                   );
//                 },
//                 drawVerticalLine: true,
//                 getDrawingVerticalLine: (value){
//                   return FlLine(
//                       color: const Color(0xff3743d),
//                       strokeWidth: 1
//                   );
//                 }
//             ),
//             borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: const Color(0xff3743d), width: 1)
//             ),
//             lineBarsData: [
//               LineChartBarData(
//                   spots: [
//                     FlSpot(0, 0),
//                     FlSpot(2, 0.9),
//                     FlSpot(5, 0.7),
//                     FlSpot(8, 0.8),
//                     FlSpot(11, 0.4),
//                     FlSpot(14, 0.8),
//                     FlSpot(17, 0.7),
//                     FlSpot(20, 0.5),
//                     FlSpot(23, 0.9),
//                   ],
//                   isCurved: true,
//                   colors: gradientColors,
//                   barWidth: 3,
//                   dotData: FlDotData(show: true),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//                   )
//               )
//             ]
//         )
//     );
//   }
// }
// class LineTitlesChart {
//   static getTitleData() => FlTitlesData(
//       show: true,
//       bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 12,
//           getTextStyles: (context, value) => const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 10
//           ),
//           getTitles: (value){
//             switch(value.toInt()){
//               case 2:
//                 return 'JAN';
//               case 5:
//                 return 'FEB';
//               case 8:
//                 return 'MAR';
//               case 11:
//                 return 'APR';
//               case 14:
//                 return 'MEI';
//               case 17:
//                 return 'JUN';
//               case 20:
//                 return 'JUL';
//               case 23:
//                 return 'AUG';
//             }
//             return '';
//           },
//           margin: 8,
//           interval: 1
//       ),
//       leftTitles: SideTitles(
//         showTitles: true,
//         getTextStyles: (context, value) => const TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 15,
//         ),
//         getTitles: (value) {
//           switch (value.toInt()) {
//             case 0:
//               return '0';
//             case 1:
//               return '1';
//           }
//           return '';
//         },
//         reservedSize: 24,
//         interval: 1,
//       ),
//       rightTitles: SideTitles(),
//       topTitles: SideTitles()
//   );
// }