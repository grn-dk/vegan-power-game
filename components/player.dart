import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class Fruit {
  final GameEngine game;
  final double fruitSpeed = 2; //How fast the fruit falls.
  final double xOffset = 0; //The fruit does not move to the sides when falling.
  final double framesPerSecond = 60; // Default mobile screen refresh rate.
  final double animationSpeed = 5; // higher value higher speed.
  double yOffset;

  int animationFrames;

  Rect fruitRect;
  double get fruitSize => 0.4 + game.rnd.nextDouble();

  List<Sprite> fruitSprite;
  double fruitSpriteIndex = 0;
  bool isOffScreen = false;

  Fruit(this.game, double x, double y) {
    yOffset = game.tileSize * fruitSpeed * (1 + game.rnd.nextDouble());
    fruitRect = Rect.fromLTWH(x, y, game.tileSize * fruitSize, game.tileSize * fruitSize);
    fruitSprite = List<Sprite>();

    switch (game.rnd.nextInt(2)) {
      case 0:
        fruitSprite.add(Sprite('units/banana_01.png'));
        fruitSprite.add(Sprite('units/banana_02.png'));
        fruitSprite.add(Sprite('units/banana_03.png'));
        break;
      case 1:
        fruitSprite.add(Sprite('units/strawberry_01.png'));
        break;
    }
    animationFrames = fruitSprite.length;
  }

  void render(Canvas c) {
    fruitSprite[fruitSpriteIndex.toInt()].renderRect(c, fruitRect.inflate(2));
  }

  void update(double t) {
    fruitRect = fruitRect.translate( xOffset, yOffset * t);

    if (fruitRect.top > game.screenSize.height) {
      isOffScreen = true;
    }

    fruitSpriteIndex += animationSpeed * t;
    if (fruitSpriteIndex >= animationFrames) {
      fruitSpriteIndex -= animationFrames;
    }
  }

}