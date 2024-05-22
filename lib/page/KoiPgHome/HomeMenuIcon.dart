import 'package:flutter/material.dart';
import 'package:koi_one_line/extension/FromBuildContext.dart';


enum MenuType{
  grid,
  list
}

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
    this.badge = null,
    this.type = MenuType.grid
  }) : super(key: key);

  // sebaiknya gunakan widget Badge()
  final Widget? badge;

  final Widget icon;
  final String name;
  final String? routeName;
  final Function? onClick;
  final Color backgroundColor;

  /// kalau grid atau list
  final MenuType type;

  HomeMenuIcon copyWith({
    Widget? badge = null,
    Widget? icon = null,
    String? name = null,
    String? routeName = null,
    Function? onClick = null,
    Color? backgroundColor = null,
    MenuType? type = null,
  }){
    return HomeMenuIcon(
      badge : badge ?? this.badge,
      icon : icon ?? this.icon,
      name : name ?? this.name,
      routeName : routeName ?? this.routeName,
      onClick : onClick ?? this.onClick,
      backgroundColor : backgroundColor ?? this.backgroundColor,
      type : type ?? this.type,
    );
  }

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
      child: Builder(builder: (context){
        if(type == MenuType.grid){
          return AspectRatio(
            aspectRatio: 1/1,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  AspectRatio(
                    aspectRatio: 2.3/1,
                    child: Center(
                      // aspect ratio kedua biar ukuran icon jadi setengah ukuran parent :v
                      child: AspectRatio(
                        aspectRatio: 1/1,
                        child: Stack(
                          children: [

                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(context.koiSpacing.medium),
                                ),
                                height: double.infinity,
                                width: double.infinity,
                                child: icon,
                              ),
                            ),

                            Align(
                              alignment: Alignment.topRight,
                              child: badge,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: context.koiSpacing.medium,),

                  Text(name, style: context.koiThemeText.label().copyWith(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          );
        }
        else if(type == MenuType.list){
          return Row(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(context.koiSpacing.medium),
                    ),
                    height: 50,
                    width: 50,
                    child: icon,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: badge,
                  ),
                ],
              ),
              SizedBox(width: context.koiSpacing.medium,),
              Text(name, style: context.koiThemeText.label().copyWith(fontWeight: FontWeight.bold))
            ],
          );
        }
        else{
          throw UnimplementedError("menu ini belum diimplementasikan di HomeMenuIcon.dart");
        }
      },),
    );
  }
}