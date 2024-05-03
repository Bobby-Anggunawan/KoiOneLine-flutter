import 'package:flutter/material.dart';
import 'package:koi_one_line/extension/FromBuildContext.dart';
import 'package:koi_one_line/extension/FromList.dart';
import 'package:koi_one_line/page/KoiPgHome/E_Wallet/E_WalletBalance.dart';
import 'package:koi_one_line/page/KoiPgHome/E_Wallet/E_WalletMenu.dart';
import 'package:koi_one_line/page/KoiPgHome/HomeMenuIcon.dart';

/// ui home page dari app yang biasanya punya fitur E-Wallet kek gojek, grab, shopee, dll
///
/// **WARNING**
//  * di dalam [menu], kalau ada menu dengan nama yang sama, widget akan mereturn error
class E_Wallet extends StatelessWidget {
  const E_Wallet({
    Key? key,
    required this.menu,
    this.topMenu,
    required this.appBar,
    required this.header,
    required this.footer
  }) : super(key: key);

  /// daftar semua menu diurutkan berdasarkan kategorinya.
  ///
  /// Misalnya "cat-1": [HomeMenuIcon(), HomeMenuIcon()], "cat-2": [HomeMenuIcon(), HomeMenuIcon()]
  final Map<String, List<HomeMenuIcon>> menu;
  /// boleh kosong. menu yang ditampilkan di halaman depan kalau ada banyak menu. Kalau ini kosong, menu random yang akan ditampilkan
  final List<String>? topMenu;

  final PreferredSizeWidget appBar;

  /// widget yang letaknya diatas menu.
  /// biasanya menggunakan widget yang menampilkan saldo dan beberapa tombol misalnya untuk topupkek gi gopay
  /// user dapat menggunakan widget E_WalletBalance yang disediakan di library ini atau menggunakan widget sendiri
  final Widget header;

  /// widget yang letaknya dibawah menu
  /// bisa diisi berbagai informasi seperti promo, artikel, dll. Bisa juga dibiarkan kosong
  final Widget? footer;

  @override
  Widget build(BuildContext context) {

    List<String> tempName = [];
    menu.values.forEach((element) {
      element.forEach((element) {
        if(tempName.contains(element.name) == false){
          tempName.add(element.name);
        }
        else{
          throw AssertionError("Ada menu dengan nama yang sama");
        }
      });
    });
    topMenu?.forEach((element) {
      if(tempName.contains(element) ==  false){
        throw AssertionError("Menu '${element}' tidak terdaftar");
      }
    });

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.koiSpacing.autoFromScreenEdge),
        child: SingleChildScrollView(
          child: Column(
            children: [
              header,
              E_WalletMenu(menu: menu, topMenu: topMenu),
              footer
            ].koiRemoveNull<Widget>().koiAddBetweenElement(SizedBox(height: context.koiSpacing.autoBeetweenPane,)),
          ),
        ),
      ),
    );
  }
}