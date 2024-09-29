
import 'package:flame/components.dart';
import 'package:vegan_power/game_engine.dart';

class Fruit extends SpriteComponent {
  final GameEngine game;
  final double animationSpeed = 5;
  late double yOffset;
  bool isOffScreen = false;
  bool eaten = false;  // Adding the eaten property
  double fruitSize = 1.0;

  late List<Sprite> fruitSprites;
  double fruitSpriteIndex = 0;
  late int animationFrames;

  Fruit(this.game, double x, double y) {
    yOffset = game.tileSize * game.fruitSpeed * (1 + game.rnd.nextDouble());

    fruitSprites = [Sprite(game.images.fromCache('units/strawberry_01.png'))];
    animationFrames = fruitSprites.length;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += yOffset * dt;

    if (position.y > game.size.y) {
      isOffScreen = true;
    }

    fruitSpriteIndex += animationSpeed * dt;
    if (fruitSpriteIndex >= fruitSprites.length) {
      fruitSpriteIndex = 0;
    }

    sprite = fruitSprites[fruitSpriteIndex.toInt()];
    print("Fruit updated at position: \$position");
  }

  void fruitEaten() {
    eaten = true;
  }
}
