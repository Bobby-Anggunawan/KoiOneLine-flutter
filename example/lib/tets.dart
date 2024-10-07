import 'dart:convert';

import 'package:flutter/material.dart';
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

    return Scaffold(
      body: Center(
        child: KoiWgInput.MultiSelectWithSearch(
          suggestion: [
            KoiDataItem(label: Text("Satu"), data: 'Satu'),
            KoiDataItem(label: Text("empat"), data: 'empat'),
          ],
            onSelected: (newData){
              print(">:D>${jsonEncode(newData)}");
            },
            label: Text("Kota"),
            onSearch: (query)async{
          if(query.length>3){
            return [
              KoiDataItem(label: Text("Satu"), data: 'Satu'),
            ];
          }
          else if(query.length>2){
            return [
              KoiDataItem(label: Text("Satu"), data: 'Satu'),
              KoiDataItem(label: Text("dua"), data: 'dua'),
            ];
          }
          else if(query.length>1){
            return [
              KoiDataItem(label: Text("Satu"), data: 'Satu'),
              KoiDataItem(label: Text("dua"), data: 'dua'),
              KoiDataItem(label: Text("tiga"), data: 'tiga'),
            ];
          }
          else{
            return [
              KoiDataItem(label: Text("Satu"), data: 'Satu'),
              KoiDataItem(label: Text("dua"), data: 'dua'),
              KoiDataItem(label: Text("tiga"), data: 'tiga'),
              KoiDataItem(label: Text("empat"), data: 'empat'),
            ];
          }
        }),
      ),
    );
  }
}
