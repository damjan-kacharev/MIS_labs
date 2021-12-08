import 'package:flutter/material.dart';
import './lab2_pizza_question.dart';
import './lab2_pizza_answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  void iWasTapped() {
    setState(() {
      if (questionNum != 2)
        questionNum += 1;
    });
    print('i was tapped');
  }

  var questions = [
    {
      'question': "Odberi goren del:",
      'answer': [
        'Jakna',
        'Dukser',
        'Shushkavec',
        'Sako',
      ]
    },
    {
      'question': "Odberi dolen del:",
      'answer': [
        'Pantaloni',
        'Trenerki',
        'Farmerki',
        'Kratki Pantaloni',
      ]
    },
    {
      'question': "Odberi obuvki",
      'answer': [
        'Patiki',
        'Konduri',
        'Chizmi',
        'Mokasini',
      ],
    }
  ];

  var questionNum = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Clothes",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Choose clothes"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Pizza(questions[questionNum]['question'] as String),
            ...(questions[questionNum]['answer'] as List<String>).map((answer) {
              return Odgovor(iWasTapped, answer);
              //SizedBox(height: 50);
            }),
          ],
        ),
      ),
    );
  }
}
