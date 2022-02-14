import 'package:flutter/material.dart';
import 'package:puzle_hack/src/ui/pages/game/game_view.dart';
import 'package:puzle_hack/src/ui/pages/privacy/privacy_view.dart';
import 'package:puzle_hack/src/ui/pages/splash/splash_view.dart';
import 'package:puzle_hack/src/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (_) => const SplashView(),
    Routes.game: (_) => const GameView(),
    Routes.privacy: (_) => const PrivacyView(),


    // ignore: equal_keys_in_map
    //Routes.splashscreen: (_) => MainBatmanSignupApp(),
  };
}
