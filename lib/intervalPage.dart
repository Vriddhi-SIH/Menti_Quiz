import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/homepage.dart';
import 'package:quiz_app/main.dart';

class IntervalPage extends StatefulWidget {
  IntervalPage({
    super.key,
  });

  @override
  State<IntervalPage> createState() => _IntervalPageState();
}

class _IntervalPageState extends State<IntervalPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
        return Future.delayed(Duration.zero);
      }),
      child: Material(
          child: Center(
        child: Text('Quiz Ended'),
      )),
    );
  }
}
