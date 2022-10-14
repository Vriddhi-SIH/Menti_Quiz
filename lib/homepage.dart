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
    desc2 = await GetData2();
    options = await GetData();

    setState(() {});
  }

  int _counter = 0;
  int? data3;
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

  Future<List<Options>> GetData() async {
    var val = await FirebaseFirestore.instance
        .collection('quiz')
        .doc('${widget.title}')
        .collection('questions')
        .doc('$data3')
        .collection('answers')
        .get();
    var documents = val.docs;
    if (documents.isNotEmpty) {
      return documents.map((document) {
        Options bookingList =
            Options.fromMap(Map<String, dynamic>.from(document.data()));

        // print(bookingList);
        return bookingList;
      }).toList();
    }

    return [];
  }

  void _incrementCounter() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (conetx) => IntervalPage(
              ids: widget.title,
              quesid: widget.quesIndec,
            )));
    // final fi =
    //     FirebaseFirestore.instance.collection('quiz').doc('${widget.title}');

    // fi.update({"index": 1});
    // setState(() {});
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
            // print(object)
            // data3 = 1;
            print(data3);
            return Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<List<Data2>>(
                    future:
                        GetData2(), // a previously-obtained Future<String> or null
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Data2>> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        List<Data2> data1 = snapshot.data as List<Data2>;
                        children = <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              '${data1[data3!].desc}',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemBuilder: ((context, index) {
                                  return Text(options[index].answer);
                                }),
                                itemCount: options.length,
                              )),
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
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
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Data2 {
  String desc;
  String anser;

  // double amount;
  // String time;
  // String type;
  // int id;

  Data2(
      {
      // {required this.amount,
      required this.desc,
      required this.anser});
  // required this.time,
  // required this.type,
  // required this.id});

  Data2.fromMap(Map map)
      : desc = map['ques'],

        // amount = double.parse('${map['Amount']}'),
        anser = map['correcAnswer'];
  // type = map['type'],
  // id = map['id'];

  Map toMap() {
    return {
      'description': desc
      // 'Amount': amount,
      // 'time': time,
      // 'type': type,
      // 'id': id
    };
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
