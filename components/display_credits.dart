import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:vegan_power/game_engine.dart';

class DisplayCredits {
  final GameEngine game;
  final credits =
"""
Credits

Game by Greg Nowak, GrN.dk
Sponsored by HelePlanter.dk
Go Vegan!

Player graphics by Kasper Nowak, instagram: daddeldrengeninsta

Fruit: Code Inferno Games - codeinferno.com 
  
Animals: ryan.dansie opengameart.org

Heart: C.Nilsson and vermilion_wizard opengameart.org 
    
Music: Jazzy Frenchy from Bensound.com
""";

  final shadowColor = 0xff000000;
  final shadowBlurRadius = 5.0;
  final shadowOffset = 2.0;

  TextPainter painter;
  TextPainter painter2;

  TextStyle textStyle;
  TextStyle textStyle2;

  Offset position;

  DisplayCredits(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    painter2 = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      shadows: <Shadow>[
        Shadow( // bottomLeft
          blurRadius: shadowBlurRadius,
          offset: Offset(shadowOffset, shadowOffset),
          color: Color(shadowColor),
        ),
      ],
    );

    textStyle2 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = Color(shadowColor),
    );

    painter.text = TextSpan(
      text: credits,
      style: textStyle,
    );

    painter2.text = TextSpan(
      text: credits,
      style: textStyle2,
    );

    painter.layout(maxWidth: game.screenSize.width - game.tileSize );
    painter2.layout(maxWidth: game.screenSize.width - game.tileSize );
    //position Offset is left margin is what is left when the text width is
    //subtracted from the screen width divided by 2.
    // similar concept with top margin.
    position = Offset(
        ( game.screenSize.width - painter.width ) / 2,
        ( game.screenSize.height - painter.height ) / 2
    );
  }

  void render(Canvas c) {
    painter2.paint(c, position);
    painter.paint(c, position);
  }

  void update(double t) {
  }
}