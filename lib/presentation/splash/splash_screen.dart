import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:diresto/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/resto.png'),
      nextScreen: const HomeScreen(),
      splashIconSize: 150,
      duration: 2000,
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
