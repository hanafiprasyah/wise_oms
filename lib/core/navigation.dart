import 'package:flutter/material.dart';

void navigateReplace(BuildContext context, Widget screen) {
  Navigator.of(context).pushReplacement(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 550),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return screen;
    },
  ));
}

void navigateAndRemove(BuildContext context, Widget screen){
  Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 550),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return screen;
    },
  ),(route) => false);
}

void navigateTo(BuildContext context, Widget screen) {
  Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 550),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return screen;
    },
  ));
}