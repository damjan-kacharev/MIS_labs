import 'package:flutter/material.dart';

class Pizza extends StatelessWidget {
  String content;
  Pizza(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, color: Colors.blue),
      ),
    );
  }
}
