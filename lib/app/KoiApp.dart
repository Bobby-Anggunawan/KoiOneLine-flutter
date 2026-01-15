import "package:flutter/material.dart";
import 'package:koi_one_line/koi_one_line.dart';

// TODO!! kalau bisa di KoiApp juga buat fungsi generate builder untuk spinner supaya orang yang gak pakai KoiApp tetap bisa pakai spinnernya

/// Struktur dasar aplikasi, memuat routing, templating, dan lain-lain.
/// > Cara penggunaannya tinggal masukkan saja ke fungsi **main()** di **main.dart**
///
/// **Parameter**
/// * routes: Diisi dengan halaman halaman yang ada di aplikasi ini. Merupakan implementasi dari https://docs.flutter.dev/cookbook/navigation/named-routes
/// * themeColor: Diisi dengan warna yang ingin digunakan aplikasi. Di dalam class ini disimpan 2 jenis theme warna, dark theme dan light theme Umumnya warna yang ditampilkan adalah warna di light theme dan sedangkan dark theme hanya ditampilkan di perangkat mobile jika device di setting dark mode. Merupakan implementasi dari https://m3.material.io/styles/color/the-color-system/key-colors-tones
///
/// **Contoh**
///
/// `main(){runApp(KoiApp(<parameters>))}`
class KoiApp extends StatefulWidget {
  const KoiApp({
    Key? key,
    this.navigatorKey = null,
    this.onGenerateRoute = null,
    this.initState = null,
    this.didChangeDependencies = null,
    required this.routes,
    required this.themeColor,
    this.textTheme = null,
    this.builder = null,
    this.spinner = null,
    this.localizationsDelegates
  }) : super(key: key);

  // tambah navigator key
  final GlobalKey<NavigatorState>? navigatorKey;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;

  /// jalankan fungsi pas halaman ini diinit
  final Function(BuildContext)? initState;
  final Function? didChangeDependencies;

  static ValueNotifier<bool> _isLoading = ValueNotifier(false);
  //start-digunakan toast
  static ValueNotifier<bool> _isShowToast = ValueNotifier(false);
  static ValueNotifier<String> _toastMessage = ValueNotifier("None");
  //end---digunakan toast

  /// kalau true, spinner akan ditampilkan. Kalau false spinner tidak tampil
  static set isLoading(bool value){
    _isLoading.value = value;
  }


  /// menampilkan snackbar.
  static void showSnackBar(
      BuildContext context,
      String content,
      {SnackBarAction? action}
      ){
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(content),
      action: action,
    ),
    );
  }

  /// menampilkan alert dialog sederhana yang hanya terdiri dari teks. gunakan fungsi [showDialog] dari library [flutter/material.dart] untuk menampilkan dialog yang lebih kompleks
  static Future<void> showAlertDialog(
      BuildContext context,
  {
    String? title,
    String? content
  }
      )async{
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: title != null ? Text(title): null,
        content: content != null ? Text(content): null,
      );
    });
  }

  /// menampilkan toast
  ///
  /// **Parameter**
  /// * [message] : pesan yang ditampilkan di toast
  /// * [duration] : berapa detik toast akan ditampilakan. Default 3 detik
  ///
  /// **Ketentuan**
  /// * fungsi ini hanya bisa berjalan jika sedang tidak ada toast yang ditampilkan. Jiak toast masih ditampilkan, fungsi ini akan diabaikan
  ///
  /// **WARNING**
  /// * kalau duration < 1, fungsi ini akan mereturn error
  static void showToast(String message, {int duration = 3}){

    // validasi error
    if(duration < 1){
      throw ArgumentError("duration toast minimal 1 detik, tidak boleh kurang");
    }

    // menampilkan toast
    if(_isShowToast.value == false){
      _toastMessage.value = message;
      _isShowToast.value = true;

      // menyembunyikan toast setelah [duration] detik
      Future.delayed(Duration(seconds: duration), (){
        _isShowToast.value = false;
      });
    }
  }

  //============================================

  /// warna dari template aplikasi ini. Warna saat light mode dan dark mode tersimpan di sini
  ///
  /// **Note**, gunakan constructor [ThemeColor.autoGenerateFromColor()] agar bisa lebih cepat, tidak perlu memikirkan warna lain, hanya perlu memilih warna utama saja
  final ThemeColor themeColor;

  /// typography di aplikasi ini
  final TextTheme? textTheme;

  final KoiAppRoute routes;

  /// builder untuk dimasukkan ke [MaterialApp].
  ///
  /// Terkadang ada library yang perlu ini misalnya: *https://pub.dev/packages/flutter_easyloading*
  final Widget Function(BuildContext, Widget?)? builder;

  /// widget yang ditampilkan sebagai overlay jika sedang loading (variable [isLoading] diset true). Jika null widget [Spinner()] akan ditampilkan
  final Widget? spinner;

  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  @override
  State<KoiApp> createState() => _KoiAppState();
}

