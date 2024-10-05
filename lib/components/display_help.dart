import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:vegan_power/game_engine.dart';

class DisplayHelp {
  final GameEngine game;
  final help = """
Help

Don't eat your friends, the animals. Only eat fruit!

Tap or drag on the screen to move the yellow player. The yellow player will follow your finger or your taps. 

Every time you eat a fruit you will gain Vegan Power. Every time you miss a fruit you will loose Vegan Power.

More Vegan Power means you move faster, and fruit falls faster.

When you accidentally eat an animal, you will loose health. Animal protein is very bad for your health.

Game ends when you have no more health.
""";

  final shadowColor = 0xff000000;
  final shadowBlurRadius = 5.0;
  final shadowOffset = 2.0;

  double fontSize = 20.0;

  late TextPainter painter;
  late TextPainter painter2;

  late TextStyle textStyle;
  late TextStyle textStyle2;

  late Offset position;

  DisplayHelp(this.game) {
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
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      shadows: <Shadow>[
        Shadow(
          // bottomLeft
          blurRadius: shadowBlurRadius,
          offset: Offset(shadowOffset, shadowOffset),
          color: Color(shadowColor),
        ),
      ],
    );

    painter.text = TextSpan(
      text: help,
      style: textStyle,
    );

    painter.maxLines =
        ((game.size.y - game.tileSize) ~/ painter.preferredLineHeight).toInt();
    painter.layout(maxWidth: game.size.x - game.tileSize);

    while (painter.didExceedMaxLines) {
      /*print("Max Lines exceded: ${painter.maxLines}, pref line height ${painter
          .preferredLineHeight}, font size: ${fontSize} "
          "painter exceed max lines: ${painter.maxLines} ");*/
      fontSize -= 1;
      textStyle = TextStyle(
        color: Color(0xffffffff),
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
            // bottomLeft
            blurRadius: shadowBlurRadius,
            offset: Offset(shadowOffset, shadowOffset),
            color: Color(shadowColor),
          ),
        ],
      );

      painter.text = TextSpan(text: help, style: textStyle);

      painter.maxLines =
          ((game.size.y - game.tileSize) ~/ painter.preferredLineHeight)
              .toInt();
      painter.layout(maxWidth: game.size.x - game.tileSize);
    }

    textStyle2 = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = Color(shadowColor),
    );

    painter2.text = TextSpan(
      text: help,
      style: textStyle2,
    );

    painter2.layout(maxWidth: game.size.x - game.tileSize);
    //position Offset is left margin is what is left when the text width is
    //subtracted from the screen width divided by 2.
    // similar concept with top margin.
    position = Offset(
        (game.size.x - painter.width) / 2, (game.size.y - painter.height) / 2);
  }

  void render(Canvas c) {
    painter2.paint(c, position);
    painter.paint(c, position);
  }

  void update(double t) {}
}
