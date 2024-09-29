import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:vegan_power/game_engine.dart';

class DisplayScore {
  final GameEngine game;

  TextPainter painter;
  //TextSpan painter;
  TextStyle textStyle;
  Offset position;

  DisplayScore(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    //If current score is the same as painted score then do nothing.
    if ((painter.text ?? '') != game.score.toString()) {
      painter.text = TextSpan(
        text: "Vegan Power: " + game.score.toString(),
        style: textStyle,
      );

      painter.layout();

      //Offset(x,y)
      position = Offset(
        (game.size.x / 2) - (painter.width / 2),
        game.tileSize,
      );
    }
  }
}