class _KoiAppState extends State<KoiApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.initState !=null){
      widget.initState!(context);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    
    if(widget.didChangeDependencies != null){
      widget.didChangeDependencies!();
    }
  }

  @override
  Widget build(BuildContext context) {

    //start-buat ThemeData
    ThemeData lightTheme = ThemeData(
        colorScheme: widget.themeColor.lightTheme,
        textTheme: widget.textTheme
    );

    bool adaDarkTheme = false;
    ThemeData? darkTheme;
    if(widget.themeColor.darkTheme != null){
      adaDarkTheme = true;
    }

    if(adaDarkTheme){
      darkTheme = ThemeData(
          colorScheme: widget.themeColor.darkTheme,
          textTheme: widget.textTheme
      );
    }
    //end---buat ThemeData

    return MaterialApp(
        localizationsDelegates: widget.localizationsDelegates,
        routes: widget.routes.getRoutes(),
        onGenerateRoute: widget.onGenerateRoute,
        theme: lightTheme,
        darkTheme: darkTheme,
        navigatorKey: widget.navigatorKey,
        builder: (context, child){
          if(widget.builder != null){
            child = widget.builder!(context, child);
          }
          return Stack(
            children: [
              child!,
              //DISINI LETAK SPINNERNYA
              ValueListenableBuilder<bool>(
                  valueListenable: KoiApp._isLoading,
                  builder: (BuildContext context, bool value, Widget? child){
                    if(value){
                      return widget.spinner ?? Container(
                        height: KoiLib.getWindowSize.height,
                        width: KoiLib.getWindowSize.width,
                        color: context.koiThemeColor.scrim.withOpacity(0.5),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return SizedBox();
                  }
              ),
              //DISINI LETAK TOASTNYA
              Align(
                alignment: Alignment.bottomCenter,
                child: ValueListenableBuilder<bool>(
                    valueListenable: KoiApp._isShowToast,
                    builder: (BuildContext context, bool value, Widget? child){
                      if(value){
                        return Material(
                          type: MaterialType.transparency,
                          child: Container(
                            padding: EdgeInsets.all(context.koiSpacing.medium),
                            margin: EdgeInsets.only(bottom: context.koiSpacing.xlarge),
                            decoration: BoxDecoration(
                                color: context.koiThemeColor.secondary,
                                borderRadius: BorderRadius.circular(context.koiSpacing.smallest)
                            ),
                            child: Text(
                              KoiApp._toastMessage.value,
                              style: TextStyle(
                                  color: context.koiThemeColor.onSecondary
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    }
                ),
              ),
            ],
          );
        }
    );
  }
}

//============================================================================
// class class yang dipakai

class ThemeColor{

  late ColorScheme lightTheme;
  ColorScheme? darkTheme;

  /// Mengatur warna theme dengan object ColorScheme.
  ///
  /// > Light Theme memang wajib diisi. Jika ingin mengisi Dark Theme, gunakan fungsi [setDarkTheme()]
  ///
  /// **Note**, jika kesulitan membuat object ColorScheme, bisa langsung menggunakan constructor [autoGenerateFromColor()]
  ThemeColor.setLightTheme(ColorScheme themeColor){
    lightTheme = themeColor;
  }

  /// otomatis membuat [ColorScheme] dari sebuah warna. Fungsi ini menghasilkan [ColorScheme] untuk light mode dan dark mode bersamaan.
  ///
  /// **Contoh**
  /// > [ThemeColor.autoGenerateFromColor(Colors.red)]
  ThemeColor.autoGenerateFromColor(Color color){
    lightTheme = ColorScheme.fromSeed(seedColor: color);
    darkTheme = ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark);
  }

  /// fungsi optional untuk mengisi warna theme dark mode.
  ///
  /// **Note**, fungsi ini tidak perlu dipanggil jika object ini dibuat pakai constructor [autoGenerateFromColor()]. Hanya dipanggil jika object ini dibuat dengan constructor [setLightTheme()]
  ThemeColor setDarkTheme(ColorScheme themeColor){
    darkTheme = themeColor;
    return this;
  }
}

/// Routing untuk [KoiApp]
///
/// **Cara menggunakan**:
/// * Gunakan fungsi [addRoutes] untuk memasukkan route
class KoiAppRoute{

  Map<String, WidgetBuilder> _routes = {};

  /// tempat menyimpan semua route di aplikasi ini.
  /// variable ini dibutuhkan di class [StartingApp]
  Map<String, WidgetBuilder> getRoutes(){
    if(_routes.isEmpty){
      throw AssertionError("KoiAppRoute._routes tidak boleh kosong. Tambah route dengan KoiAppRoute.addRoutes()");
    }
    return _routes;
  }


  /// masukkan halaman awal di aplikasi ini. Biasanya yang dimasukkan ke sini adalah halaman Splash Screen
  ///
  /// **Note**, route dari halaman ini otomatis akan jadi "/"
  KoiAppRoute.baseRoute(Widget page){
    _routes["/"] = (context) => page;
  }


  /// digunakan untuk mendaftarkan route baru
  ///
  /// Daftar parameter:
  /// * parameter [route] adalah nama dari route yang ingin dimasukkan, misalnya "/home". Jadi nama wajib dimulai dari "/" atau akan mereturn error
  KoiAppRoute addRoutes(String route, Widget page){
    if(route[0] == "/"){
      _routes[route] = (context) => page;
      return this;
    }
    else{
      throw AssertionError('Parameter route harus dimulai dari karakter "/"');
    }
  }
}