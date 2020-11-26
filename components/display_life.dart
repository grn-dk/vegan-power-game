import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class DisplayLife {
  final GameEngine game;

  Sprite fullHeart;
  Sprite emptyHeart;

  Rect heartRect;

  DisplayLife(this.game) {
    heartRect = Rect.fromLTWH(game.tileSize, game.tileSize, game.tileSize , game.tileSize);
    fullHeart = Sprite('ui/heart_full_32x32.png');
    emptyHeart = Sprite('ui/heart_empty_32x32.png');
  }

  void render(Canvas c) {
    fullHeart.renderRect(c, heartRect);
  }

  void update(double t) {
  }
}