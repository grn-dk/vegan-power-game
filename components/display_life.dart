import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class DisplayLife {
  final GameEngine game;

  int i;

  Sprite fullHeart;
  Sprite emptyHeart;

  Rect heartRect;
  Rect heartRect1;

  List<Rect> lifeRect;


  DisplayLife(this.game) {
    lifeRect = List<Rect>();

    for( i = 0; i < game.maxLife; i++ ) {
      // Every heart is 1/2 tile wide.
      lifeRect.add(Rect.fromLTWH((game.tileSize / 2 * i) +
          ((game.screenSize.width - (game.tileSize * game.maxLife)) / 2),
          game.tileSize / 3,
          game.tileSize / 2,
          game.tileSize / 2));
    }
    fullHeart = Sprite('ui/heart_full_32x32.png');
    emptyHeart = Sprite('ui/heart_empty_32x32.png');
  }

  void render(Canvas c) {
    for( i = 0; i < game.life; i++) {
      fullHeart.renderRect(c, lifeRect[i]);
    }
    for( i = game.maxLife - 1; i > game.life - 1; i--) {
      emptyHeart.renderRect(c, lifeRect[i]);
    }

  }

  void update(double t) {
  }
}