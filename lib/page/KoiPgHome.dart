import "package:flutter/material.dart";
import "package:koi_one_line/page/KoiPgHome/GridMenu/GridMenu.dart";
import "package:koi_one_line/page/KoiPgHome/HomeMenuIcon.dart";
import "package:koi_one_line/page/KoiPgHome/SuperApp/SuperApp.dart";

class KoiPgHome extends StatelessWidget {

  /// ui home page dari app yang biasanya punya fitur E-Wallet kek gojek, grab, shopee, dll
  KoiPgHome.SuperApp({
    required PreferredSizeWidget appBar,
    required Map<String, List<HomeMenuIcon>> menu,
    List<String>? topMenu,
    required Widget header,
    required Widget? footer,
    Widget? background,
    Key? key
  }) : toShow = SuperApp(
    appBar: appBar,
    menu: menu,
    topMenu: topMenu,
    header: header,
    footer: footer,
    background: background,
  ), super(key: key);


  /// homepage sederhana dengan menu grid
  KoiPgHome.GridMenu({
    required PreferredSizeWidget appBar,
    required List<HomeMenuIcon> menu,
    Widget? background,
    Widget? header = null,
    Key? key
  }) : toShow = GridMenu(
    appBar: appBar,
    menu: menu,
    background: background,
    header: header,
  ), super(key: key);

  final Widget toShow;

  @override
  Widget build(BuildContext context) {
    return toShow;
  }
}