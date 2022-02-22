import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:lottie/lottie.dart';

import 'constants.dart';
 
class CustomCoffe extends StatefulWidget {
  final String title, descriptions, text;
 

  const CustomCoffe(
      {Key? key, required this.title, required this.descriptions,required this.text })
      : super(key: key);

  @override
  _CustomCoffeState createState() => _CustomCoffeState();
}

class _CustomCoffeState extends State<CustomCoffe> {
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
                     color: Colors.blue),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 16 ),
                textAlign: TextAlign.center,
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
              child: Lottie.asset('assets/lottie/ganador.json'),
            ),
          ),
        ),
      ],
    );
  }
}
 
