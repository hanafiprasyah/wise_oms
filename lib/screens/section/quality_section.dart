import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wise_oms/component/qualitySection/live_panel.dart';
import 'package:wise_oms/component/qualitySection/voltage_content.dart';

class QualitySection extends StatefulWidget {
  const QualitySection({Key? key}) : super(key: key);

  @override
  _QualitySectionState createState() => _QualitySectionState();
}
class _QualitySectionState extends State<QualitySection> {
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     isLivePanel = !isLivePanel;
  //   });
  // }

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
                    leadingWidth: MediaQuery.of(context).size.width,
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton.icon(
                        icon: Icon(CupertinoIcons.arrow_2_circlepath,color: Colors.white),
                        onPressed: (){
                          setState(() {});
                        },
                        label: Text('Refresh',style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          )
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: LeadingContent()
                      )
                    ],
                  ),
                  body: PageView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      LivePanel(),
                      Voltage()
                      // PowerFactor(),
                      // Grounding(),
                    ],
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
        icon: Icon(CupertinoIcons.bars,
          color: Colors.black,
        ),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(fontSize: 12,
            color: Colors.black),
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