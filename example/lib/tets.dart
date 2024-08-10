import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:koi_one_line/koi_one_line.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    String display = "";

    return KoiPgInfiniteList(

      leading: [
        Text("ini lead  text 1"),
        Text("ini lead  text 2"),
      ],

        fetchPage: (page)async{
      if(page < 5){
        return [
          Text("satu${page}"),
          Text("dua${page}"),
          Text("tiga${page}"),
          Text("empat${page}"),
          Text("lima${page}-------------------"),
        ];
      }
      return null;
    });
  }
}
