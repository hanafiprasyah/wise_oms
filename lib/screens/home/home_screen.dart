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
        duration: const Duration(milliseconds: 1500)
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
                    extendBody: true,
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        color: MediaQuery.of(context).platformBrightness == Brightness.dark
                            ? Colors.black : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                                ? Colors.black.withOpacity(.1) : Colors.white.withOpacity(.1),
                          )
                        ],
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                          child: GNav(
                            rippleColor: Colors.grey[300]!,
                            hoverColor: Colors.grey[100]!,
                            gap: 8,
                            backgroundColor: Colors.transparent,
                            activeColor: MediaQuery.of(context).platformBrightness == Brightness.dark
                                ? Colors.black : Colors.white,
                            iconSize: 24,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            duration: Duration(milliseconds: 500),
                            tabBackgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark
                                ? Colors.white : Colors.black,
                            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                                ? Colors.grey[500] : Colors.black,
                            tabs: [
                              GButton(
                                icon: Ionicons.home_outline,
                                text: 'Home',
                              ),
                              GButton(
                                icon: Ionicons.analytics,
                                text: 'Quality',
                              ),
                              GButton(
                                icon: CupertinoIcons.bolt,
                                text: 'Usage',
                              ),
                              GButton(
                                icon: CupertinoIcons.settings,
                                text: 'Settings',
                              ),
                            ],
                            selectedIndex: _currentIndex,
                            onTabChange: _onTapNavbar,
                            textStyle: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark
                                ? Colors.black : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    body: Center(
                      child: _section.elementAt(_currentIndex),
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