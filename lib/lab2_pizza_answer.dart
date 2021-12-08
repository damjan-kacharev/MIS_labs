import 'dart:ffi';

import 'package:flutter/material.dart';

class Odgovor extends StatelessWidget {
  String answer;

  VoidCallback tapped;

  Odgovor(this.tapped, this.answer);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        answer,
        style: TextStyle(fontSize: 20, color: Colors.red.shade400),
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
      onPressed: tapped,
    );
  }
}
