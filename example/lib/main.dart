import 'package:example/tets.dart';
import 'package:flutter/material.dart';
import 'package:koi_one_line/app/koi_app.dart';
import 'package:koi_one_line/koi_one_line.dart';

/*
Future<bool> initFun()async{
  await Future.delayed(Duration(seconds: 10));
  return true;
}*/

void main() {
  runApp(
    KoiApp(
        routes: KoiAppRoute
            .baseRoute(
              // init page that will be shown right after user open your app
              // you can use your own widget here, usually as splash screen
              // but here, we will be using default splash screen from this library: KoiPgSplash
              KoiPgSplash.redirectAfterFunction(
                initialization: Future<bool>(()async{
                  // you can wrote your own code here to initialized your app before user open it.
                  // for example you want to check user login or not
                  // then you open login page if user not login
                  // or you open home page if user login.
                  // in this example, i just simply wait for 3 second before open home page.
                  await Future.delayed(Duration(seconds: 3));

                  //if return false, splash will not redirrect to home page
                  return true;
                }),
                // redirect to this page after initialization finish.
                // makes sure you register this route using addRoutes("/home", Test())
                redirectTo: "/home"
              )
            )
            // all other pahes your app have
            .addRoutes("/home", Test()),
        // build your own theme color here using ThemeColor class
        themeColor: ThemeColor.autoGenerateFromColor(Colors.blue)
    )
  );
}