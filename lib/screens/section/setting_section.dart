import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:wise_oms/core/navigation.dart';
import 'package:wise_oms/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise_oms/screens/splash/splash_screen.dart';

class SettingSection extends StatefulWidget {
  const SettingSection({Key? key}) : super(key: key);

  @override
  _SettingSectionState createState() => _SettingSectionState();
}
class _SettingSectionState extends State<SettingSection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    title: Text('SETTINGS'),
                    bottomOpacity: 0,
                    elevation: 0,
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                  ),
                  body: const SettingContent(),
                )
            );
          }
          return Container();
        }
    );
  }
}

class SettingContent extends StatefulWidget {
  const SettingContent({Key? key}) : super(key: key);

  @override
  _SettingContentState createState() => _SettingContentState();
}
class _SettingContentState extends State<SettingContent> {
  bool isSwitched = false;

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefFinger = await SharedPreferences.getInstance();
    prefFinger.setBool('biometric', value);
    return prefFinger.setBool('biometric', value);
  }

  getSwitchValue() async {
    isSwitched = await getSwitchState();
    setState(() {});
  }

  Future<bool> getSwitchState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isSwitched = pref.getBool("biometric")!;
    return isSwitched;
  }

  @override
  void initState() {
    super.initState();
    getSwitchValue();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      physics: BouncingScrollPhysics(),
      darkBackgroundColor: Colors.grey.shade800,
      lightBackgroundColor: Colors.white,
      sections: [
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: 'Privacy',
          tiles: [
            SettingsTile.switchTile(
              title: 'Fingerprint',
              subtitle: 'Using yours biometric for some Act',
              subtitleTextStyle: TextStyle(fontSize: 10),
              leading: Icon(Ionicons.finger_print),
              switchValue: isSwitched,
              onToggle: (value) {
                setState(() {
                  isSwitched = value;
                  saveSwitchState(value);
                });
              },
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: 'General',
          tiles: [
            SettingsTile(
              title: 'About Us',
              leading: Icon(Ionicons.people_circle_sharp),
              onPressed: (BuildContext context) {
                navigateTo(context, SplashScreen());
              },
            ),
            SettingsTile(
              title: 'Logout',
              leading: Icon(CupertinoIcons.square_arrow_right),
              onPressed: (BuildContext context) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    confirmBtnText: 'Yes',
                    onConfirmBtnTap: () async {
                      final SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.remove('login');
                      // await pref.clear();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) => const LoginScreen()
                      ), (route) => false);
                    },
                    confirmBtnColor: Colors.redAccent,
                    cancelBtnText: 'No',
                    barrierDismissible: false,
                    title: 'Are you sure?',
                    animType: CoolAlertAnimType.scale,
                    backgroundColor: Colors.transparent,

                );
              },
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: 'Keep In Touch',
          tiles: [
            SettingsTile(
              title: 'Contact Us',
              leading: Icon(CupertinoIcons.mail_solid),
              onPressed: (BuildContext context) {
                _contactContentDialog(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

Future<void> _contactContentDialog(BuildContext context) async {
  final _formKeyMsg = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final msgController = TextEditingController();
  final maxLines = 5;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('What is your problem(s)?'),
          scrollable: true,
          contentPadding: EdgeInsets.all(20.0),
          content: Form(
            key: _formKeyMsg,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter your e-mail';
                    }
                    return null;
                  },
                  controller: emailController,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  showCursor: true,
                  scrollPhysics: BouncingScrollPhysics(),
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      fontSize: 12
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black,
                    ),
                    labelText: 'Your email',
                    icon: Icon(
                        CupertinoIcons.forward,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black)),
                  ),
                ),
                Container(
                  height: maxLines * 24.0,
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    maxLines: maxLines * 2,
                    controller: msgController,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    showCursor: true,
                    scrollPhysics: BouncingScrollPhysics(),
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black,
                      ),
                      labelText: 'Your text',
                      icon: Icon(
                          CupertinoIcons.forward,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).scaffoldBackgroundColor,
                elevation: 4.0,
                textStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey.shade800),
              ),
              icon: Icon(
                CupertinoIcons.arrow_right_circle_fill,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey.shade800,
              ),
              onPressed: (){
                if(_formKeyMsg.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              label: Text('Send', style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey.shade800),),
            ),
          ],
        );
      }
  );
}
