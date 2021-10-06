import 'dart:async';
import 'dart:convert';

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
import 'package:http/http.dart' as http;

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
class _SettingContentState extends State<SettingContent> with TickerProviderStateMixin {
  bool isSwitched = false;

  // Future<bool> saveSwitchState(bool value) async {
  //   SharedPreferences prefFinger = await SharedPreferences.getInstance();
  //   prefFinger.setBool('biometric', value);
  //   return prefFinger.setBool('biometric', value);
  // }
  // getSwitchValue() async {
  //   isSwitched = await getSwitchState();
  //   setState(() {});
  // }
  // Future<bool> getSwitchState() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   bool isSwitched = pref.getBool("biometric")!;
  //   return isSwitched;
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getSwitchValue();
  // }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      physics: BouncingScrollPhysics(),
      darkBackgroundColor: Colors.grey.shade800,
      lightBackgroundColor: Colors.white,
      sections: [
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
                setState(() {});
                showDialog(
                    barrierDismissible: true,
                    barrierColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return GestureDetector(
                        onTap: (){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: AlertDialog(
                          elevation: 4.0,
                          titlePadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                          backgroundColor: Colors.white,
                          title: Text('Contact Us',textAlign: TextAlign.center,),
                          scrollable: true,
                          contentPadding: EdgeInsets.all(20.0),
                          content: DialogContent(),
                        ),
                      );
                    }
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class DialogContent extends StatefulWidget {
  const DialogContent({Key? key}) : super(key: key);

  @override
  _DialogContentState createState() => _DialogContentState();
}
class _DialogContentState extends State<DialogContent> {
  final _formKeyMsg = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final msgController = TextEditingController();
  final maxLines = 5;
  bool? error,sending,success;
  String? msg;
  int _state = 0;

  Future<List?> sendMsg() async {
    final response = await http.post(Uri.parse("https://wiseoms.000webhostapp.com/api/insertComment.php"),body: {
      "email": emailController.text,
      "msg": msgController.text,
    });

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      if(data["error"]){
        setState(() {
          sending = false;
          error = true;
          _state = 3;
          msg = data["message"];//from server
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$msg'),
          ));
        });
      } else {
        emailController.text = "";
        msgController.text = "";
        setState(() {
          sending = false;
          success = true;
          _state = 2;
          Timer(Duration(milliseconds: 500), () {
            setState(() {
              Navigator.pop(context);
            });
          });
        });
      }
    } else {
      setState(() {
        sending = false;
        error = true;
        msg = "Error during send data";
        _state = 3;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";
  }

  @override
  void dispose() {
    emailController.dispose();
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKeyMsg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Please enter your e-mail';
                  }
                  return value.isValidEmail() ? null : 'Check your email!';
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
                      CupertinoIcons.envelope_open_fill,
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
                        CupertinoIcons.pencil,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
          child: buttonChild(),
          onPressed: (){
            if(_formKeyMsg.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                if(_state == 0){
                  setState(() {
                    _state = 1;
                  });
                }
              });
              sendMsg();
              setState(() {
                sending = true;
              });
            }
          },
          elevation: 4.0,
          color: Colors.white,
        )
      ],
    );
  }

  Widget buttonChild(){
    if (_state == 0) {
      return Text(
        "Send",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      );
    } else if (_state == 2) {
      return Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.green);
    } else {
      return Icon(CupertinoIcons.xmark_circle_fill, color: Colors.red);
    }
  }

  // Widget successedGreeting(){
  //   return Container(
  //     height: MediaQuery.of(context).size.height*0.4,
  //     child: Column(
  //       children: [
  //         Icon(CupertinoIcons.checkmark_seal_fill,color: Colors.green,size: 48,),
  //         SizedBox(height: 10,),
  //         Text('Kami sudah menerima pesan anda. Kami akan kirim balasan pesan anda ke email yang anda berikan dalam jam kerja kurang dari 1x24 jam.')
  //       ],
  //     ),
  //   );
  // }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}