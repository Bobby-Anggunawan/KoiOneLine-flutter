import 'package:flutter/material.dart';
import 'package:koi_one_line/koi_one_line.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KoiPgHome.E_Wallet(
        appBar: AppBar(),
        menu: {
          "a": [
            HomeMenuIcon(icon: Icon(Icons.add_a_photo_rounded), routeName: '', name: 'add_a_photo', onClick: null, backgroundColor: Colors.indigoAccent, badge: Badge(label: Text("1+"),),),
            HomeMenuIcon(icon: Icon(Icons.access_alarm_sharp), routeName: '', name: 'access_alarm', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.add_box_rounded), routeName: '', name: 'add_box', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.info), routeName: '', name: 'info', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.dashboard), routeName: '', name: 'dashboard', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.javascript), routeName: '', name: 'javascript', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.output), routeName: '', name: 'output', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.label), routeName: '', name: 'label', onClick: null, backgroundColor: Colors.indigoAccent,),
            HomeMenuIcon(icon: Icon(Icons.qr_code), routeName: '', name: 'qr_code', onClick: null, backgroundColor: Colors.indigoAccent,),
          ],
          "b": [
            HomeMenuIcon(icon: Icon(Icons.g_mobiledata), routeName: '', name: 'mobiledata', onClick: null, backgroundColor: Colors.orange,),
            HomeMenuIcon(icon: Icon(Icons.wallet), routeName: '', name: 'wallet', onClick: null, backgroundColor: Colors.orange,),
            HomeMenuIcon(icon: Icon(Icons.hail), routeName: '', name: 'hail', onClick: null, backgroundColor: Colors.orange,),
            HomeMenuIcon(icon: Icon(Icons.offline_bolt), routeName: '', name: 'offline_bolt', onClick: null, backgroundColor: Colors.orange,),
            HomeMenuIcon(icon: Icon(Icons.favorite), routeName: '', name: 'favorite', onClick: null, backgroundColor: Colors.orange,),
          ]
        },
        header: SizedBox(),
        footer: null
    );
  }
}
