import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:puzle_hack/generated/l10n.dart';
import 'package:puzle_hack/src/ui/pages/game/1vs1/pantallaprincipal.dart';
import 'package:puzle_hack/src/ui/pages/game/vista_juego.dart';
import 'package:puzle_hack/src/ui/pages/game/widgets/%20customSolumath2.dart';
import 'package:puzle_hack/src/ui/pages/splash/circle_transition_clipper.dart';

import '../custom_dialog_coffe.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  @override
  Widget build(BuildContext context) {
    Items item1 =
        new Items(title: S.current.jugar, img: "assets/images/rompe.png");

    Items item2 = new Items(
      title: S.current.unouno,
      img: "assets/images/multijugador.png",
    );

    List<Items> myList = [
      item1,
      item2,
    ];

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.6;
 double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/faons.png'),
              fit: BoxFit.cover,
            )),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/abajo.json',
                      height: 175, width: 175),
                  SizedBox(
                    width: 20,
                  ),
                  Lottie.asset('assets/lottie/abajo.json',
                      height: 175, width: 175),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              margin: EdgeInsets.only(top: 250),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Lottie.asset('assets/lottie/brain2.json'),
                ),
              ),
            ),
          ),
          Center(
            child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: (itemWidth / itemHeight),
                padding: const EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 50,
                children: myList.map((data) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.white,
                              Colors.white54,
                            ],
                          ),
                          border: Border.all(color: Colors.blueAccent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            data.img,
                            width: 120,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            data.title,
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Viga-Regular'),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (data.title == S.current.jugar) {
                        _goToGame();
                      } else if (data.title == S.current.unouno) {
                        
                         showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomSolumath(
                                          title: "FLUTTER PUZZLE HACK",
                                          descriptions: S.current.flutter,
                                          text: S.current.salir,
                                        );
                                      });




                      }
                    },
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }

  void _goToGame() {
    final route = PageRouteBuilder(
      pageBuilder: (_, animation, secondaryAnimation) => GameView(),
      
      
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
}

class Items {
  String title;
  String img;
  Items({required this.title, required this.img});
}
