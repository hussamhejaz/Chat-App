import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import '/button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'hero',
                    child: Image.asset(
                      'images/logo.jpg',
                      height: 100,
                    ),
                  ),
                   AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Chat Application', textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900),)
                      ],

                  ),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
               Button(text: 'Login', onPress: (){
                   Navigator.pushNamed(context, LoginScreen.id);
               },),
              Button(text: 'Register', onPress:  () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },)
            ],
          ),
        ),
      ),
    );
  }
}

