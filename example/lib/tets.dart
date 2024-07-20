import 'package:flutter/material.dart';
import 'package:koi_one_line/widget/KoiWgDataTable.dart';
import 'package:koi_one_line/widget/KoiWgForm.dart';
import 'package:koi_one_line/widget/KoiWgOption.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var arow = [
      [Text("1a"),Text("b"),Text("c"),],
      [Text("2a"),Text("b"),Text("c"),],
      [Text("3a"),Text("b"),Text("c"),],
    ];

    return Scaffold(
      appBar: AppBar(title: Text("ikan"),),
      body: KoiWgForm(
        field: {
          "ikan": FieldType.text,
          "sapi": FieldType.text_multiline,
        },
        onChange: (String lastChangedKey, Map<String, dynamic> data) {
          print(data["ikan"]);
        },
      ),
    );
  }
}
