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
    required this.backgroundColor,
    this.itemMenuAspectRatio = 1/1,
    this.badge = null
  }) : super(key: key);

  // sebaiknya gunakan widget Badge()
  final Widget? badge;

  final Widget icon;
  final String name;
  final String? routeName;
  final Function? onClick;
  final Color backgroundColor;

  final double itemMenuAspectRatio;

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
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: itemMenuAspectRatio,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.koiSpacing.medium),
                      child: icon,
                      decoration: BoxDecoration(
                        border: Border.all(color: context.koiThemeColor.outline),
                        borderRadius: BorderRadius.circular(context.koiSpacing.medium),
                        color: backgroundColor,
                      ),
                    ),
                    Builder(builder: (context){
                      if(badge == null){
                        return SizedBox();
                      }
                      else{
                        return badge!;
                      }
                    })
                  ],
                ),
              ),
              SizedBox(height: context.koiSpacing.small,),
              Text(name, style: context.koiThemeText.label().copyWith(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}