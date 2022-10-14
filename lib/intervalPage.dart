import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/homepage.dart';
import 'package:quiz_app/main.dart';

class IntervalPage extends StatefulWidget {
  String ids;
  int quesid;
  IntervalPage({super.key, required this.ids, required this.quesid});

  @override
  State<IntervalPage> createState() => _IntervalPageState();
}

class _IntervalPageState extends State<IntervalPage> {
  void _incrementCounter() {
    // Navigator.of(context).push()
    final fi =
        FirebaseFirestore.instance.collection('quiz').doc('${widget.ids}');

    fi.update({"index": 1});
    Navigator.of(context).push(MaterialPageRoute(
        builder: (conetx) => MyHomePage(
              title: widget.ids,
              quesIndec: widget.quesid + 1,
            )));
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    ));
  }
}
