import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class Fruit {
  final GameEngine game;
  final double fruitSpeed = 0.5;
  final double x_offset = 0;
  double y_offset;

  Rect fruitRect;
  double get fruitSize => 0.4 + game.rnd.nextDouble();

  double get speed => game.tileSize * 3;

  Sprite fruitSprite;
  bool isOffScreen = false;

  Fruit(this.game, double x, double y) {
    y_offset = game.tileSize * fruitSpeed * (1 + game.rnd.nextDouble());
    fruitRect = Rect.fromLTWH(x, y, game.tileSize * fruitSize, game.tileSize * fruitSize);

    switch (game.rnd.nextInt(2)) {
      case 0:
        fruitSprite = Sprite('units/banana_01.png');
        break;
      case 1:
        fruitSprite = Sprite('units/strawberry_01.png');
        break;
    }

  }

  void render(Canvas c) {
    fruitSprite.renderRect(c, fruitRect.inflate(0.5));
  }

  void update(double t) {
    fruitRect = fruitRect.translate( x_offset, y_offset * t);

    if (fruitRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

}