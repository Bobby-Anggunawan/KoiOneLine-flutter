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

    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          showSearch<String>(context: context, delegate: MySearchDelegate()).then((val){
            print("kuekue ${val}");
          });
        }, child: Text("Open Search")),
      ),
    );
  }
}


class MySearchDelegate extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      Icon(Icons.pin_end),
      Icon(Icons.edit_calendar_sharp)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Icon(Icons.start);
  }

  @override
  Widget buildResults(BuildContext context){
    return ListView(
      children: [
        ListTile(
          title: Text(query),
          onTap: (){
            close(context, query);
          },
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView(
      children: [
        ListTile(
          title: Text("title1${query}"),
          onTap: (){
            query = "title1";
            showResults(context);
          },
        ),
        ListTile(
          title: Text("title2${query}"),
          onTap: (){
            query = "title2";
            showResults(context);
          },
        ),
        ListTile(
          title: Text("title3${query}"),
          onTap: (){
            query = "title3";
            showResults(context);
          },
        ),
        ListTile(
          title: Text("title4${query}"),
          onTap: (){
            query = "title4";
            showResults(context);
          },
        ),
        ListTile(
          title: Text("title5${query}"),
          onTap: (){
            query = "title5";
            showResults(context);
          },
        ),
      ],
    );
  }

}