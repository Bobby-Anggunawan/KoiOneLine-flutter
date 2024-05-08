import 'package:flutter/material.dart';


enum AppBarTipe{
  AppbarClose
}
class KoiWgAppBar extends StatelessWidget implements PreferredSizeWidget {

  /// appbar dengan satu close button
  KoiWgAppBar.close({Key? key, required Function onClose}):
        preferredSize = Size.fromHeight(kToolbarHeight),
        type = AppBarTipe.AppbarClose,
        action = [
          IconButton(onPressed: (){onClose();}, icon: Icon(Icons.close))
        ];

  final AppBarTipe type;
  final List<Widget> action;

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: action,
    );
  }
}
