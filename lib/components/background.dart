import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent {
  late final GameEngine game;

  Background(GameEngine game)
      : super(
          sprite:
              Sprite(Flame.images.fromCache('bg/blue-gradient-background.jpg')),
          size: game.size, // Use the screen size directly for the background
        );

  /*@override
  Future<void> onLoad() async {
    opacity = 0.5; // Set opacity (0.0 = fully transparent, 1.0 = fully opaque)
  }*/
}
