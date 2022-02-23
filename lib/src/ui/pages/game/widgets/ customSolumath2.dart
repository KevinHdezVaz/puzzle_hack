import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:lottie/lottie.dart';
import 'package:puzle_hack/generated/l10n.dart'; 

import '../../../constants.dart';

class CustomSolumath extends StatefulWidget {
  final String title, descriptions, text;
 

  const CustomSolumath(
      {Key? key, required this.title, required this.descriptions, required this.text })
      : super(key: key);

  @override
  _CustomSolumathState createState() => _CustomSolumathState();
}

class _CustomSolumathState extends State<CustomSolumath> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                  child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Viga-Regular',
                    color: Colors.blue),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 16, fontFamily: 'Viga-Regular'),
                textAlign: TextAlign.center,
              ),
                   SizedBox(
                height: 40,
              ),
                 Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                     primary: Colors.blue,
                     
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text(
                    S.of(context).salir,
                  ),
                ),
              ),
          
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: Lottie.asset('assets/lottie/puzlee.json'),
            ),
          ),
        ),
      ],
    );
  }
}
 
