import 'package:flutter/material.dart';
import 'package:koi_one_line/extension/FromBuildContext.dart';
import 'package:koi_one_line/extension/FromList.dart';

import '../HomeMenuIcon.dart';

class E_WalletMenu extends StatelessWidget {
  const E_WalletMenu({
    Key? key,
    required this.menu,
    required this.topMenu,
    this.columnCount = 4,
    this.rowCount = 2,
    this.menuAspectRatio = 3/4
  }) : super(key: key);

  /// aspec ratio dari tiap icon menu. Kalau 1/1 artinya kotak, 4/3 artinya panjang kesamping
  /// diaplikasikan di gridview
  final double menuAspectRatio;

  /// berapa row max yang ditampilkan di top menu
  final int rowCount;
  /// berapa colom max yang ditampilkan di top menu
  final int columnCount;

  /// daftar semua menu diurutkan berdasarkan kategorinya.
  ///
  /// Misalnya "cat-1": [HomeMenuIcon(), HomeMenuIcon()], "cat-2": [HomeMenuIcon(), HomeMenuIcon()]
  final Map<String, List<HomeMenuIcon>> menu;
  /// boleh kosong. menu yang ditampilkan di halaman depan kalau ada banyak menu. Kalau ini kosong, menu random yang akan ditampilkan
  final List<String>? topMenu;


  @override
  Widget build(BuildContext context) {

    List<HomeMenuIcon> buildTopMenu = [];
    menu.forEach((key, cat) {
      cat.forEach((element) {
        if(buildTopMenu.length < (rowCount*columnCount)-1){
          if(topMenu == null){
            buildTopMenu.add(element);
          }
          else if(topMenu!.contains(element.name)){
            buildTopMenu.add(element);
          }
        }
      });
    });

    buildTopMenu.add(
        HomeMenuIcon(
          icon: Icon(Icons.dashboard, color: context.koiThemeColor.onSurface,),
          name: "Menu",
          routeName: null,
          backgroundColor: context.koiThemeColor.surface,
          onClick: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return _AllMenu(menu: menu, crossAxisCount: columnCount,);
                }
            );
          },
        )
    );

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: columnCount,
      children: buildTopMenu,
      childAspectRatio: menuAspectRatio,
      mainAxisSpacing: context.koiSpacing.largest,
      crossAxisSpacing: context.koiSpacing.largest,
    );
  }
}

class _AllMenu extends StatelessWidget {
  const _AllMenu({Key? key, required this.menu, required this.crossAxisCount}) : super(key: key);

  final Map<String, List<HomeMenuIcon>> menu;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {

    List<Widget> buildMenu = [];
    menu.forEach((key, value) {

      // nama kategori
      buildMenu.add(Text(key, style: context.koiThemeText.title(),));

      // item menu di kategori ini
      buildMenu.add(
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            children: value,
          )
      );

      // tambah spacing antar kategori
      buildMenu.add(SizedBox(height: context.koiSpacing.largest,));
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.koiSpacing.autoFromScreenEdge),
      child: ListView(
        children: <Widget>[
          SizedBox(height: context.koiSpacing.autoFromScreenEdge,),
          Row(
            children: [
              Expanded(child: SizedBox()),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
          SizedBox(height: context.koiSpacing.large,)
        ].koiJoinList(buildMenu),
      ),
    );
  }
}

