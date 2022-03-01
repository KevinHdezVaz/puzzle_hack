import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzle_hack/src/data/repositories_impl/images_repository_impl.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/juego_controlador.dart';
import 'package:puzle_hack/src/ui/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../utils/dark_mode_extension.dart';

/// widget to show a horizontal pageview with the posible
/// images for the puzzle
class PuzzleOptions extends StatefulWidget {
  final double width;
  const PuzzleOptions({Key? key, required this.width}) : super(key: key);

  @override
  State<PuzzleOptions> createState() => _PuzzleOptionsState();
}

class _PuzzleOptionsState extends State<PuzzleOptions>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;

  int _page = 0;

  @override
  void initState() {
    super.initState();

    _setViewportFraction();
  }

  void _setViewportFraction() {
    double viewportFraction = 0.5;
    if (widget.width >= 400 && widget.width < 600) {
      viewportFraction = 0.4;
    } else if (widget.width >= 600) {
      viewportFraction = 0.2;
    }

    _pageController = PageController(
      viewportFraction: viewportFraction,
    );
  }

  @override
  void didUpdateWidget(covariant PuzzleOptions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.width != widget.width) {
      _setViewportFraction();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isDarkMode = context.isDarkMode;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: NotificationListener(
            onNotification: (t) {
              if (t is ScrollEndNotification) {
                if (_page != _pageController.page) {
                  _page = _pageController.page!.round();
                  final image = puzzleOptions[_page];
                  final controller = context.read<GameController>();
                  controller.changeGrid(
                    controller.state.crossAxisCount,
                    image.name != 'Numeric' ? image : null,
                  );

                  if (image.name != 'Numeric' && controller.state.sound) {
                    controller.audioRepository.play(
                      image.soundPath,
                    );
                  }
                }
              }
              return true;
            },
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemBuilder: (_, index) {
                final item = puzzleOptions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.white, Colors.blue.withAlpha(100)],
                        ),
                        border: Border.all(color: Colors.blueAccent),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(40)),
                    child: Material(
                      color: lightColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      elevation: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            item.assetPath,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: puzzleOptions.length,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: puzzleOptions.length,
            effect: ExpandingDotsEffect(
                spacing: 12.0,
                radius: 20.0,
                dotWidth: 24.0,
                dotHeight: 18.0,
                paintStyle: PaintingStyle.fill,
                strokeWidth: 2,
                dotColor: Colors.green.withAlpha(100),
                activeDotColor: Colors.green),
                onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child:
              Icon(Icons.arrow_drop_down_circle, size: 50, color: Colors.green)                                                                                                                                                                                                                                                                                                                            ,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
