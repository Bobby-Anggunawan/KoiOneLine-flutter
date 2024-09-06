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

    return KoiPgHome.GridMenu(appBar: AppBar(title: Text("An app bar"),),
        menu: [
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/aa',
            name: 'aaa', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/bb',
            name: 'bb', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/cc',
            name: 'cc', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/dd',
            name: 'dd', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/ee',
            name: 'ee', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/ff',
            name: 'ff', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/gg',
            name: 'gg', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/hh',
            name: 'hh', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/ii',
            name: 'ii', onClick: null,
            backgroundColor: Colors.teal,
          ),HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/jj',
            name: 'jj', onClick: null,
            backgroundColor: Colors.teal,
          ),
          HomeMenuIcon(
            icon: Icon(Icons.access_time),
            routeName: '/kk',
            name: 'kk', onClick: null,
            backgroundColor: Colors.teal,
          ),

        ]);
  }
}
