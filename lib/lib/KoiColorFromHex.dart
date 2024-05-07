import 'package:flutter/material.dart';

/// generate warna dari string hex. Flutter tidak menyediakan cara default untuk buat warna dari hex
///
/// **Parameter**
/// * [hexValue] : hex value dari warna yang dibuat. misalnya "B74093" atau "b74093", capital atau tidak tidak masalah
Color colorFromHex(String hexValue){
  // note "FF" disini adalah opacity. opacity nya dibuat maksimal, tidak transparan
  hexValue = hexValue.replaceAll("#", "");
  hexValue = hexValue.replaceAll(" ", "");
  var hexInt = int.parse("FF${hexValue.toUpperCase()}", radix: 16);

  return Color(hexInt);
}