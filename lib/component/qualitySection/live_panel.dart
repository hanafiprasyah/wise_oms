import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wise_oms/component/live_comp/ampere_comp/ampere_live.dart';
import 'package:wise_oms/component/live_comp/grounding_comp/grounding_live.dart';
import 'package:wise_oms/component/live_comp/pf_comp/pf_live.dart';
import 'package:wise_oms/component/live_comp/temp_comp/temp_live.dart';
import 'package:wise_oms/component/live_comp/volt_comp/voltage_live.dart';

class LivePanel extends StatefulWidget {
  const LivePanel({Key? key}) : super(key: key);

  @override
  _LivePanelState createState() => _LivePanelState();
}
class _LivePanelState extends State<LivePanel> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => DefaultTabController(
                  length: 5,
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: const TabBar(
                        physics: BouncingScrollPhysics(),
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(text: 'Live Voltage',),
                          Tab(text: 'Live Ampere',),
                          Tab(text: 'Live Temperature',),
                          Tab(text: 'Live P.F.',),
                          Tab(text: 'Live Grounding',),
                        ],
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      leading: IconButton(
                        icon: Icon(CupertinoIcons.back, color: Colors.black, size: 28),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    body: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ///Voltage
                        VoltageLiveComponent(),
                        ///Ampere
                        AmpereLiveComponent(),
                        ///Temp
                        TempLiveComponent(),
                        ///PF
                        PFLiveComponent(),
                        ///Grounding
                        GroundingLiveComponent()
                      ],
                    )
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

