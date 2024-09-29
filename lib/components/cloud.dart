
import 'package:flame/components.dart';
import 'package:vegan_power/game_engine.dart';

class Cloud extends SpriteComponent {
  Cloud(GameEngine game, double x, double y)
      : super(
          sprite: Sprite(game.images.fromCache('bg/cloud_01.png')),
          position: Vector2(x, y),
          size: Vector2(100, 100),  // Adjust size as needed
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('bg/cloud_01.png');
    size = Vector2(100, 100);  // Adjust size as needed
    print("Cloud component added at position: $position");
  }
}
