import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class Background {
  final GameEngine game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('bg/blue-gradient-background.png');

    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 9,
      game.tileSize * 23,
    );
    print ("Background ScreenSize: ${game.screenSize}");
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}