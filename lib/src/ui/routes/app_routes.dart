import 'package:flutter/material.dart';
import 'package:puzle_hack/src/ui/pages/game/vista_juego.dart';
 import 'package:puzle_hack/src/ui/pages/splash/splash_view.dart';
import 'package:puzle_hack/src/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (_) => const SplashView(),
    Routes.game: (_) => const GameView(), 

    // ignore: equal_keys_in_map
    //Routes.splashscreen: (_) => MainBatmanSignupApp(),
  };
}
