import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:vegan_power/game_engine.dart';

class DisplayCredits {
  final GameEngine game;
  final leftMargin = 10.0;
  final credits =
"""
Credits

Fruit: Code Inferno Games 
- codeinferno.com 
  
Animals: ryan.dansie opengameart.org

Heart: C.Nilsson and vermilion_wizard 
opengameart.org 
    
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
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    painter.text = TextSpan(
      text: credits,
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      leftMargin,
      (game.screenSize.height * 0.7) - (painter.height / 2),
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
  }
}