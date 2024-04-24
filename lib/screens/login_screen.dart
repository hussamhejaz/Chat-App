import 'package:chat_app/button.dart';
import 'package:chat_app/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String? email;
   String? password;
   final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
        builder: (context) =>
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'hero',
                  child: Image.asset(
                    'images/logo.jpg',
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: kdecor
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: kdecor.copyWith(hintText: "Enter your Password"),
              ),
             const  SizedBox(
                height: 24.0,
              ),
              Button(text: 'Login', onPress:() async{
                final progress = ProgressHUD.of(context);
                setState(() {
                  progress!.show();
                  Future.delayed(const Duration(seconds: 2), () {
                    progress.dismiss();
                  });
                });

                try{
                  final user = await _auth.signInWithEmailAndPassword(email: email!, password: password!);
                }catch(e){
                  print(e);
                }
                if(!context.mounted) return;
                Navigator.pushNamed(context, ChatScreen.id);
              })
            ],
          ),
        ),
      ),
    ),
    )
    ;
  }
}
