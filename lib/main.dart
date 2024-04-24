import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCGTOCCohSx-Hbw-dqdmFQo63wX7gxocLQ",
        appId: "1:634259890926:android:d5d547b3c280f1164389ff",
        messagingSenderId: "634259890926",
        projectId: "chatapp-10639",
        storageBucket: "chatapp-10639.appspot.com",
      ))
      : await Firebase.initializeApp();
  runApp(const ChatApp());
}
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme:const TextTheme(
          bodyMedium: TextStyle(color: Colors.black38),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=> const WelcomeScreen(),
        LoginScreen.id : (context)=> const LoginScreen(),
        RegistrationScreen.id : (context)=> const RegistrationScreen(),
        ChatScreen.id :(context)=> const ChatScreen(),
      },

    );
  }
}
