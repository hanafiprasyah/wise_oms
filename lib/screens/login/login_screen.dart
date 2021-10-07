import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:wise_oms/core/navigation.dart';
import 'package:wise_oms/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool _visibleLogin = true;

  //Login Variables
  final _formKey = GlobalKey<FormState>();
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _indicatorLoading = false;
  void showIndicator(){
    setState(() {
      _indicatorLoading = true;
    });
  }
  void hideIndicator(){
    setState(() {
      _indicatorLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _visibleLogin = false;
  }

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (context) => Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SafeArea(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "Hello there,", style: TextStyle(
                                      fontSize: 28,
                                    ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: TextFormField(
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return 'Please enter your username';
                                      }
                                      return null;
                                    },
                                    controller: usernameTextController,
                                    textCapitalization: TextCapitalization.none,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(CupertinoIcons.person,color: Colors.black,),
                                      labelText: 'Username',
                                      labelStyle: TextStyle(color: Colors. black),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors. black)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: TextFormField(
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    controller: passwordTextController,
                                    textCapitalization: TextCapitalization.none,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                    ),
                                    obscureText: !_visibleLogin,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors. black,
                                      ),
                                      labelText: 'Password',
                                      icon: Icon(
                                          CupertinoIcons.lock,
                                          color: Colors.black),
                                      suffixIcon: IconButton(
                                        icon: Icon(_visibleLogin ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill,color: Colors.black,),
                                        onPressed: (){
                                          _togglePasswordLogin();
                                        },
                                      ),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors. black)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.2),
                                    animationDuration: Duration(milliseconds: 400),
                                    elevation: 8.0,
                                  ),
                                  onPressed: (){
                                    if(_formKey.currentState!.validate()) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      loginUser();
                                    };
                                  },
                                  child: Text('LOGIN', style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      letterSpacing: 2.0
                                  )),
                                ),
                                const SizedBox(height: 20,),
                                Visibility(
                                    maintainState: true,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    visible: _indicatorLoading,
                                    child: CupertinoActivityIndicator(animating: true)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
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

    void _togglePasswordLogin(){
    setState(() {
      _visibleLogin = !_visibleLogin;
    });
  }

    Future loginUser() async {
    showIndicator();

    String username = usernameTextController.text;
    String password = passwordTextController.text;

    // SERVER LOGIN API URL
    var url = Uri.parse('https://wiseoms.000webhostapp.com/api/login2.php');
    // Store all data with Param Name.
    var data = {'username': username, 'password' : password};
    // Starting Web API Call.
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var response = await http.post(url, body: json.encode(data),headers: headers);
    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    if(usernameTextController.text.isNotEmpty && passwordTextController.text.isNotEmpty) {
      if (message == 'Login Matched') {
        sendUserLogin();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message, style: TextStyle(
                  color: Colors.white
              ),),
              backgroundColor: Colors.black,
              duration: Duration(milliseconds: 800),
            )
        );
        hideIndicator();
      }
    }
    else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You are not the valid user!",style: TextStyle(
                  color: Colors.white
              ),),
              backgroundColor: Colors.black,
              duration: Duration(milliseconds: 1500),
            )
        );
        hideIndicator();
      }
    }

    void sendUserLogin() async {
      //Collect Login Token
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('login', usernameTextController.text.toString());
      //Navigate
      Future.delayed(Duration(seconds: 2)).whenComplete(() => hideIndicator());
      Future.delayed(Duration(seconds: 2)).whenComplete(() => navigateAndRemove(context, const HomeScreen()));
    }
}