import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KoiPgHome.E_Wallet(
        appBar: AppBar(title: Text("Appbar"),),
        menu: {
          "cat-1": [
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home',
              onClick: null,
              backgroundColor: Colors.lightBlueAccent,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home1',
              onClick: null,
              backgroundColor: Colors.lightGreen,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home2',
              onClick: null,
              backgroundColor: Colors.purple,
            ),
          ],
          "cat-2": [
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'homecat2 asuhiu a suh ui hasuh uhasui  asuh iuhsauhd uh',
              onClick: null,
              backgroundColor: Colors.limeAccent,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home1cat2',
              onClick: null,
              backgroundColor: Colors.cyanAccent,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home2cat2',
              onClick: null,
              backgroundColor: Colors.tealAccent,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home3cat2',
              onClick: null,
              backgroundColor: Colors.lightBlueAccent,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home4cat2',
              onClick: null,
              backgroundColor: Colors.deepOrange,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home1cat3',
              onClick: null,
              backgroundColor: Colors.greenAccent,
            ),
            HomeMenuIcon(
              icon: Icon(Icons.ac_unit),
              routeName: 'home',
              name: 'home2cat3',
              onClick: null,
              backgroundColor: Colors.lightGreenAccent,
            ),
          ]
        },
        header: E_WalletBalance(slideCard: [Text("Ikan"), Text("Asin"), Text("Asin"), Text("Asin"), Text("Asin"), Text("Asin"), Text("Asin"), Text("Asin"), Text("Asin")], iconButton: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo_rounded, color: context.koiThemeColor.onPrimary),),
          IconButton(onPressed: (){}, icon: Icon(Icons.access_alarm_rounded, color: context.koiThemeColor.onPrimary),),
        ],),
      footer: Text("Ini footer", style: context.koiThemeText.display(),),
    );
  }
}
