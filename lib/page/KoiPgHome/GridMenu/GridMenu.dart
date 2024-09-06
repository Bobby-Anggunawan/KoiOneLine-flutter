import 'package:flutter/material.dart';
import 'package:koi_one_line/app/koi_app.dart';

import '../HomeMenuIcon.dart';

class GridMenu extends StatelessWidget {
  const GridMenu({Key? key, this.header = null, required this.menu, required this.appBar, this.background = null}) : super(key: key);

  final PreferredSizeWidget appBar;
  final List<HomeMenuIcon> menu;
  final Widget? background;
  final Widget? header;

  Widget buildMenu(int crossAxisCount){
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      children: menu,
      physics: const NeverScrollableScrollPhysics()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [

          Builder(builder: (context){
            if(background != null){
              return background!;
            }
            else{
              return SizedBox();
            }
          }),

          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context){
                  if(header != null){
                    return header!;
                  }
                  else{
                    return SizedBox();
                  }
                }),
                KoiAppResponsive(
                  updateWhenResize: true,
                  screenPhone: buildMenu(2),
                  screenTablet: buildMenu(4),
                  screenLaptop: buildMenu(5),
                  screenDesktop: buildMenu(6),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
