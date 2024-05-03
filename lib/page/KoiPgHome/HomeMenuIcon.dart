import 'package:flutter/material.dart';
import 'package:koi_one_line/extension/FromBuildContext.dart';

/// class untuk membuat icon menu
/// tersedia 2 konstruktor, default HomeMenuIcon()
/// dan constructor HomeMenuIcon.Custom() untuk membuat tombol custom
class HomeMenuIcon extends StatelessWidget {
  const HomeMenuIcon({
    Key? key,
    required this.icon,
    required this.routeName,
    required this.name,
    required this.onClick,
    required this.backgroundColor
  }) : super(key: key);


  final Widget icon;
  final String name;
  final String? routeName;
  final Function? onClick;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        if(onClick != null){
          onClick!();
        }
        if(routeName != null){
          Navigator.pushNamed(context, routeName!);
        }
      },
      child: Container(
        child: AspectRatio(
          aspectRatio: 1,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(context.koiSpacing.medium),
                  child: icon,
                  decoration: BoxDecoration(
                      border: Border.all(color: context.koiThemeColor.outline),
                      borderRadius: BorderRadius.circular(context.koiSpacing.small),
                      color: backgroundColor,
                  ),
                ),
                Text(name)
              ],
            ),
          ),
        ),
      ),
    );
  }
}