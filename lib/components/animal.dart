import 'dart:ui';
import 'package:flame/components.dart';
import 'package:vegan_power/game_engine.dart';

class Animal extends SpriteComponent {
  final GameEngine game;
  final double animationSpeed = 5;
  late double yOffset;
  bool isOffScreen = false;
  bool eaten = false;
  double animalSize = 1.0;

  late List<Sprite> animalSprites;
  double animalSpriteIndex = 0;
  late int animationFrames;
  late Rect animalRect;

  Animal(this.game, double x, double y)
      : super(
            position: Vector2(x, y),
            size: Vector2(100, 100)); // Set default size

  @override
  Future<void> onLoad() async {
    yOffset = game.tileSize * game.animalSpeed * (1 + game.rnd.nextDouble());

    // Load the sprites using the image cache
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

    // Ensure that the sprite is set properly
    sprite = animalSprites[0];
    animationFrames = animalSprites.length;
    size = Vector2(100, 100); // Adjust size if necessary
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
    //print("Animal updated at position: $position, game size: ${game.size}");
  }

  void animalEaten() {
    eaten = true;
  }
}
