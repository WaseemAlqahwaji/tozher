import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => GoalsPageState();
}

class GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Goals Page'),
      ),
    );
  }
}