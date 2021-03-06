import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzle_hack/generated/l10n.dart';
import 'package:puzle_hack/src/ui/global/widgets/my_text_icon_button.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/juego_controlador.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/estado_juego.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/dialogoConfi.dart';
import 'package:puzle_hack/src/ui/utils/colors.dart';
import 'package:puzle_hack/src/ui/utils/dark_mode_extension.dart';
import 'package:puzle_hack/src/ui/utils/responsive.dart';
import 'package:provider/provider.dart';

class GameButtons extends StatelessWidget {
  const GameButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final state = controller.state;
    final isDarkMode = context.isDarkMode;
    final responsive = Responsive.of(context);
    final buttonHeight = responsive.dp(3).clamp(kMinInteractiveDimension, 100).toDouble();

    return Padding(
      padding: const EdgeInsets.all(10).copyWith(
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
             decoration: BoxDecoration(
              color: Colors.blue.withAlpha(500),
              borderRadius: BorderRadius.circular(30),
            ),
            child: MyTextIconButton(
              height: buttonHeight,
              onPressed: () => _reset(context),
              icon: const Icon(
                
                Icons.not_started_outlined,
              ),

              label: state.status == GameStatus.created ? S.current.start : S.current.restart,
            ),
          ),
          const SizedBox(width: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(50),
              borderRadius: BorderRadius.circular(30),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                itemHeight: buttonHeight,
                dropdownColor: (  lightColor).withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                icon: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color:  darkColor,
                    ),
                  ),
                ),
                items: [3, 4, 5 ]
                    .map(
                      (e) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ).copyWith(left: 15),
                          child: Text(
                            "${e}x$e ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : darkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (crossAxisCount) {
                  if (crossAxisCount != null && crossAxisCount != state.crossAxisCount) {
                    controller.changeGrid(
                      crossAxisCount,
                      controller.puzzle.image,
                    );
                  }
                },
                value: state.crossAxisCount,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _reset(BuildContext context) async {
    final controller = context.read<GameController>();
    final state = controller.state;
    if (state.moves == 0 || state.status == GameStatus.solved) {
      controller.shuffle();
    } else {
      final isOk = await showConfirmDialog(context);
      if (isOk) {
        controller.shuffle();
      }
    }
  }
}
