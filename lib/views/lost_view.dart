import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class LostView {
  final GameEngine game;
  late Rect rect;
  Sprite? sprite;

  LostView(this.game) {
    // Call onLoad to load the sprite
    onLoad();
  }

  Future<void> onLoad() async {
    // Load the image and create the sprite asynchronously
    await Flame.images.load('ui/game_over.png');
    sprite = Sprite(Flame.images.fromCache('ui/game_over.png'));

    // Set the size and position of the sprite after it's loaded
    double spriteWidth = game.tileSize * 7;
    double spriteHeight = game.tileSize * 5;

    double xPosition = (game.size.x - spriteWidth) / 2; // Center horizontally
    double yPosition = (game.size.y - spriteHeight) / 2; // Center vertically

    rect = Rect.fromLTWH(
      xPosition,
      yPosition,
      spriteWidth,
      spriteHeight,
    );
  }

  void render(Canvas c) {
    // Only render if the sprite is loaded
    if (sprite != null) {
      sprite!.renderRect(c, rect);
    }
  }

  void update(double t) {}
}
