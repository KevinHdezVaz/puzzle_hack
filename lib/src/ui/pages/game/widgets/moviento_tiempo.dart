import 'package:flutter/material.dart';
import 'package:puzle_hack/generated/l10n.dart';
import 'package:puzle_hack/src/ui/global/widgets/max_text_scale_factor.dart';
import 'package:puzle_hack/src/ui/icons/puzzle_icons.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/juego_controlador.dart';
import 'package:puzle_hack/src/ui/utils/time_parser.dart';
import 'package:provider/provider.dart';

/// widget to show the time and the moves counter
class TimeAndMoves extends StatelessWidget {
  const TimeAndMoves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );

    final time = Provider.of<GameController>(context, listen: false).time;
    return MaxTextScaleFactor(
      max: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: time,
              builder: (_, time, icon) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Row(
                        children: [
                          icon!,
                          Text(
                            " ${parseTime(time)}",
                            style: textStyle,
                          ),
                        ],

                        
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.timer_outlined,
                                color: Colors.white70,
                size: 25,
              ),
            ),



            Selector<GameController, int>(
              builder: (_, moves, icon) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(200),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SizedBox(
                     height: 50,
                      width: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        icon!,
                        const SizedBox(width: 20),
                        Text(

                          "$moves",
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
              selector: (_, controller) => controller.state.moves,
              child: const Icon(
                Icons.read_more_sharp,
                color: Colors.white70,
                size: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
