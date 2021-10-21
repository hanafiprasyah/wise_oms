import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:wise_oms/core/navigation.dart';
import 'package:wise_oms/screens/login/forgot_password.dart';
import 'package:wise_oms/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool _visibleLogin = true;
  int activeIndex = 0;

  //Anim
  late final AnimationController _animationController;
  //Animation for 1nd list
  late final Animation<double> _form;
  //Animation for 2rd list
  late final Animation<double> _button;
  //Animation for 3rd list
  late final Animation<double> _textForgot;
  //Animation for SVG
  late final Animation<double> _svg;

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

    Timer.periodic(Duration(seconds: 5), (timer) {
      if(this.mounted){
        setState(() {
          activeIndex++;
          if(activeIndex == 3){
            activeIndex = 0;
          }
        });
      }
    });

    //Anim
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _svg = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );

    _form = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );

    _textForgot = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
      ),
    );

    _button = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
      ),
    );

    Timer(Duration(milliseconds: 250), () {_animationController.forward();});
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: GestureDetector(
                      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                      child: SafeArea(
                        child: Container(
                          color: Colors.white,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                FadeTransition(
                                  opacity: _svg,
                                  child: Container(
                                    height: 300,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedOpacity(
                                            opacity: activeIndex == 0 ? 1 : 0,
                                            duration: Duration(milliseconds: 800),
                                            curve: Curves.fastOutSlowIn,
                                            child: SvgPicture.asset('assets/images/slide1.svg'),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedOpacity(
                                            opacity: activeIndex == 1 ? 1 : 0,
                                            duration: Duration(milliseconds: 800),
                                            curve: Curves.fastOutSlowIn,
                                            child: SvgPicture.asset('assets/images/slide2.svg'),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedOpacity(
                                            opacity: activeIndex == 2 ? 1 : 0,
                                            duration: Duration(milliseconds: 800),
                                            curve: Curves.fastOutSlowIn,
                                            child: SvgPicture.asset('assets/images/slide3.svg'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FadeTransition(
                                  opacity: _svg,
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedOpacity(
                                            opacity: activeIndex == 0 ? 1 : 0,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.easeIn,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                                    child: Text(
                                                      'All data from sensors will be stored on the server and encrypted using SHA-2.',
                                                      textAlign: TextAlign.center,)
                                                )
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedOpacity(
                                            opacity: activeIndex == 1 ? 1 : 0,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.easeIn,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                                    child: Text('The data we display is in the form of statistical data.',textAlign: TextAlign.center,)
                                                )
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedOpacity(
                                            opacity: activeIndex == 2 ? 1 : 0,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.easeIn,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                                    child: Text('Exported log data is encrypted by end-to-end.',textAlign: TextAlign.center,)
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                //Form-----------------------------------
                                FadeTransition(
                                  opacity: _form,
                                  child: Padding(
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
                                ),
                                const SizedBox(height: 16,),
                                FadeTransition(
                                  opacity: _form,
                                  child: Padding(
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
                                ),
                                //---------------------------------------
                                FadeTransition(
                                  opacity: _textForgot,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: TextButton(
                                        style: ButtonStyle(
                                            visualDensity: VisualDensity.comfortable
                                        ),
                                        onPressed: (){
                                          navigateTo(context, ForgotPasswordScreen());
                                        },
                                        child: Text(
                                          "Forgot password", style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                FadeTransition(
                                  opacity: _button,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.3),
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
                                ),
                                const SizedBox(height: 20,),
                                Visibility(
                                    maintainState: true,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    visible: _indicatorLoading,
                                    child: CupertinoActivityIndicator()
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
      Future.delayed(Duration(milliseconds: 1800)).whenComplete(() => hideIndicator());
      Future.delayed(Duration(milliseconds: 2000)).whenComplete(() => navigateAndRemove(context, const HomeScreen()));
    }
}