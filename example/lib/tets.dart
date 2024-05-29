import 'package:flutter/material.dart';
import 'package:koi_one_line/widget/KoiWgDataTable.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("ikan"),),
      body: Container(
        width: 300,
        height: 300,
        child: KoiWgDataTable(
            columns: [WgDataTableColumn(title: Text("Ikan11"), width: 200),WgDataTableColumn(title: Text("Ikan2")),WgDataTableColumn(title: Text("Ikan3")),WgDataTableColumn(title: Text("Ikan4")),WgDataTableColumn(title: Text("Ikan5")),WgDataTableColumn(title: Text("Ikan6")),WgDataTableColumn(title: Text("Ikan7")),WgDataTableColumn(title: Text("Ikan8")),WgDataTableColumn(title: Text("Ikan9")),WgDataTableColumn(title: Text("Ikan0")),],
            row: [
              [Text("ayama"),Text("ayama"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayamb"),Text("ayamb"),Text("ayam"),Text("ayamjodfg dsf huisd h iudshfiuh isdfh uih iusdhf iuh iuhdfuh iuh iusdhf iuhiuh"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayamc"),Text("ayamc"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
              [Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),Text("ayam"),],
            ]
        ),
      ),
    );
  }
}
