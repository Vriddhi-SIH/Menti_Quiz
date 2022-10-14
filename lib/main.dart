import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'homepage.dart';

String id2 = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initializing the firebase app
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Menti Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
    // home: UserInformation());
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
  Future<List<QuizID>> GetData2() async {
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
    quizId = await GetData2();
    setState(() {});
  }

  @override
  void initState() {
    getInitData();
    // TODO: implement initState
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Enter Quiz Id',
            style: TextStyle(
                color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 50,
            width: 200,
            child: TextFormField(
                // decoration: InputDecoration(border: Bor),
                // initialValue: "Enter Quiz Id",
                onChanged: ((value) {
              setState(() {
                id2 = value;
              });
            })),
          ),
          ElevatedButton(
              onPressed: () {
                print(id2);
                for (int i = 0; i < quizId.length; i++) {
                  if ('${quizId[i].id}' == id2) {
                    error = '';
                    print('object');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => MyHomePage(
                              title: id2,
                              quesIndec: 00000001,
                            ))));
                  } else {
                    setState(() {
                      error = 'Wrong Quiz ID';
                    });
                  }
                }
              },
              child: Text('Enter')),
          Text(
            "$error",
            style: TextStyle(color: Colors.red, fontSize: 20),
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
