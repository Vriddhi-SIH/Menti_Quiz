// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final textcontroller = TextEditingController();
//   final databaseRef = FirebaseDatabase.instance.ref();
//   final Future<FirebaseApp> _future = Firebase.initializeApp();

//   void addData(String data) {
//     databaseRef.push().set({'name': 'Hello', 'comment': 'A good season'});
//   }

//   void printFirebase() {}

//   @override
//   Widget build(BuildContext context) {
//     printFirebase();
//     return Material(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Firebase Demo"),
//         ),
//         body: FutureBuilder(
//             future: _future,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               } else {
//                 return Container(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 250.0),
//                       Padding(
//                         padding: EdgeInsets.all(10.0),
//                         child: TextField(
//                           controller: textcontroller,
//                         ),
//                       ),
//                       SizedBox(height: 30.0),
//                       Center(
//                           child: ElevatedButton(
//                               // color: Colors.pinkAccent,
//                               child: Text("Save to Database"),
//                               onPressed: () {
//                                 addData('Hello World');
//                                 //call method flutter upload
//                               })),
//                     ],
//                   ),
//                 );
//               }
//             }),
//       ),
//     );
//   }
// }
