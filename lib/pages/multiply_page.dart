import 'package:flutter/material.dart';

class MultiplyPage extends StatelessWidget {
  const MultiplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiply Page"),
      ),
      backgroundColor: Colors.green[200],
      body: Center(
        child: Text('MultiplyPage'),
      ),
    );
  }
}
