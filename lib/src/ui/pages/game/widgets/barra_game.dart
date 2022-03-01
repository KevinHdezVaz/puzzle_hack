import 'package:flutter/material.dart'; 
 

class GameAppBar extends StatelessWidget {
  const GameAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   

    return new Scaffold(
    appBar: AppBar(
          shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(40))),
                          backgroundColor: Colors.blue,
    ),
    );
  }
}
