import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class Fruit {
  final GameEngine game;
  final double xOffset = 0; //The fruit does not move to the sides when falling.
  final double framesPerSecond = 60; // Default mobile screen refresh rate.
  final double animationSpeed = 5; // higher value higher speed.

  double yOffset;

  int animationFrames;

  Rect fruitRect;
  double get fruitSize => 0.6 + game.rnd.nextDouble();

  List<Sprite> fruitSprite;
  double fruitSpriteIndex = 0;
  bool isOffScreen = false;
  bool eaten = false;

  Fruit(this.game, double x, double y) {
    yOffset = game.tileSize * game.fruitSpeed * (1 + game.rnd.nextDouble());
    fruitRect = Rect.fromLTWH(x, y, game.tileSize * fruitSize, game.tileSize * fruitSize);
    fruitSprite = List<Sprite>();

    switch (game.rnd.nextInt(5)) {
      case 0:
        fruitSprite.add(Sprite(Flame.images.fromCache('units/banana_01.png')));
        fruitSprite.add(Sprite(Flame.images.fromCache('units/banana_02.png')));
        fruitSprite.add(Sprite(Flame.images.fromCache('units/banana_03.png')));
        break;
      case 1:
        fruitSprite.add(Sprite(Flame.images.fromCache('units/strawberry_01.png')));
        break;
      case 2:
        fruitSprite.add(Sprite(Flame.images.fromCache('units/orange.png')));
        break;
      case 3:
        fruitSprite.add(Sprite(Flame.images.fromCache('units/pear.png')));
        break;
      case 4:
        fruitSprite.add(Sprite(Flame.images.fromCache('units/watermelon.png')));
        break;
    }
    animationFrames = fruitSprite.length;
  }

  void render(Canvas c) {
    fruitSprite[fruitSpriteIndex.toInt()].renderRect(c, fruitRect);
    //Debugging rectangles
    //c.drawRect(fruitRect.inflate(fruitRect.width / 2), Paint()..color = Color(0x77ffffff));
    //c.drawRect(fruitRect, Paint()..color = Color(0x88000000));
  }

  void update(double t) {
    fruitRect = fruitRect.translate( xOffset, yOffset * t);

    if (fruitRect.top > game.screenSize.height) {
      isOffScreen = true;
      game.score -= 1;
    }

    fruitSpriteIndex += animationSpeed * t;
    while (fruitSpriteIndex >= animationFrames) {
      fruitSpriteIndex -= animationFrames;
    }
  }

  void fruitEaten() {
    eaten = true;
  }

}