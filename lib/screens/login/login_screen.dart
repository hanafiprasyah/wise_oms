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
  Animation<double> ?containerSize;
  AnimationController ?animationController;
  Duration animDuration = const Duration(milliseconds: 1500);
  bool _visibleLogin = true;
  Animation<double> ?_fadeAnimationOne;
  Animation<double> ?_fadeAnimationTwo;
  // Animation<Offset> ?_slideAnimationUsername;
  // Animation<Offset> ?_slideAnimationPassword;
  // Animation<Offset> ?_slideAnimationButton;

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
    animationController = AnimationController(vsync: this, duration: animDuration, animationBehavior: AnimationBehavior.normal);
    _visibleLogin = false;

    //InitialAnimation
    //initialising the animation
    _fadeAnimationOne = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.fastOutSlowIn,
    ));
    //initialising the animation
    _fadeAnimationTwo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController!,
      //delay
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    //initialising the animation 1
    // _slideAnimationUsername = Tween<Offset>(
    //   begin: const Offset(0.0, 0.0),
    //   end: const Offset(0.0, 1.0),
    // ).animate(CurvedAnimation(
    //   parent: animationController!,
    //   reverseCurve: Curves.fastOutSlowIn,
    //   curve: Curves.easeOut,
    // ));
    // //initialising the animation 2
    // _slideAnimationPassword = Tween<Offset>(
    //   begin: const Offset(0.0, 0.0),
    //   end: const Offset(0.0, 1.0),
    // ).animate(CurvedAnimation(
    //   parent: animationController!,
    //   reverseCurve: Curves.fastOutSlowIn,
    //   //delay
    //   curve: const Interval(
    //     0.2,
    //     1.0,
    //     curve: Curves.easeOut,
    //   ),
    // ));
    // //initialising the animation
    // _slideAnimationButton = Tween<Offset>(
    //   begin: const Offset(0.0, 0.0),
    //   end: const Offset(0.0, 1.0),
    // ).animate(CurvedAnimation(
    //   parent: animationController!,
    //   reverseCurve: Curves.fastOutSlowIn,
    //   //delay
    //   curve: const Interval(
    //     0.5,
    //     1.0,
    //     curve: Curves.easeOut,
    //   ),
    // ));

    //Start the animation
    animationController!.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController!.dispose();
    usernameTextController.dispose();
    passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizer = MediaQuery.of(context).size;
    double defaultLoginSize = sizer.height - (sizer.height * 0.3);

    // double defaultRegisterSize = sizer.height - (sizer.height * 0.1);
    // containerSize = Tween<double>(begin: sizer.height * 0.1, end: defaultRegisterSize).animate(CurvedAnimation(
    //     parent: animationController!,
    //     curve: Curves.linear)
    // );

    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (context) => Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: GestureDetector(
                          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              height: defaultLoginSize,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SvgPicture.asset(Theme.of(context).brightness == Brightness.dark
                                  //     ? 'assets/images/programmingdark.svg'
                                  //     : 'assets/images/programming.svg',
                                  //   width: 142,
                                  //   height: 142,
                                  //   fit: BoxFit.cover,),
                                  // const SizedBox(height: 10,),
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
                                  //InputUsername
                                  FadeTransition(
                                      opacity: _fadeAnimationOne!,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 40),
                                        child: TextFormField(
                                          validator: (value) {
                                            if(value!.isEmpty){
                                              return 'Please input your username';
                                            }
                                            return null;
                                          },
                                          controller: usernameTextController,
                                          enableSuggestions: false,
                                          textCapitalization: TextCapitalization.none,
                                          showCursor: true,
                                          scrollPhysics: BouncingScrollPhysics(),
                                          style: TextStyle(
                                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                              fontSize: 14
                                          ),
                                          decoration: InputDecoration(
                                            icon: Icon(CupertinoIcons.person,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
                                            labelText: 'Username',
                                            labelStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black),
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black)),
                                          ),
                                        ),
                                      )
                                  ),
                                  const SizedBox(height: 16,),
                                  //InputPassword
                                  FadeTransition(
                                    opacity: _fadeAnimationOne!,
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
                                        enableSuggestions: false,
                                        textCapitalization: TextCapitalization.none,
                                        showCursor: true,
                                        scrollPhysics: BouncingScrollPhysics(),
                                        style: TextStyle(
                                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                            fontSize: 14
                                        ),
                                        obscureText: !_visibleLogin,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black,
                                          ),
                                          labelText: 'Password',
                                          icon: Icon(
                                              CupertinoIcons.lock,
                                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                          suffixIcon: IconButton(
                                            icon: Icon(_visibleLogin ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,),
                                            onPressed: (){
                                              _togglePasswordLogin();
                                            },
                                          ),
                                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors. black)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FadeTransition(
                                          opacity: _fadeAnimationTwo!,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: MediaQuery.of(context).platformBrightness == Brightness.dark
                                                  ? Colors.white : Colors.black,
                                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.1),
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
                                                letterSpacing: 4.0,
                                                fontSize: 16
                                            )),
                                          )
                                      ),
                                      Visibility(
                                          maintainState: true,
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          visible: _indicatorLoading,
                                          child: CupertinoActivityIndicator(animating: true)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                  // Stack(
                  //   children: [
                  //     //Ball Decoration
                  //     // Positioned(
                  //     //     top: -100,
                  //     //     left: -5,
                  //     //     right: 10,
                  //     //     bottom: 200,
                  //     //     child: Container(
                  //     //       width: MediaQuery.of(context).size.width,
                  //     //       height: 150,
                  //     //       decoration: BoxDecoration(
                  //     //         borderRadius: BorderRadius.circular(100),
                  //     //         color: Colors.transparent,
                  //     //         image: DecorationImage(
                  //     //             image: AssetImage("assets/images/logowise.png"),
                  //     //             alignment: Alignment.center,scale: 8.0
                  //     //         ),
                  //     //       ),
                  //     //     )
                  //     // ),
                  //     //CancelButton
                  //     // AnimatedOpacity(
                  //     //   opacity: isLogin ? 0.0 : 1.0,
                  //     //   duration: animDuration,
                  //     //   child: Align(
                  //     //     alignment: Alignment.topCenter,
                  //     //     child: Container(
                  //     //       width: sizer.width * 0.5,
                  //     //       height: sizer.height * 0.2,
                  //     //       alignment: Alignment.center,
                  //     //       child: IconButton(
                  //     //         icon: Icon(Ionicons.close_circle_outline, size: 32,color: kWhiteJapan,),
                  //     //         onPressed: isLogin ? null : (){
                  //     //           animationController!.reverse();
                  //     //           setState(() {
                  //     //             isLogin = !isLogin;
                  //     //           });
                  //     //         },
                  //     //         color: kWhiteJapan,
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     //Login Form
                  //
                  //     //Register Container
                  //     // AnimatedBuilder(
                  //     //   animation: animationController!,
                  //     //   builder: (context, child){
                  //     //     if(viewInset == 0 && isLogin){
                  //     //       return buildRegisterContainer();
                  //     //     } else if (!isLogin){
                  //     //       return buildRegisterContainer();
                  //     //     }
                  //     //     //Null empty widget
                  //     //     return Container();
                  //     //   },
                  //     // ),
                  //     //RegisterForm-Animated
                  //     // AnimatedOpacity(
                  //     //   opacity: isLogin ? 0.0 : 1.0,
                  //     //   duration: animDuration,
                  //     //   child: Visibility(
                  //     //     visible: !isLogin,
                  //     //     child: Align(
                  //     //       alignment: Alignment.center,
                  //     //       child: SingleChildScrollView(
                  //     //         physics: const BouncingScrollPhysics(),
                  //     //         child: GestureDetector(
                  //     //           onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  //     //           child: Container(
                  //     //             color: Colors.transparent,
                  //     //             height: defaultLoginSize * 0.8,
                  //     //             child: Column(
                  //     //               crossAxisAlignment: CrossAxisAlignment.center,
                  //     //               mainAxisAlignment: MainAxisAlignment.start,
                  //     //               children: [
                  //     //                 SvgPicture.asset('assets/images/bug.svg',width: 150,height: 150),
                  //     //                 SizedBox(height: 30,),
                  //     //                 const RoundedInput(icon: Ionicons.arrow_forward_circle_outline, hint: 'Your name?',color: Colors.white,inputType: TextInputType.text,),
                  //     //                 const SizedBox(height: 10,),
                  //     //                 const RoundedInput(icon: Ionicons.arrow_forward_circle_outline, hint: 'Kind of bug or error? Tell us',color: Colors.white,inputType: TextInputType.text),
                  //     //                 const SizedBox(height: 10,),
                  //     //                 RoundedButton(title: "SEND",color: kSoftBlueJapan,textStyle: TextStyle(color: kWhiteJapan,fontSize: 18, fontFamily: 'Montserrat'),),
                  //     //               ],
                  //     //             ),
                  //     //           ),
                  //     //         ),
                  //     //       ),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
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

  // Widget buildRegisterContainer(){
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Container(
  //       height: containerSize!.value * 0.8,
  //       decoration: BoxDecoration(
  //           borderRadius: const BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(100)),
  //           color: kHardBlueJapan
  //       ),
  //       alignment: Alignment.center,
  //       child: GestureDetector(
  //         onTap: !isLogin ? null : (){
  //           setState(() {
  //             animationController!.forward();
  //             isLogin = !isLogin;
  //           });
  //         },
  //         child: isLogin
  //             ?
  //         footerLoginScreen() : null,
  //       ),
  //     ),
  //   );
  // }
  // Widget footerLoginScreen(){
  //   return Hero(
  //     tag: 'wiselogo',
  //     child: Material(
  //       type: MaterialType.transparency,
  //       child: Align(
  //         alignment: Alignment.topCenter,
  //         child: Center(
  //           child: Text('Find any bugs or error?', style: TextStyle(
  //               fontFamily: 'Montserrat',
  //               color: kWhiteJapan
  //           ),),
  //         )
  //       ),
  //     ),
  //   );
  // }
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

    // //update status pakai
    // int id_user = message[0]['id'];
    // final responsed = await http.post(Uri.parse('https://wiseoms.000webhostapp.com/api/edit_status_login.php'),
    //     body: {
    //       "id": id_user
    //     });
    // var status = jsonDecode(responsed.body);
    // int value = status['value'];
    // String pesan = status['message'];
    // if(value == 1 || pesan == 'Update'){
    //   sendUserLogin();
    // }

    if(usernameTextController.text.isNotEmpty && passwordTextController.text.isNotEmpty) {
      if (message == 'Login Matched') {
        sendUserLogin();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message, style: TextStyle(
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark ? Colors.black : Colors
                      .white
              ),),
              backgroundColor: Theme
                  .of(context)
                  .brightness == Brightness.dark ? Colors.white : Colors.black,
              duration: Duration(milliseconds: 800),
            )
        );
        hideIndicator();
      }
    }
      // final response = await http.post(Uri.parse("https://wiseoms.000webhostapp.com/api/login.php"),
      //     body: ({
      //       "username" : usernameTextController.text,
      //       "password" : passwordTextController.text
      //     }));
      // final body = jsonDecode(response.body);
      // if(response.statusCode == 200){
      //   if(passwordTextController.text != body['password'].hashCode.toInt()){
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text("Password is wrong!",style: TextStyle(
      //               color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
      //           ),),
      //           backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      //           duration: Duration(milliseconds: 800),
      //         )
      //     );
      //     hideIndicator();
      //   } else {
      //     //Collect Login Token
      //     SharedPreferences pref = await SharedPreferences.getInstance();
      //     await pref.setString("login", body[0]['token']);
      //     //Navigate
      //     Future.delayed(Duration(seconds: 2)).whenComplete(() => hideIndicator());
      //     Future.delayed(Duration(seconds: 2)).whenComplete(() => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false));
      //   }
      //   // if (body[0]['level'] == 'admin') {
      //   //   Future.delayed(Duration(seconds: 2)).whenComplete(() => hideIndicator());
      //   //   Future.delayed(Duration(seconds: 2)).whenComplete(() => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false));
      //   // }
      //   // else if (body[0]['level'] == 'member') {
      //   //   Future.delayed(Duration(seconds: 2)).whenComplete(() => hideIndicator());
      //   //   Future.delayed(Duration(seconds: 2)).whenComplete(() => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false));
      //   // }
      // }
    else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You are not the valid user!",style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white
              ),),
              backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
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