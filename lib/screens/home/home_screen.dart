import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wise_oms/screens/section/home_section.dart';
import 'package:wise_oms/screens/section/quality_section.dart';
import 'package:wise_oms/screens/section/setting_section.dart';
import 'package:wise_oms/screens/section/usage_section.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getCredential();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );
    _animationController.forward();
  }

  getCredential() async {
    //User Logged Credential
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.getString('login');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapNavbar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  static final List<Widget> _section = <Widget>[
    const HomeSection(),
    const QualitySection(),
    const UsageSection(),
    const SettingSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                    bottomNavigationBar: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: GNav(
                          hoverColor: Colors.white,
                          gap: 10,
                          backgroundColor: Colors.white,
                          activeColor: Colors.black,
                          iconSize: 24,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          duration: Duration(milliseconds: 500),
                          tabBackgroundColor: Colors.white,
                          color: Colors.black,
                          tabs: [
                            GButton(
                              icon: Ionicons.home_outline,
                              text: 'Home',
                              textColor: Colors.black,
                              // iconActiveColor: Colors.black,
                            ),
                            GButton(
                              icon: Ionicons.analytics,
                              text: 'Quality',
                              textColor: Colors.black,
                              // iconActiveColor: Colors.black,
                            ),
                            GButton(
                              icon: CupertinoIcons.bolt,
                              text: 'Usage',
                              textColor: Colors.black,
                              // iconActiveColor: Colors.black,
                            ),
                            GButton(
                              icon: CupertinoIcons.settings,
                              text: 'Settings',
                              textColor: Colors.black,
                              // iconActiveColor: Colors.black,
                            ),
                          ],
                          selectedIndex: _currentIndex,
                          onTabChange: _onTapNavbar,
                        ),
                      ),
                    ),
                    body: _section.elementAt(_currentIndex),
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