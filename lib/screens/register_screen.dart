import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/button.dart';
import 'package:chat_app/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;

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
                  child: Image.asset('images/logo.jpg'),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              TextField(style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value){
                email =value;
              },
                  decoration: kdecor,
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value){
                password= value;
                },
                decoration: kdecor.copyWith(hintText: 'Enter your password'),
                ),
              Button(text: 'Register', onPress:()async{
                final progress = ProgressHUD.of(context);
                setState(() {

                  progress!.show();
                  Future.delayed(Duration(seconds: 1), () {
                    progress.dismiss();
                  });

                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email!, password: password!);
                }catch(e){
                  print(e);
                }
                if(!context.mounted) return;
                Navigator.pushNamed(context, ChatScreen.id);
              })

            ],
          ),

      ),
    )));
  }
}
