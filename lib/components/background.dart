import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent {
  late final GameEngine game;
  /*late Sprite bgSprite;
  late Rect bgRect;*/

  Background(GameEngine game)
      : super(
          sprite:
              Sprite(Flame.images.fromCache('bg/blue-gradient-background.jpg')),
          size:
              game.size / 3, // Use the screen size directly for the background
        );

  @override
  Future<void> onLoad() async {
    opacity = 0.5; // Set opacity (0.0 = fully transparent, 1.0 = fully opaque)
  }

  /*void render(Canvas c) {
    //bgSprite.renderRect(c, bgRect);
  }*/
}
