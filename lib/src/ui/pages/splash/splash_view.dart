import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:puzle_hack/src/data/repositories_impl/images_repository_impl.dart';
import 'package:puzle_hack/src/ui/menuprin/menu.dart';
 import 'package:puzle_hack/src/ui/pages/splash/circle_transition_clipper.dart';
  import 'package:puzle_hack/src/ui/utils/responsive.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    );
    _controller.forward();
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Timer(
            const Duration(seconds: 2),
            _goToGame,
          );
        }
      },
    );
    _setDeviceOrientation();
  }

  void _goToGame() {
    final route = PageRouteBuilder(
      pageBuilder: (_, animation, secondaryAnimation) =>   MenuPrincipal(),
      //gameview
      transitionDuration: const Duration(milliseconds: 3000),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        final size = MediaQuery.of(context).size;

        final radiusTween = Tween<double>(
          begin: 0.0,
          end: size.height,
        );

        return ClipPath(
          clipper: CircleTransitionClipper(
            center: Offset(
              size.width * 0.5,
              size.height * 0.5,
            ),
            radius: animation.drive(radiusTween).value,
          ),
          child: child,
        );
      },
    );
    Navigator.pushReplacement(context, route);
  }

  void _setDeviceOrientation() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        var shortestSide = MediaQuery.of(context).size.shortestSide;

        final bool useMobileLayout = shortestSide < 600;
        if (useMobileLayout) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitDown,
              DeviceOrientation.portraitUp,
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final options = puzzleOptions.getRange(
      1,
      puzzleOptions.length,
    );

    final half = options.length ~/ 2;
    final responsive = Responsive.of(context);

    return Scaffold(
      //TEMA OSCURO O LIGHT
      backgroundColor: Colors.blue[200],
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: OrientationBuilder(
          builder: (_, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            final size = responsive.dp(isPortrait ? 10 : 7);
            final bottom = responsive.hp(30);
            final titleSize = responsive.dp(5);

            return AnimatedBuilder(
              animation: _animation,
              builder: (_, jungle) {
                final offset = _animation.value;
                final dx = -size * 0.3 - (size * 0.7 - offset * size * 0.7);

                return Stack(
                  children: [
                    CircularParticle(
                      key: UniqueKey(),
                      awayRadius: 80,
                      numberOfParticles: 100,
                      speedOfParticles: 1,
                      height: screenHeight,
                      width: screenWidth,
                      onTapAnimation: true,
                      particleColor: Colors.white.withAlpha(150),
                      awayAnimationDuration: Duration(milliseconds: 600),
                      maxParticleSize: 5,
                      isRandSize: true,
                      isRandomColor: true,
                    
                      randColorList: [
                     
                         Colors.blue,
                          Colors.green,
                      ],
                      awayAnimationCurve: Curves.bounceInOut,
                      enableHover: true,
                      hoverColor: Colors.white,
                      hoverRadius: 50,
                      connectDots: true, //not recommended
                    ),
                 
                    Center(
                      child: Transform.scale(
                        scale: offset.clamp(0.5, 1),
                        child: Opacity(
                          opacity: offset.clamp(0, 1),
                          child: Text(
                            "PUZZLE \n MANIA",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                              height: 0.9,
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    
                  ],
                );
              },
          
            );
          },
        ),
      ),
    );
  }
}
