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
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text('Notification'),
                    centerTitle: true,
                    bottomOpacity: 0.0,
                    leading: IconButton(
                      icon: Icon(CupertinoIcons.back,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          size: 32),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    titleTextStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 5.0,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    ),
                  ),
                  body: const NotifContent(),
                )
            );
          }
          return Container();
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
