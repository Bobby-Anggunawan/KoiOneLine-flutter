import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Center(
          child: ElevatedButton(
            child: Text("abcd"),
            onPressed: (){
              KoiApp.showToast("test");
            },
          ),
        ),
      ),
    );
  }
}
