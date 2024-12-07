import 'package:flutter/material.dart';

import 'leaderboardPage.dart';

class DetailsPAge extends StatefulWidget {
  const DetailsPAge({super.key});

  @override
  State<DetailsPAge> createState() => _DetailsPAgeState();
}

class _DetailsPAgeState extends State<DetailsPAge> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Enter Your Details Please',
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    hintText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      // id2 = value;
                    });
                  })),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Roll Number';
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text('Roll Number'),
                    hintText: 'Enter Roll Number',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      // id2 = value;
                    });
                  })),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Email Id ';
                    }
                  },
                  decoration: const InputDecoration(
                    label: Text('Email ID'),
                    hintText: 'Enter Email ID',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: ((value) {
                    setState(() {
                      // id2 = value;
                    });
                  })),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Interval3()),
                        (route) => false);
                  }
                },
                child: const Text('Start Test'))
          ]),
        ),
      ),
    );
  }
}
