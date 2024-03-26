

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AnimatedTextKit textKit( String value){
  return     AnimatedTextKit(
    animatedTexts: [
      TypewriterAnimatedText(
        "You Sign In As",
        textStyle:  TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        speed:
        const Duration(milliseconds: 200),
      ),
      TypewriterAnimatedText(
        value,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        speed:
        const Duration(milliseconds: 200),
      ),
    ],
    totalRepeatCount: 4,
    pause: const Duration(milliseconds: 1000),
    displayFullTextOnTap: true,
    stopPauseOnTap: true,
  );
}
GestureDetector gestureDetector(BuildContext context,IconData icon, Widget page,String namePage){
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contex) =>
                  page));
    },
    child: Container(
      decoration: BoxDecoration(
        // boxShadow: B,
          color: Colors.black,
          borderRadius:
          BorderRadius.all(
              Radius.circular(20))),
      height: 120,
      width: 120,
      child: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: 10)),
              Container(
                child: Icon(
                  icon,
                  size: 70,
                  color: Colors.amberAccent,
                  shadows: [],
                ),
              ),
              Text(
                namePage,
                style: TextStyle(
                    color:
                    Colors.amberAccent,
                    fontSize: 15),
              ),
            ],
          )),
    ),
  );
}