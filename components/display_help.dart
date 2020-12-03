import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:vegan_power/game_engine.dart';

class DisplayHelp {
  final GameEngine game;
  final help =
"""
Help

Don't eat your friends, the animals. Only eat fruit!

Tap on the screen to move player.

Every time you eat a fruit you will gain Vegan Power. Every time you miss a fruit you will loose Vegan Power.

More Vegan Power means you move faster, and fruit falls faster.

When you accidentally eat an animal, you will loose health. Animal protein is very bad for your health.

Game ends when you have no more health.
""";

  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  DisplayHelp(this.game) {
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
      text: help,
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