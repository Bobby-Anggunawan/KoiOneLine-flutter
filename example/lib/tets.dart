import 'package:flutter/material.dart';
import 'package:koi_one_line/widget/KoiWgDataTable.dart';
import 'package:koi_one_line/widget/KoiWgOption.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("ikan"),),
      body: Container(
        width: 500,
        child: KoiWgOption(
          defaultOption: [1, 2, 10, 7],
          options: {
            1: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("satu"),
                Icon(Icons.looks_one)
              ],
            ),
            2: Text("dua"),
            3: Text("tiga"),
            4: Text("empat"),
            5: Text("lima"),
            6: Text("enam"),
            7: Text("tujuh"),
            8: Text("delapan"),
            9: Text("sembilan"),
            10: Text("sepuluh"),
          },
          optionMode: OptionMode.MultiSelect,
          maxOptionSelected: 5,
          onOptionChange: (values) {
            print("onOptionChange");
            print(values);
          },),
      ),
    );
  }
}
