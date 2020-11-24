import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class Animal {
  final GameEngine game;
  final double xOffset = 0; //The animal does not move to the sides when falling.
  final double framesPerSecond = 60; // Default mobile screen refresh rate.
  final double animationSpeed = 5; // higher value higher speed.
  double yOffset;

  int animationFrames;

  Rect animalRect;
  double get animalSize => 0.4 + game.rnd.nextDouble();

  List<Sprite> animalSprite;
  double animalSpriteIndex = 0;
  bool isOffScreen = false;
  bool eaten = false;

  Animal(this.game, double x, double y) {
    yOffset = game.tileSize * game.animalSpeed * (1 + game.rnd.nextDouble());
    animalRect = Rect.fromLTWH(x, y, game.tileSize * animalSize, game.tileSize * animalSize);
    animalSprite = List<Sprite>();

    switch (game.rnd.nextInt(6)) {
      case 0:
        animalSprite.add(Sprite('units/dog.png'));
        break;
      case 1:
        animalSprite.add(Sprite('units/chicken.png'));
        break;
      case 2:
        animalSprite.add(Sprite('units/pig.png'));
        break;
      case 3:
        animalSprite.add(Sprite('units/elephant.png'));
        break;
      case 4:
        animalSprite.add(Sprite('units/penguin.png'));
        break;
      case 5:
        animalSprite.add(Sprite('units/cow.png'));
        break;
    }
    animationFrames = animalSprite.length;
  }

  void render(Canvas c) {
    animalSprite[animalSpriteIndex.toInt()].renderRect(c, animalRect.inflate(2));
  }

  void update(double t) {
    animalRect = animalRect.translate( xOffset, yOffset * t);

    if (animalRect.top > game.screenSize.height) {
      isOffScreen = true;
      game.score -= 1;
    }

    animalSpriteIndex += animationSpeed * t;
    if (animalSpriteIndex >= animationFrames) {
      animalSpriteIndex -= animationFrames;
    }
  }

  void animalEaten() {
    eaten = true;
  }

}