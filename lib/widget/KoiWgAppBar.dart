import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
    if(type == AppBarTipe.AppbarClose){
      return AppBar(
        actions: action,
        automaticallyImplyLeading: false,
      );
    }
    else{
      throw MissingPluginException("KoiWgAppBar: type belum diimplementasikan");
    }
  }
}
