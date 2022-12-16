import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SubtractionPage extends StatelessWidget {
  const SubtractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subtraction Page"),
      ),
      backgroundColor: Colors.blue[200],
      body: Center(
        child: Text('SubtractionPage'),
      ),
      floatingActionButton: SpeedDial(
        closeManually: false,
        overlayColor: Colors.amber,
        overlayOpacity: 0.2,
        onOpen: () => print("Opening"),
        curve: Curves.bounceIn,
        onClose: () => print("Closing"),
        backgroundColor: Colors.red,
        child: Icon(Icons.account_box_outlined),
        //animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.ac_unit),
            label: "First item",
            backgroundColor: Colors.yellow,
            onTap: () => print("First item"),
          ),
          SpeedDialChild(
            child: Icon(Icons.accessibility_new),
            label: "Second item",
            backgroundColor: Colors.blue,
            onTap: () => print("Second item"),
          ),
        ],
      ),
    );
  }
}
