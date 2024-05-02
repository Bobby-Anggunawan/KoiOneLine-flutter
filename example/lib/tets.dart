import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example App"),),
      body: Center(
        child: Text("Welcome to test app"),
      ),
    );
  }
}
