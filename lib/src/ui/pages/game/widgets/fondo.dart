import 'dart:math';

import 'package:flutter/material.dart'; 

class GameBackground extends StatelessWidget {
  final Widget child;
  const GameBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Stack(
      children: [
        
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/faons.png'),
              fit: BoxFit.cover,
            )),
          ),
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
