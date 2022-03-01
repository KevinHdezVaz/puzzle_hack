import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:puzle_hack/generated/l10n.dart';
import 'package:puzle_hack/src/domain/models/move_to.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/juego_controlador.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/%20customSolumath2.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/fondo.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/botones_game.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/interacciones_puzz.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/puzzle_options.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/moviento_tiempo.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/ganador.dart';
import 'package:puzle_hack/src/ui/utils/responsive.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  void _onKeyBoardEvent(BuildContext context, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final moveTo = event.logicalKey.keyLabel.moveTo;
      if (moveTo != null) {
        context.read<GameController>().onMoveByKeyboard(moveTo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.6;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final responsive = Responsive.of(context);
    final width = responsive.width;
    return ChangeNotifierProvider(
      create: (_) {
        final controller = GameController();
        controller.onFinish.listen(
          (_) {
            Timer(
              const Duration(
                milliseconds: 200,
              ),
              () {
                showWinnerDialog(
                  context,
                  moves: controller.state.moves,
                  time: controller.time.value,
                );
              },
            );
          },
        );
        return controller;
      },
      builder: (context, child) => RawKeyboardListener(
        autofocus: true,
        includeSemantics: false,
        focusNode: FocusNode(),
        onKey: (event) => _onKeyBoardEvent(context, event),
        child: child!,
      ),
      child: GameBackground(
        child: Stack(
          children: [
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 80,
              numberOfParticles: 50,
              speedOfParticles: 1,
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: true,
              particleColor: Colors.white.withAlpha(50),
              awayAnimationDuration: Duration(milliseconds: 400),
              maxParticleSize: 7,
              isRandSize: true,
              isRandomColor: true,
              randColorList: [
                Colors.white.withAlpha(200),
                Colors.green.withAlpha(100)
              ],
              awayAnimationCurve: Curves.bounceInOut,
              enableHover: true,
              hoverColor: Colors.blueAccent,
              hoverRadius: 50,
              connectDots: false,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: OrientationBuilder(
                  builder: (_, orientation) {
                    final isPortrait = orientation == Orientation.portrait;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppBar(
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15, top: 0),
                              child: IconButton(
                                icon: Icon(Icons.info),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomSolumath(
                                          title: "FLUTTER PUZZLE HACK",
                                          descriptions: S.current.flutter,
                                          text: S.current.salir,
                                        );
                                      });
                                },
                              ),
                            ),
                          ],
                          title: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                'Puzzle Mania',
                                style: TextStyle(fontFamily: 'Keyboard-Icon'),
                              )),
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40))),
                        ),

                        //agregar scaffold
                        Expanded(
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              final height = constraints.maxHeight;
                              final puzzleHeight =
                                  (isPortrait ? height * 0.45 : height * 0.5)
                                      .clamp(250, 700)
                                      .toDouble();
                              final optionsHeight =
                                  (isPortrait ? height * 0.25 : height * 0.2)
                                      .clamp(120, 200)
                                      .toDouble();

                              return SizedBox(
                                height: height,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: optionsHeight,
                                        child: PuzzleOptions(
                                          width: width,
                                        ),
                                      ),SizedBox(
                                        height: 10,
                                      ),
                                      Divider( 
                                        
                                        thickness: 2,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      const GameButtons(),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: SizedBox(
                                          height: puzzleHeight,
                                          child: const AspectRatio(
                                            aspectRatio: 1,
                                            child: PuzzleInteractor(),
                                          ),
                                        ),
                                      ),
                                      const TimeAndMoves(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
