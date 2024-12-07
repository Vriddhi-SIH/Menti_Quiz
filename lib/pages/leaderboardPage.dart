import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/intervalPage.dart';

import '../homepage.dart';
import '../main.dart';
// import 'main.dart';

class Interval3 extends StatefulWidget {
  const Interval3({super.key});

  @override
  State<Interval3> createState() => _Interval3State();
}

class _Interval3State extends State<Interval3> {
  final Stream<DocumentSnapshot> _usersStream =
      FirebaseFirestore.instance.collection('quiz').doc('$id2').snapshots();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    _usersStream.drain();
    super.dispose();
  }

  Widget check() {
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
          child: StreamBuilder<DocumentSnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading"));
                }
                if (snapshot.hasData) {
                  print(snapshot.data);
                }
                _usersStream.listen((userData) {
                  if (userData['changed'] == true) {
                    if (userData['index'] == 3) {
                      print('hello');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntervalPage()),
                          (route) => false);
                    } else
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (contex) => MyHomePage(title: '$id2')));
                  }
                });

                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('LeaderBoard'), Text('Nice ')],
                ));
                //

                // return Center(child: Text('data'));
              })),
    );
  }
}
