import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';
import 'package:koi_one_line/widget/KoiWgDataTable.dart';
import 'package:koi_one_line/widget/KoiWgForm.dart';
import 'package:koi_one_line/widget/KoiWgOption.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    String display = "";

    return Scaffold(
      appBar: AppBar(title: Text("ikan"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{

            /*KoiHttp(url: 'http://localhost/my_web/mobileApp/public/api/test')
              .addBodyForm("image_data", await File);*/

            setState(() {});
          }, child: Text("Test")),
          Text(display)
        ],
      ),
    );
  }
}
