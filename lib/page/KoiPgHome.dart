import "package:flutter/material.dart";
import "package:koi_one_line/page/KoiPgHome/HomeMenuIcon.dart";
import "KoiPgHome/E_Wallet/E_Wallet.dart";

class KoiPgHome extends StatelessWidget {

  /// ui home page dari app yang biasanya punya fitur E-Wallet kek gojek, grab, shopee, dll
  KoiPgHome.E_Wallet({
    required PreferredSizeWidget appBar,
    required Map<String, List<HomeMenuIcon>> menu,
    List<String>? topMenu,
    required Widget header,
    required Widget? footer,
    Key? key
  }) : toShow = E_Wallet(
    appBar: appBar,
    menu: menu,
    topMenu: topMenu,
    header: header,
    footer: footer,
  ), super(key: key);

  final Widget toShow;

  @override
  Widget build(BuildContext context) {
    return toShow;
  }
}