import 'package:flutter/material.dart';
import 'package:pexel/Utils/constant.dart';

class UserGuidance extends StatelessWidget {
  const UserGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "User Guidance",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            howToUse,
            style: TextStyle(fontSize: 18),
          ),
        ));
  }
}
