import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:provider/provider.dart';
import 'package:puzle_hack/generated/l10n.dart';
import 'package:puzle_hack/src/ui/pages/game/1vs1/botones_game2.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/juego_controlador.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/%20customSolumath2.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/botones_game.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/fondo.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/ganador.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/interacciones_puzz.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/moviento_tiempo.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/puzzle_options.dart';
import 'package:puzle_hack/src/ui/utils/responsive.dart';

import 'interacciones_puzz2.dart';

class SegundaPantalla extends StatefulWidget { 

  const SegundaPantalla({Key? key}) : super(key: key);

  @override
  State<SegundaPantalla> createState() => _SegundaPantallaState();
}

class _SegundaPantallaState extends State<SegundaPantalla> {
  void _onKeyBoardEvent(BuildContext context, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
    
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

          
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: OrientationBuilder(
                  builder: (_, orientation) {
                    final isPortrait = orientation == Orientation.portrait;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ 
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
                                      
                                     
                                      const TimeAndMoves(),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          height: puzzleHeight,
                                          child: const AspectRatio(
                                            aspectRatio: 3,
                                            child: PuzzleInteractor2(),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.orange,
                                        thickness: 2,
                                      ),
                                        Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          height: puzzleHeight,
                                          child: const AspectRatio(
                                            aspectRatio: 3,
                                            child: PuzzleInteractor(),
                                          ),
                                        ),
                                      ),
                                      const GameButtons2(),
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

class _onKeyBoardEvent {
}
