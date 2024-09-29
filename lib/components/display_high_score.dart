import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:vegan_power/game_engine.dart';

class DisplayHighScore {
  final GameEngine game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  DisplayHighScore(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 25,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 5,
          color: Color(0xff000000),
          offset: Offset(2, 2),
        ),
      ],
    );

    position = Offset.zero;

    updateHighScore();
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void updateHighScore() {
    int highScore = game.storage.getInt('highScore') ?? 0;

    painter.text = TextSpan(
      text: 'High Score: ' + highScore.toString(),
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      game.size.x - (game.tileSize * .25) - painter.width,
      game.tileSize * .25,
    );
  }
}
