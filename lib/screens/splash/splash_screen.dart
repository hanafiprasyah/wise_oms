import 'dart:async';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wise_oms/constant.dart';
import 'package:wise_oms/core/navigation.dart';
import 'package:flutter/painting.dart';
import 'package:wise_oms/screens/about/about_screen.dart';
import 'package:wise_oms/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Color?> _colorAnimation;
  late final Animation<double> _nameAnimation;
  late final Animation<double> _logoAnimation;
  late final Animation<double> _quoteAnimation;
  late final Animation<double> _companyNameAnimation;

  @override
  void initState() {
    super.initState();
    //Controller Initializer
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 3000)
    );
    _colorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0),
      end: Colors.black.withOpacity(0.8),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.1, 0.4, curve: Curves.easeInOut),
    ));
    _nameAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.4, 0.7, curve: Curves.easeIn)
        )
    );
    _quoteAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.7, 1, curve: Curves.easeIn)
        )
    );
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.6, 1, curve: Curves.bounceIn)
        )
    );
    _companyNameAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.6, 1, curve: Curves.bounceIn)
        )
    );

    //start animation
    _animationController.forward();
    _animationController.addStatusListener((status) async{
      if(status == AnimationStatus.completed){
        await Future.delayed(const Duration(milliseconds: 1000));
        scheduleMicrotask((){navigateReplace(context, const AboutScreen());});
      }
    });
  }

  @override
  void dispose() {
    _animationController.removeStatusListener((_) {});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Responsive UI
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
              portrait: (context) => Scaffold(
                body: Stack(
                  children: [
                    //layout background
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/bgsplash.jpg'),
                            fit: BoxFit.fill,
                          )
                      ),
                      //BlackOverlay Animation
                      child: AnimatedBuilder(
                          animation: _colorAnimation,
                          builder: (BuildContext context, Widget? child){
                            return Container(
                              color: _colorAnimation.value,
                            );
                          }
                      ),
                    ),
                    //Title
                    Hero(
                      tag: 'wise',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Align(
                          child: FadeTransition(
                            opacity: _nameAnimation,
                            child: const Text(
                              'WISE',
                              style: kLargeTitle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Logo Perusahaan
                    Hero(
                      tag: 'wiselogo',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: FadeTransition(
                                opacity: _logoAnimation,
                                child: Image.asset('assets/images/logowise.png',width: 32,height: 32,)
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Nama Perusahaan
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: FadeTransition(
                          opacity: _companyNameAnimation,
                          child: const Text(
                            'PT. WIBAWA SOLUSI ELEKTRIK',
                            style: kQuote,
                          ),
                        ),
                      ),
                    ),
                    //Quote
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: FadeTransition(
                          opacity: _quoteAnimation,
                          child: const Text(
                            'WE BRING THE ELECTRICITY SOLUTION',
                            style: kQuote,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              landscape: (context) => const Scaffold(),
            );
          }
          return Container();
        }
    );
  }
}