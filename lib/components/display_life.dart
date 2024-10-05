import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class DisplayLife {
  final GameEngine game;

  late int i;

  late Sprite fullHeart;
  late Sprite emptyHeart;

  late Rect heartRect;
  late Rect heartRect1;

  late List<Rect> lifeRect;

  DisplayLife(this.game) {
    lifeRect = <Rect>[];

    for (i = 0; i < game.maxLife; i++) {
      // Every heart is 1/2 tile wide.
      lifeRect.add(Rect.fromLTWH(
          (game.tileSize / 2 * i) +
              ((game.size.x - (game.tileSize * game.maxLife)) / 2),
          game.tileSize / 3,
          game.tileSize / 2,
          game.tileSize / 2));
    }
    fullHeart = Sprite(Flame.images.fromCache('ui/heart_full_32x32.png'));
    emptyHeart = Sprite(Flame.images.fromCache('ui/heart_empty_32x32.png'));
  }

  void render(Canvas c) {
    for (i = 0; i < game.life; i++) {
      fullHeart.renderRect(c, lifeRect[i]);
    }
    for (i = game.maxLife - 1; i > game.life - 1; i--) {
      emptyHeart.renderRect(c, lifeRect[i]);
    }
  }

  void update(double t) {}
}
