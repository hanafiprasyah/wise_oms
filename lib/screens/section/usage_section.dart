import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wise_oms/constant.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:wise_oms/main.dart';
import 'package:badges/badges.dart';

class UsageSection extends StatefulWidget {
  const UsageSection({Key? key}) : super(key: key);

  @override
  _UsageSectionState createState() => _UsageSectionState();
}

class _UsageSectionState extends State<UsageSection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: true,
                    title: Text('USAGE',style: const TextStyle(
                        fontFamily: 'Poppins'
                    ),),
                    bottomOpacity: 0,
                    elevation: 0,
                    centerTitle: true,
                    titleTextStyle: TextStyle(fontSize: 18),

                  ),
                  body: const UsageContent(),
                )
            );
          }
          return Container();
        }
    );
  }
}

class UsageContent extends StatefulWidget {
  const UsageContent({Key? key}) : super(key: key);

  @override
  _UsageContentState createState() => _UsageContentState();
}
class _UsageContentState extends State<UsageContent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
