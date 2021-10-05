import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:badges/badges.dart';
import 'package:wise_oms/screens/manual_user.dart';
import 'package:wise_oms/screens/notification/notif_screen.dart';
import 'package:wise_oms/screens/tips_trik.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}
class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: true,
                    leading: Badge(
                      position: BadgePosition.topEnd(top: 5, end: 5),
                      badgeContent: Text('0',style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? Colors.black : Colors.white),),
                      animationType: BadgeAnimationType.scale,
                      showBadge: true,
                      toAnimate: true,
                      badgeColor: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? Colors.white : Colors.black,
                      child: IconButton(
                        icon: Icon(Ionicons.notifications_outline, color: MediaQuery.of(context).platformBrightness == Brightness.dark
                            ? Colors.white : Colors.black,),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => const NotificationScreen()
                          ));
                        },
                      ),
                    ),
                    title: Text(GreetingToUser.showGreetings(),style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.white : Colors.black
                    ),),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Hero(
                            tag: 'wiselogo',
                            child: Image.asset('assets/images/logowise.png',width: 32,height: 32)
                        ),
                      ),
                    ],
                    bottomOpacity: 0,
                    elevation: 0,
                    centerTitle: true,
                    titleTextStyle: TextStyle(fontSize: 18),
                  ),
                  body: const HomeContent(),
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

class GreetingToUser {
  static String showGreetings() {
    String greeting() {
      var timeNow = DateTime.now().hour;
      if (timeNow <= 12) {
        return 'Good Morning';
      } else if ((timeNow > 12) && (timeNow <= 16)) {
        return 'Good Afternoon';
      } else if ((timeNow > 16) && (timeNow <= 20)) {
        return 'Good Evening';
      } else {
        return 'Good Night';
      }
    }

    return greeting();
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}
class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  AnimationController ?_controller;
  Animation<double> ?_fadeAnimationOne;
  Animation<double> ?_fadeAnimationTwo;
  Animation<Offset> ?_slideAnimationBoxOne;
  Animation<Offset> ?_slideAnimationBoxTwo;
  Animation<Offset> ?_slideAnimationBoxThree;

  //PageView Content
  List<Widget> _pages = [];
  final PageController _pageController1 = PageController(initialPage: 0);
  double? currentPageValue = 0;

  @override
  void initState() {
    _pages = [
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => TipsTrik()
          ));
        },
        child: Card(
          child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/images/bglampu.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center
              )
          ),
            child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Tips & Trick",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
    ),
      ),
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (_) => CaraPenggunaan()
          ));
        },
        child: Card(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage("assets/images/papanhitam.jpg"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center
                )
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "How to?",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      )
    ];

    _pageController1.addListener(() {
      setState(() {
        currentPageValue = _pageController1.page!;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );

    //initialising the animation
    _fadeAnimationOne = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ));
    //initialising the animation
    _fadeAnimationTwo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _controller!,
        //delay
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeOut,
        ),
      ));
    //initialising the animation 1
    _slideAnimationBoxOne = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.1),
    ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
      ));
    //initialising the animation 2
    _slideAnimationBoxTwo = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
        parent: _controller!,
        //delay
        curve: const Interval(
          0.2,
          1.0,
          curve: Curves.easeOut,
        ),
      ));
    //initialising the animation
    _slideAnimationBoxThree = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
        parent: _controller!,
        //delay
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeOut,
        ),
      ));
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //centered container
        heightFactor: 1,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Content 1
                SlideTransition(
                  position: _slideAnimationBoxOne!,
                  child: FadeTransition(
                    opacity: _fadeAnimationOne!,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent
                      ),
                      child: Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true,
                            physics: BouncingScrollPhysics(),
                            controller: _pageController1,
                            itemCount: _pages.length,
                            itemBuilder: (context, index){
                              return Transform(
                                  transform: Matrix4.identity()..rotateX(currentPageValue!-index),
                                  child: _pages[index % _pages.length]
                              );
                            },
                            // children: [
                            //   //A
                            //   SlideTransition(
                            //     position: _slideAnimationBoxOne!,
                            //     child: FadeTransition(
                            //       opacity: _fadeAnimationOne!,
                            //       child: Container(
                            //         width: MediaQuery.of(context).size.width,
                            //         height: 100,
                            //         child: const Center(child: Text("Content A")),
                            //       ),
                            //     ),
                            //   ),
                            //   //B
                            //   SlideTransition(
                            //     position: _slideAnimationBoxOne!,
                            //     child: FadeTransition(
                            //       opacity: _fadeAnimationOne!,
                            //       child: Container(
                            //         width: MediaQuery.of(context).size.width,
                            //         height: 100,
                            //         child: const Center(child: Text("Content B")),
                            //       ),
                            //     ),
                            //   ),
                            //   //C
                            //   SlideTransition(
                            //     position: _slideAnimationBoxOne!,
                            //     child: FadeTransition(
                            //       opacity: _fadeAnimationOne!,
                            //       child: Container(
                            //         width: MediaQuery.of(context).size.width,
                            //         height: 100,
                            //         child: const Center(child: Text("Content C")),
                            //       ),
                            //     ),
                            //   ),
                            // ],
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              color: Colors.grey[800]!.withOpacity(0.5),
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                  child: SmoothPageIndicator(
                                    controller: _pageController1,
                                    axisDirection: Axis.horizontal,
                                    count: 2,
                                    effect: JumpingDotEffect(
                                      spacing: 16.0,
                                      activeDotColor: Colors.white,
                                      dotHeight: 2,
                                      dotWidth: 20,
                                      jumpScale: .2,
                                      verticalOffset: 1,
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                //Content 2
                SlideTransition(
                  position: _slideAnimationBoxTwo!,
                  child: FadeTransition(
                    opacity: _fadeAnimationOne!,
                    child: Container(color: Colors.greenAccent,height: 100,width: MediaQuery.of(context).size.width,)
                  ),
                ),
                const SizedBox(height: 20),
                //Content 3
                SlideTransition(
                  position: _slideAnimationBoxThree!,
                  child: FadeTransition(
                    opacity: _fadeAnimationTwo!,
                    child: Container(color: Colors.greenAccent,height: 100,width: MediaQuery.of(context).size.width,)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


