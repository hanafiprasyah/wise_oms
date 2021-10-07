import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
                    title: Text('Notification'),
                    centerTitle: true,
                    bottomOpacity: 0.0,
                    leading: IconButton(
                      icon: Icon(CupertinoIcons.back, color: Colors.black, size: 28),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    titleTextStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                        letterSpacing: 4.0,
                        color: Colors.black
                    ),
                  ),
                  body: const NotifContent(),
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

class NotifContent extends StatefulWidget {
  const NotifContent({Key? key}) : super(key: key);

  @override
  _NotifContentState createState() => _NotifContentState();
}
class _NotifContentState extends State<NotifContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("You do not have any notification yet", style: TextStyle(
        fontSize: 16,
      ),),
    );
  }
}
