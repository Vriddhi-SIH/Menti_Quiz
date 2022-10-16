import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';
// import 'main.dart';

class Interval2 extends StatefulWidget {
  const Interval2({super.key});

  @override
  State<Interval2> createState() => _Interval2State();
}

class _Interval2State extends State<Interval2> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Material(child: Center(child: Text('data'))));
    //

    // return Center(child: Text('data'));
  }
}
