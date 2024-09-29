
import 'dart:ui';  
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class Animal extends SpriteComponent {
  final GameEngine game;
  final double animationSpeed = 5;
  late double yOffset;
  bool isOffScreen = false;
  bool eaten = false;  // Adding the eaten property
  double animalSize = 1.0;

  late List<Sprite> animalSprites;
  double animalSpriteIndex = 0;
  late int animationFrames;
  late Rect animalRect;

  Animal(this.game, double x, double y) {
    yOffset = game.tileSize * game.animalSpeed * (1 + game.rnd.nextDouble());
    animalRect = Rect.fromLTWH(x, y, game.tileSize * animalSize, game.tileSize * animalSize);
    
    animalSprites = [];
    switch (game.rnd.nextInt(6)) {
      case 0:
        animalSprites = [Sprite(game.images.fromCache('units/dog.png'))];
        break;
      case 1:
        animalSprites = [Sprite(game.images.fromCache('units/chicken.png'))];
        break;
      case 2:
        animalSprites = [Sprite(game.images.fromCache('units/pig.png'))];
        break;
      case 3:
        animalSprites = [Sprite(game.images.fromCache('units/elephant.png'))];
        break;
      case 4:
        animalSprites = [Sprite(game.images.fromCache('units/penguin.png'))];
        break;
      case 5:
        animalSprites = [Sprite(game.images.fromCache('units/cow.png'))];
        break;
    }
    animationFrames = animalSprites.length;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += yOffset * dt;

    if (position.y > game.size.y) {
      isOffScreen = true;
    }

    animalSpriteIndex += animationSpeed * dt;
    if (animalSpriteIndex >= animalSprites.length) {
      animalSpriteIndex = 0;
    }

    sprite = animalSprites[animalSpriteIndex.toInt()];
    print("Animal updated at position: \$position");
  }

  void animalEaten() {
    eaten = true;
  }
}
