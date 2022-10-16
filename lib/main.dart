import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'homepage.dart';

String id2 = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Menti Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuizID> quizId = [];
  String error = '';
  Future<List<QuizID>> getAllID() async {
    var val = await FirebaseFirestore.instance.collection('ids').get();
    var documents = val.docs;
    if (documents.isNotEmpty) {
      return documents.map((document) {
        QuizID bookingList =
            QuizID.fromMap(Map<String, dynamic>.from(document.data()));
        return bookingList;
      }).toList();
    }

    return [];
  }

  void getInitData() async {
    quizId = await getAllID();
    setState(() {});
  }

  @override
  void initState() {
    getInitData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Enter Quiz Id',
            style: TextStyle(
                color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: TextFormField(onChanged: ((value) {
              setState(() {
                id2 = value;
              });
            })),
          ),
          ElevatedButton(
              onPressed: () {
                for (int i = 0; i < quizId.length; i++) {
                  if ('${quizId[i].id}' == id2) {
                    error = '';
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => MyHomePage(
                              title: id2,
                              // quesIndec: 1,
                            ))));
                  } else {
                    setState(() {
                      error = 'Wrong Quiz ID';
                    });
                  }
                }
              },
              child: const Text('Enter')),
          Text(
            "$error",
            style: const TextStyle(color: Colors.red, fontSize: 20),
          )
        ],
      ),
    );
  }
}

class QuizID {
  int id;

  QuizID({
    required this.id,
  });

  QuizID.fromMap(Map map)
      :
        // : desc = map['ques'],

        // amount = double.parse('${map['Amount']}'),
        id = map['id'];
  // type = map['type'],
  // id = map['id'];

  Map toMap() {
    return {
      'id': id
      // 'Amount': amount,
      // 'time': time,
      // 'type': type,
      // 'id': id
    };
  }
}
