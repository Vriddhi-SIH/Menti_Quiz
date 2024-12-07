import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/intervalPage.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/pages/intervalPage.dart';
import 'package:quiz_app/pages/leaderboardPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  // int quesIndec;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<DocumentSnapshot> _usersStream =
      FirebaseFirestore.instance.collection('quiz').doc('$id2').snapshots();
  List<Data2> desc2 = [];
  List<Options> options = [];
  Timer? _timer;
  int remainSeconds = 1;
  String time = '05';
  // void getTime()async{
  //   var val = await FirebaseFirestore.instance
  //       .collection('quiz')
  //       .doc('${widget.title}')

  //       .get();
  //   var documents = val.docs;
  //   if (documents.isNotEmpty) {
  //     return documents.map((document) {
  //       Data2 bookingList =
  //           Data2.fromMap(Map<String, dynamic>.from(document.data()));
  //       return bookingList;
  //     }).toList();
  // }

  // }
  void _startTimer(
    int seconds,
  ) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          _startTimer2(5);
          setState(() {
            time = '00';
          });
          timer.cancel();
        } else {
          int seconds = (remainSeconds);
          setState(() {
            time = "${seconds.toString().padLeft(2, "0")}";
          });

          print(time);
          remainSeconds--;
        }
      },
    );
  }

  Timer? _timer2;
  int remainSeconds2 = 0;
  // String time = '00:05';
  String time2 = '05';
  void _startTimer2(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds2 = seconds;
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds2 == 0) {
          setState(() {
            time2 = '00';
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => Interval3())));
          timer.cancel();
        } else {
          // double s3 = remainSeconds2 % 1000;
          int seconds = (remainSeconds2);

          setState(() {
            time2 = "${seconds.toString().padLeft(2, "0")}";
          });

          // print(time2);
          remainSeconds2 = remainSeconds2 - 1;
        }
      },
    );
  }

  @override
  void initState() {
    _startTimer(5);
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    _usersStream.drain();
    super.dispose();
  }

  int _counter = 0;
  int? data3;
  List<Data2>? data1;
  Future<List<Data2>> GetData2() async {
    var val = await FirebaseFirestore.instance
        .collection('quiz')
        .doc('${widget.title}')
        .collection('questions')
        .get();
    var documents = val.docs;
    if (documents.isNotEmpty) {
      return documents.map((document) {
        Data2 bookingList =
            Data2.fromMap(Map<String, dynamic>.from(document.data()));
        return bookingList;
      }).toList();
    }

    return [];
  }

  Future<List<Options>> GetData(int index) async {
    var val = await FirebaseFirestore.instance
        .collection('quiz')
        .doc('${widget.title}')
        .collection('questions')
        .doc('${index + 1}')
        .collection('answers')
        .get();
    var documents = val.docs;
    if (documents.isNotEmpty && time == '00') {
      // _startTimer2(5);
      return documents.map((document) {
        Options bookingList =
            Options.fromMap(Map<String, dynamic>.from(document.data()));

        return bookingList;
      }).toList();
    }

    return [];
  }

  void _incrementCounter(int index) {
    if ((index + 1) >= 3) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => IntervalPage()),
          (route) => false);
    } else {
      final fi =
          FirebaseFirestore.instance.collection('quiz').doc('${widget.title}');

      fi.update({"index": index + 1});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$time || $time2'),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: _usersStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading"));
              }

              data3 = snapshot.data?['index'];
              // print(data3);

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder<List<Data2>>(
                      future: GetData2(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Data2>> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          data1 = snapshot.data as List<Data2>;
                          children = <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                '${data1?[data3!].desc}?'.toUpperCase(),
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ];
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            ),
                          ];
                        } else {
                          children = const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            ),
                          ];
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ),
                        );
                      },
                    ),
                    FutureBuilder<List<Options>>(
                      future: GetData(data3 as int),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Options>> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          List<Options> data5 = snapshot.data as List<Options>;
                          // _startTimer2(5);
                          children = <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height: 500,
                                    child: ListView.builder(
                                      itemBuilder: ((context, index) {
                                        // print(data1);
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: InkWell(
                                            onTap: () {
                                              if (data1?[data3!].anser ==
                                                  data5[index].identi) {
                                                print('1');
                                              }

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          Interval2())));
                                            },
                                            child: Container(
                                              // width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blue[200]),
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  '${data5[index].answer}',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      itemCount: data5.length,
                                    ),
                                  )
                                  //   Text(
                                ],
                              ),
                            ),
                          ];
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            ),
                          ];
                        } else {
                          children = const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Answer Fast To Get More Points...'),
                            ),
                          ];
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            _incrementCounter(data3 as int);
          }),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Data2 {
  String desc;
  String anser;

  Data2({required this.desc, required this.anser});

  Data2.fromMap(Map map)
      : desc = map['ques'],
        anser = map['correcAnswer'];

  Map toMap() {
    return {'description': desc};
  }
}

class Options {
  String answer;
  String identi;
  Options({required this.answer, required this.identi});

  Options.fromMap(Map map)
      : identi = map['identifier'],
        answer = map['answer'];
}
