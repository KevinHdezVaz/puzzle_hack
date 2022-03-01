import 'package:flutter/material.dart';
import 'package:puzle_hack/src/ui/pages/game/1vs1/estado_juego2.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/juego_controlador.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/estado_juego.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/tituo_puzzle.dart';
import 'package:puzle_hack/src/ui/utils/colors.dart';
import 'package:puzle_hack/src/ui/utils/dark_mode_extension.dart';
import 'package:provider/provider.dart';

class PuzzleInteractor2 extends StatelessWidget {
  const PuzzleInteractor2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white30,
              Colors.white,
            ],
          ),
          color: lightColor.withOpacity(0.9),
          border: Border.all(color: Colors.blue),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), 
              
              // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = context.watch<GameController>();
          final state = controller.state;
          final tileSize = constraints.maxWidth / state.crossAxisCount;

          final puzzle = state.puzzle;
//BLOQUEAR QUE SEA TACTIL
          return AbsorbPointer(
            absorbing: state.status != GameStatus2.playing,
            child: Stack(
              children: puzzle.tiles
                  .map(
                    (r) => PuzzleTile(
                      tile: r,
                      size: tileSize,
                      gameStatus: state.status,
                      showNumbersInTileImage: state.crossAxisCount > 4,
                      onTap: () => controller.onTileTapped(r),
                      imageTile: puzzle.segmentedImage != null
                          ? puzzle.segmentedImage![r.value - 1]
                          : null,
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
