import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:koi_one_line/koi_one_line.dart';

enum _ErrorType{
  Forbidden,
  NotFound,
  NotImplemented,
  ImATeapot,
  Error
}

class KoiPgError extends StatelessWidget {

  KoiPgError.Forbidden({Key? key, this.message, this.resolution}) : errorType = _ErrorType.Forbidden, super(key: key);
  KoiPgError.NotFound({Key? key, this.message, this.resolution}) : errorType = _ErrorType.NotFound, super(key: key);
  KoiPgError.NotImplemented({Key? key, this.message, this.resolution}) : errorType = _ErrorType.NotImplemented, super(key: key);

  /// dont know what error.. just show silly image
  KoiPgError.ImATeapot({Key? key, this.message, this.resolution}) : errorType = _ErrorType.ImATeapot, super(key: key);
  KoiPgError.Error({Key? key, this.message, this.resolution}) : errorType = _ErrorType.Error, super(key: key);

  final _ErrorType errorType;

  /// pesan yang ditampilkan
  final String? message;


  /// widget yang diletakkan dibawah pesan. Dapat berupa petunjuk cara mengatasi error ini
  final Widget? resolution;

  @override
  Widget build(BuildContext context) {

    // APRIL MOP!!!
    if(DateTime.now().month == 4 && DateTime.now().day == 1){
      return _ErrorImATeapot(message: message, resolution: resolution);
    }

    else if(errorType == _ErrorType.Forbidden){
      return _ErrorForbidden(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.NotFound){
      return _ErrorNotFound(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.NotImplemented){
      return _ErrorNotImplemented(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.ImATeapot){
      return _ErrorImATeapot(message: message, resolution: resolution);
    }
    else if(errorType == _ErrorType.Error){
      return _Error(message: message, resolution: resolution);
    }

    throw RangeError("KoiPgError: errorType tidak dikenali");
  }
}

class _ErrorForbidden extends StatelessWidget {
  const _ErrorForbidden({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  final String illustration = "packages/koi_one_line/assets/undraw_access_denied_re_awnf.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 250
                    ),
                    child: SvgPicture.asset(
                        illustration
                    ),
                  ),

                  Text(
                    "Error 403: Forbidden",
                    style: context.koiThemeText.display(size: TextStyleSize.Small),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(height: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _ErrorNotFound extends StatelessWidget {
  const _ErrorNotFound({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  final String illustration = "packages/koi_one_line/assets/undraw_page_not_found_re_e9o6.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 250
                    ),
                    child: SvgPicture.asset(
                        illustration
                    ),
                  ),

                  Text(
                    "Error 404: Not Found",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(height: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _ErrorNotImplemented extends StatelessWidget {
  const _ErrorNotImplemented({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  final String illustration = "packages/koi_one_line/assets/undraw_under_construction_-46-pa.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 250
                    ),
                    child: SvgPicture.asset(
                        illustration
                    ),
                  ),

                  Text(
                    "Error 501: Not Implemented",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(height: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _ErrorImATeapot extends StatelessWidget {
  const _ErrorImATeapot({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  final List<String> illustration = const [
    "packages/koi_one_line/assets/undraw_refreshing_beverage_td3r.svg",
    "packages/koi_one_line/assets/undraw_monster_artist_2crm.svg",
    "packages/koi_one_line/assets/undraw_joyride_re_968t.svg",
    "packages/koi_one_line/assets/undraw_mint_tea_-7-su0.svg",
    "packages/koi_one_line/assets/undraw_decide_re_ixfw.svg",
    "packages/koi_one_line/assets/undraw_quick_chat_re_bit5.svg",
    "packages/koi_one_line/assets/undraw_taken_re_yn20.svg",
    "packages/koi_one_line/assets/undraw_happy_music_g6wc.svg",
    "packages/koi_one_line/assets/undraw_walk_dreaming_u-58-a.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 250
                    ),
                    child: SvgPicture.asset(
                        illustration.koiGetRandomElement
                    ),
                  ),

                  Text(
                    "Error 418: Don't mind me.. I'm a teapot.",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(height: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key, required this.message, required this.resolution}) : super(key: key);

  final String? message;
  final Widget? resolution;

  final String illustration = "packages/koi_one_line/assets/undraw_fixing_bugs_w7gi.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
          child: Center(
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 250
                    ),
                    child: SvgPicture.asset(
                        illustration
                    ),
                  ),

                  Text(
                    "Error!!",
                    style: context.koiThemeText.display(size: TextStyleSize.Large),
                  ),

                  Builder(builder: (context){
                    if(message != null){
                      return Text(
                        message!,
                        style: context.koiThemeText.display(size: TextStyleSize.Small),
                      );
                    }
                    return Container();
                  }),

                  resolution
                ].koiRemoveNull<Widget>().koiAddBetweenElement(
                    SizedBox(height: context.koiSpacing.autoBeetweenPane,)
                ),
              ),
            ),
          ),
        )
    );
  }
}