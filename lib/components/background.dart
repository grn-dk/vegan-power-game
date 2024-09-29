import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class Background {
  final GameEngine game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite =
        Sprite(Flame.images.fromCache('bg/blue-gradient-background.jpg'));

    bgRect = Rect.fromLTWH(
      0,
      game.size.y - (game.tileSize * 23),
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
