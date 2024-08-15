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

    return KoiPgPoints(
      page: [
        PointPage(
          icon: Icons.abc,
          title: 'Ini title satu',
          subtitle: 'ini adalah penjelassan untuk halaman point yang pertama untuk dipakai test',
          illustration: Image.network("https://th.bing.com/th/id/OIP.XZDvYoSgdI8NIZQshTErgAHaNK?w=178&h=317&c=7&r=0&o=5&pid=1.7"),
        ),
        PointPage(
          icon: Icons.account_tree_sharp,
          title: 'Ini title dua',
          subtitle: 'ini adalah penjelassan untuk halaman point yang kedua untuk dipakai test',
          illustration: Center(
            child: ElevatedButton(onPressed: (){}, child: Text("sapi")),
          ),
        ),
        PointPage(
          icon: Icons.add_a_photo,
          title: 'Ini title tiga',
          subtitle: 'ini adalah penjelassan untuk halaman point yang ketiga untuk dipakai test',
          illustration: Image.network("https://th.bing.com/th/id/OIP.Zly6aAd7JrZG2J6cFCJ0hwHaNK?w=178&h=287&c=7&r=0&o=5&pid=1.7"),
          helpIconClicked: (){
            print("klik tombol help");
          },
        ),
      ], onComplete: null,
    );
  }
}
