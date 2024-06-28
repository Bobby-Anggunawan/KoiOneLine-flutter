import 'package:flutter/material.dart';
import 'package:koi_one_line/widget/KoiWgDataTable.dart';
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
      body: Container(
        width: 500,
        child: KoiWgDataTable(
          columns: [
            WgDataTableColumn(title: Text("satu")),
            WgDataTableColumn(title: Text("dua")),
            WgDataTableColumn(title: Text("tiga")),
          ],
          row: arow,
          onRowSelected: (indeksRow, isSelected){
            print("${arow[indeksRow][0].data}: ${isSelected}");
          },
        ),
      ),
    );
  }
}
