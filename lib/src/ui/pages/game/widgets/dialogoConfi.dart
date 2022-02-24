import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:puzle_hack/generated/l10n.dart';
import 'package:puzle_hack/src/ui/global/widgets/up_to_down.dart';
import 'package:puzle_hack/src/ui/utils/colors.dart';
import 'package:puzle_hack/src/ui/utils/dark_mode_extension.dart';


Future<bool> showConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final texts = S.current;
      final isDarkMode = context.isDarkMode;
      return Center(
        child: UpToDown(
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color:  lightColor,
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Lottie.asset(
                        'assets/lottie/cube.json',
                        width: 200,
                      ),
                    ),
                  ),
                  Text(
                    texts.restart,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      texts.restarpuzzle,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextButton(
                         
                          onPressed: () => Navigator.pop(
                            context,
                            true,
                          ),
                          child: Text(texts.yes),
                      
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: (isDarkMode ? Colors.white : darkColor).withOpacity(0.2),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(texts.no),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
  return result ?? false;
}
