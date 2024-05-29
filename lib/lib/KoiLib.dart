import 'dart:ui';
import 'package:flutter/material.dart';

class KoiLib{
  /// lebar dan tinggi window/layar tempat aplikasi ini berada dalam satuan dp.
  ///
  /// > Sebenarnya sama dengan **[MediaQuery.of(context).size.width]**, hanya saja yang ini tidak perlu context.
  ///
  /// **Sumber**
  ///
  /// *https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width*
  static Size get getWindowSize{
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;

    return size;
  }

  /// generate warna dari string hex. Flutter tidak menyediakan cara default untuk buat warna dari hex
  ///
  /// **Parameter**
  /// * [hexValue] : hex value dari warna yang dibuat. misalnya "B74093" atau "b74093", capital atau tidak tidak masalah
  static Color colorFromHex(String hexValue){
    // note "FF" disini adalah opacity. opacity nya dibuat maksimal, tidak transparan
    hexValue = hexValue.replaceAll("#", "");
    hexValue = hexValue.replaceAll(" ", "");
    var hexInt = int.parse("FF${hexValue.toUpperCase()}", radix: 16);

    return Color(hexInt);
  }

  /// Untuk menghitung size(tinggi dan lebar) dari suatu widget
  static _WidgetSize calculateWidgetSize = _WidgetSize();
}

class _WidgetSize{

  /// mengkalkulasi ukuran dari widget Text() jika dirender
  Size Text(String text, TextStyle style){
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}