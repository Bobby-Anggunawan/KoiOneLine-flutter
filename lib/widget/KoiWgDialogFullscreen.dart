import "package:flutter/material.dart";
import 'package:koi_one_line/koi_one_line.dart';


/// untuk menampilkan fullscreen dialog sesuai style dari material design. Sama seperti daterange picker
///
/// **Note**, gunakan fungsi showDialog() untuk memanggil dialog ini
///
/// **Note2**, dapat juga menggunakan fungsi [show()] di dalam widget ini untuk menampilkan dialog ini
class KoiWgDialogFullscreen extends StatelessWidget {
  const KoiWgDialogFullscreen({
    Key? key,
    required this.content,
    required this.title,
    required this.onConfirm,
    this.confirmButtonText = "Confirm",
    this.confirmButtonIcon = Icons.edit,
    this.subtitle = null,
    this.backgroundColor = null
  }) : super(key: key);

  /// fungsi yang dijalankan kalau tombol confirm ditekan
  /// isikan ini dengan nul kalau mau buat dialog tanpa tombol ini
  final Function? onConfirm;

  /// subtitle optional yang menjelaskan isi dialog
  final String? subtitle;

  /// judul dialog
  final String title;

  /// isi dialog
  final Widget content;

  /// judul dari tombol confirm/tombol ok. Defaultrnya adalah "Confirm"
  final String confirmButtonText;
  /// icon dari tombol confirm/tombol ok. Defaultrnya adalah [Icons.edit]
  final IconData confirmButtonIcon;

  /// background color untuk dialog ini.
  ///
  /// Defaultmya [context.koiThemeColor.primaryContainer]
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: backgroundColor ?? context.koiThemeColor.primaryContainer,
      child: Padding(
        padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
        child: Column(
          children: [
            // bagian teratas (tombol tutup dan tombol simpan)
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: context.koiThemeColor.onPrimaryContainer,
                    )
                ),

                Expanded(child: Container()),

                Builder(builder: (context){
                  if(onConfirm != null){
                    return TextButton.icon(
                      onPressed: (){
                        onConfirm!();
                      },
                      style: ButtonStyle(
                          iconColor: MaterialStateProperty.resolveWith((states){
                            return context.koiThemeColor.onPrimaryContainer;
                          })
                      ),
                      label: Text(
                        confirmButtonText,
                        style: TextStyle(
                            color: context.koiThemeColor.onPrimaryContainer
                        ),
                      ),
                      icon: Icon(confirmButtonIcon),
                    );
                  }
                  else{
                    return SizedBox();
                  }
                }),
              ],
            ),

            Padding(padding: EdgeInsets.only(top: context.koiSpacing.autoBeetweenPane)),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                    padding: EdgeInsets.only(left: context.koiSpacing.autoBeetweenPane*3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          subtitle?.toUpperCase() ?? "",
                          style: context.koiThemeText.body(size: TextStyleSize.Small).apply(color: context.koiThemeColor.onPrimaryContainer),
                        ),

                        Padding(padding: EdgeInsets.only(top: context.koiSpacing.smallest)),

                        Text(
                          title,
                          style: context.koiThemeText.title(size: TextStyleSize.Large).apply(color: context.koiThemeColor.onPrimaryContainer,),
                        ),
                      ],
                    )
                ),

                Padding(padding: EdgeInsets.only(top: context.koiSpacing.medium)),

                Divider(),
              ],
            ),

            Expanded(child: content)
          ],
        ),
      ),
    );
  }

  /// fungsi untuk menampilkan dialog ini
  Future<dynamic> show(BuildContext context){
    return showDialog(context: context, builder: (context){
      return this;
    });
  }
}