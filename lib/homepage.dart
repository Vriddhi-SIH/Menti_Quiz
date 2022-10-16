import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/intervalPage.dart';
import 'package:quiz_app/main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.quesIndec});
  final String title;
  int quesIndec;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<DocumentSnapshot> _usersStream =
      FirebaseFirestore.instance.collection('quiz').doc('$id2').snapshots();
  List<Data2> desc2 = [];
  List<Options> options = [];
  @override
  void initState() {
    initData();

    setState(() {});

    super.initState();
  }

  void initData() async {
    // desc2 = await GetData2();100
    // options = await GetData();

    setState(() {});
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
    if (documents.isNotEmpty) {
      await Future.delayed(Duration(seconds: 5));
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading"));
            }

            data3 = snapshot.data?['index'];
            print(data3);
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
                        // print('$data1')
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
                                                style: TextStyle(fontSize: 20),
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
    );
  }
}

class Data2 {
  String desc;
  String anser;

  Data2(
      {
      // {required this.amount,
      required this.desc,
      required this.anser});

  Data2.fromMap(Map map)
      : desc = map['ques'],

        // amount = double.parse('${map['Amount']}'),
        anser = map['correcAnswer'];

  Map toMap() {
    return {'description': desc};
  }
}

class Options {
  String answer;
  String identi;

  // double amount;
  // String time;
  // String type;
  // int id;

  Options(
      {
      // {required this.amount,
      required this.answer,
      required this.identi});
  // required this.time,
  // required this.type,
  // required this.id});

  Options.fromMap(Map map)
      : identi = map['identifier'],

        // amount = double.parse('${map['Amount']}'),
        answer = map['answer'];
  // type = map['type'],
  // id = map['id'];

}
