import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:koi_one_line/extension/FromBuildContext.dart';
import 'package:koi_one_line/extension/FromDateTime.dart';
import 'package:koi_one_line/extension/FromList.dart';
import 'package:koi_one_line/page/KoiPgForm.dart';

/// widget untuk menjelaskan point point secara detail. Bisa digunakan untuk menjelaskan fitur aplikasi atau menjelaskan data yang dipakai di aplikasi ini(privacy policy)
class KoiPgPoints extends StatefulWidget {
  const KoiPgPoints({super.key, required this.page, required this.onComplete});

  /// point point yang ingin dijelaskan
  final List<PointPage> page;

  /// yang terjadi setelah klik tombol ok di akhir point
  final Function? onComplete;

  @override
  State<KoiPgPoints> createState() => _KoiPgPointsState();
}

class _KoiPgPointsState extends State<KoiPgPoints> {

  _PageDotCon con = _PageDotCon();

  int initPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: widget.page[initPage]
        ),
        Row(
          children: [
            Expanded(
                child: Builder(builder: (context){
                  if(initPage > 0){
                    return TextButton(onPressed: (){
                      initPage -= 1;
                      con.setPage(initPage);
                      setState(() {});
                    }, child: Text("Previous"));
                  }

                  return SizedBox();
                })
            ),
            Expanded(
                child: Center(
                  child: _PageDot(pageNumber: widget.page.length, controller: con,),
                )
            ),
            Expanded(
                child: Builder(builder: (context){
                  if(initPage < widget.page.length-1){
                    return TextButton(onPressed: (){
                      initPage += 1;
                      con.setPage(initPage);
                      setState(() {});
                    }, child: Text("Next"));
                  }

                  else if(initPage == widget.page.length-1){
                    if(widget.onComplete != null){
                      return TextButton(onPressed: (){
                        widget.onComplete!();
                      }, child: Text("Next"));
                    }
                  }

                  return SizedBox();
                })
            ),
          ],
        ),

        /// cuma untuk supaya tombol next dan previous tidak terlalu dempet ke bawah
        SizedBox(height: context.koiSpacing.autoFromScreenEdge,)
      ],
    );
  }
}


class PointPage extends StatelessWidget {
  const PointPage({
    super.key,

    this.icon = null,
    required this.title,
    required this.subtitle,
    this.illustration,
    this.helpIcon = Icons.help,
    this.helpIconClicked = null,

    this.background = null
  });

  final Widget? background;

  /// icon yangt ditmpilkan di tengah diatas judul
  final IconData? icon;
  final String title;
  final String subtitle;

  final Widget? illustration;

  /// icon help di pojok kanan atas
  final IconData helpIcon;
  /// icon help di pojok kanan atas. kalau ini null, icon help ini tidak akan ditampilkan
  final Function? helpIconClicked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background ?? SizedBox(),
        Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Column(
            children: [
              Builder(builder: (context){
                if(helpIconClicked!=null){
                  return Row(
                    children: [
                      Expanded(child: SizedBox()),
                      IconButton(onPressed: (){
                        helpIconClicked!();
                      }, icon: Icon(helpIcon))
                    ],
                  );
                }
                return SizedBox();
              }),

              Builder(builder: (context){
                if(icon!=null){
                  return Icon(icon, color: context.koiThemeColor.primary,);
                }
                return SizedBox();
              }),

              Text(title, style: context.koiThemeText.title(),),

              Row(
                children: [
                  Expanded(child: Text(subtitle, style: context.koiThemeText.body(), textAlign: TextAlign.center,))
                ],
              ),

              Expanded(
                  child: Builder(builder: (context){
                    return SingleChildScrollView(
                      child: illustration,
                    ) ?? SizedBox();
                  })
              ),
            ].koiAddBetweenElement(SizedBox(height: context.koiSpacing.autoBeetweenPane,)),
          ),
        )
      ],
    );
  }
}



class _PageDot extends StatefulWidget {
  const _PageDot({super.key, required this.pageNumber, required this.controller});

  /// berapa banyak page dan dot yang harus dibuat
  final int pageNumber;

  final _PageDotCon controller;

  @override
  State<_PageDot> createState() => _PageDotState();
}
class _PageDotCon{
  void setPage(int page){
    onSetPage!(page);
  }

  Function(int)? onSetPage;
}


class _PageDotState extends State<_PageDot> {

  int activePage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.onSetPage = (page){
      activePage = page;
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(widget.pageNumber, (pageIndex){
          if(pageIndex == activePage){
            return Badge(
              smallSize: 8,
              backgroundColor: context.koiThemeColor.primary,
            );
          }

          return Badge(
            backgroundColor: context.koiThemeColor.outline,
          );
        }).koiAddBetweenElement(
          SizedBox(width: context.koiSpacing.autoBetweenCard,)
        ),
      ),
    );
  }
}