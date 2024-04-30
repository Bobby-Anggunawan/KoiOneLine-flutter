import 'package:flutter/material.dart';
import 'dart:ui';

/// lebar dan tinggi window/layar tempat aplikasi ini berada dalam satuan dp.
///
/// > Sebenarnya sama dengan **[MediaQuery.of(context).size.width]**, hanya saja yang ini tidak perlu context.
///
/// **Sumber**
///
/// *https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width*
Size get KoiGetWindowSize{
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  Size size = view.physicalSize / view.devicePixelRatio;

  return size;
}