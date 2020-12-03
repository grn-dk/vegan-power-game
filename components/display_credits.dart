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

  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  DisplayCredits(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 2,
          color: Color(0xff000000),
          offset: Offset(2, 2),
        ),
      ],
    );

    painter.text = TextSpan(
      text: credits,
      style: textStyle,
    );

    painter.layout(maxWidth: game.screenSize.width - game.tileSize );
    //position Offset is left margin is what is left when the text width is
    //subtracted from the screen width divided by 2.
    // similar concept with top margin.
    position = Offset(
        ( game.screenSize.width - painter.width ) / 2,
        ( game.screenSize.height - painter.height ) / 2
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
  }
}