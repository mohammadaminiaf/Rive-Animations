import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import '/screens/bird_animation_screen.dart';
import '/screens/change_theme_screen.dart';
import '/screens/dog_animation_screen.dart';
import '/screens/login_screen_animation.dart';
import '/screens/owl_animation_screen.dart';
import '/screens/simple_animation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //! Make Column take full width
          SizedBox(width: double.infinity),
      
          //! Useless Owl animation
          NavigationButton(
            label: 'Basic Animation',
            destination: SimpleAnimationScreen(),
          ),
      
          //! Flutter Dash Animation
          NavigationButton(
            label: 'Flutter Dash',
            destination: BirdAnimationScreen(),
          ),
      
          //! Moving Dog Animation
          NavigationButton(
            label: 'Pes Animation',
            destination: DogAnimationScreen(),
          ),
      
          //! Active Owl
          NavigationButton(
            label: 'Owl Animation',
            destination: OwlAnimationScreen(),
          ),
      
          //! Login Screen
          NavigationButton(
            label: 'Login Screen',
            destination: LoginScreenAnimation(),
          ),
      
          //! Dark Theme Screen
          NavigationButton(
            label: 'Change Theme',
            destination: ChangeThemeScreen(),
          ),
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.label,
    required this.destination,
  });

  final String label;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => destination,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16.0,
        ),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
