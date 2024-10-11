import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:koi_one_line/extension/FromList.dart";


/// builder untuk membuat halaman splashscreen.
/// biar tidak terus terus membuat splashscreen berulang kali tiap buat aplikasi baru
class KoiPgSplash extends StatefulWidget {
  const KoiPgSplash({Key? key, this.content, this.initialization, this.redirectTo, this.redirectAfter}) : super(key: key);

  /// redirect ke dalam aplikasi setelah sekian detik
  const KoiPgSplash.redirectAfterSecond({Key? key, required int redirectAfter, this.redirectTo, this.content}) : initialization = null, redirectAfter = redirectAfter, super(key: key);

  /// redirect ke dalam aplikasi setelah fungsi ini selesai
  ///
  /// **initialization** adalah fungsi yang dieksekusi di splash screen sebelum di redirect ke halaman lain
  /// **NOTE**
  ///
  /// * Sebaiknya diakhir fungsi ini redirect ke halaman lain. Kalau tidak, halaman ini akan terus ditampilkan
  /// * return false kalau tidak jadi redirect
  const KoiPgSplash.redirectAfterFunction({Key? key, required Future<bool?> initialization, this.redirectAfter, required String redirectTo, this.content}) : redirectTo = redirectTo, initialization = initialization, super(key: key);

  /// apa yang ditampilkan selama splash screen. Jika ini null, maka widget default akan ditampilkan
  final Widget? content;

  /// fungsi yang dieksekusi di splash screen sebelum di redirect ke halaman lain
  ///
  /// **NOTE**
  ///
  /// * Sebaiknya diakhir fungsi ini redirect ke halaman lain. Kalau tidak, halaman ini akan terus ditampilkan
  /// * return false kalau tidak jadi redirect
  final Future<bool?>? initialization;

  /// optional, path pada route kemana user akan diarahkan saat fungsi [initialization] selesai. Jadi ini hanya diisi jika [initialization] tidak null. Jika [initialization] dan variable ini diisi, tidak ada yang akan terjadi
  final String? redirectTo;

  /// redirect setelah x detik. Kalau ini diisi, sebaiknya initialization tidak diisi. Jika keduanya diisi, yang selesai lebih dulu yang akan dijalankan
  final int? redirectAfter;

  @override
  State<KoiPgSplash> createState() => _KoiPgSplashState();
}

class _KoiPgSplashState extends State<KoiPgSplash> {

  late Timer atimer;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    if(widget.initialization != null){
      //start timer
      bool timerSelesai = false;
      if(widget.redirectAfter != null){
        Timer(
            Duration(seconds: widget.redirectAfter!),
                (){
              timerSelesai = true;
            }
        );
      }
      else{
        timerSelesai = true;
      }

      /// jalankan fungsi

      widget.initialization!.then((value){
        // periksa tiap detik apa timer selesai
        atimer = Timer.periodic(
            Duration(seconds: 1),
                (time){
              if(timerSelesai){
                time.cancel();
                if(widget.redirectTo != null && value != false){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, widget.redirectTo!);
                }
              }
            }
        );
      });
    }

    else if(widget.redirectAfter != null){
      Timer(
          Duration(seconds: widget.redirectAfter!),
              (){
            if(widget.redirectTo != null){

              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, widget.redirectTo!);
            }
          }
      );
    }
  }

  @override
  void dispose() {

    atimer.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.content ?? _DefaultSplash(),
    );
  }
}


class _DefaultSplash extends StatelessWidget {
  const _DefaultSplash({Key? key}) : super(key: key);

  final List<String> illustration = const [
    "packages/koi_one_line/assets/undraw_loading_re_5axr.svg",
    "packages/koi_one_line/assets/undraw_synchronize_re_4irq.svg",
    "packages/koi_one_line/assets/undraw_problem_solving_re_4gq3.svg",
    "packages/koi_one_line/assets/undraw_counting_stars_re_smvv.svg",
    "packages/koi_one_line/assets/undraw_back_home_nl-5-c.svg",
    "packages/koi_one_line/assets/undraw_winter_road_mcqj.svg",
    "packages/koi_one_line/assets/undraw_dream_world_re_x2yl.svg",
    "packages/koi_one_line/assets/undraw_dreamer_re_9tua.svg",
    "packages/koi_one_line/assets/undraw_step_to_the_sun_nxqq.svg",
    "packages/koi_one_line/assets/undraw_logic_re_nyb4.svg",
    "packages/koi_one_line/assets/undraw_donut_love_kau1.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        illustration.koiGetRandomElement
    );
  }
}
