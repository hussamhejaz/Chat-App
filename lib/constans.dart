import 'package:flutter/material.dart';
const kdecor= InputDecoration(

hintText: 'Enter Your Email',
hintStyle: TextStyle(color: Colors.grey),

contentPadding:
EdgeInsets.symmetric(horizontal: 20, vertical: 10),
border: OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(32),
),
),
enabledBorder: OutlineInputBorder(
borderSide:
BorderSide(color: Colors.lightBlueAccent, width: 1),
borderRadius: BorderRadius.all(Radius.circular(32.0)),
),
focusedBorder: OutlineInputBorder(
borderSide:
BorderSide(color: Colors.lightBlueAccent, width: 2.0),
borderRadius: BorderRadius.all(Radius.circular(32.0)),
),
);