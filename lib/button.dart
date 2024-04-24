import 'package:flutter/material.dart';
class Button extends StatelessWidget {
  const Button({super.key, required this.text , required this.onPress});
  final String text;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 10,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed:onPress,
          minWidth: 200,
          height: 42,
          child:  Text(text),
        ),
      ),
    );
  }
}
