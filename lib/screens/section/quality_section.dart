import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wise_oms/component/qualitySection/live_panel.dart';
import 'package:wise_oms/core/navigation.dart';

class QualitySection extends StatefulWidget {
  const QualitySection({Key? key}) : super(key: key);

  @override
  _QualitySectionState createState() => _QualitySectionState();
}
class _QualitySectionState extends State<QualitySection> with SingleTickerProviderStateMixin {

  AnimationController ?_controller;
  Animation<double> ?_fadeAnimationOne;
  Animation<double> ?_fadeAnimationTwo;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500)
    );

    //initialising the animation
    _fadeAnimationOne = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOut,
    ));

    //initialising the animation
    _fadeAnimationTwo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      //delay
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.easeOut,
      ),
    ));

    Timer(Duration(milliseconds: 250), () {_controller!.forward();});
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    // leadingWidth: MediaQuery.of(context).size.width,
                    // leading: Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: ElevatedButton.icon(
                    //     icon: Icon(CupertinoIcons.arrow_2_circlepath,color: Colors.white),
                    //     onPressed: (){
                    //       setState(() {});
                    //     },
                    //     label: Text('Refresh',style: TextStyle(fontSize: 12)),
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Colors.black,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(50)
                    //       )
                    //     ),
                    //   ),
                    // ),
                  ),
                  body: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimationOne!,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  const VerticalDivider(
                                    color: Colors.black,
                                    width: 50,
                                    thickness: 4,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, LivePanel());
                                      },
                                      child: Text('Live Quality Panel'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _fadeAnimationTwo!,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  const VerticalDivider(
                                    color: Colors.black,
                                    width: 50,
                                    thickness: 4,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: ElevatedButton(
                                      onPressed: (){},
                                      child: Text('Quality: Monthly'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
