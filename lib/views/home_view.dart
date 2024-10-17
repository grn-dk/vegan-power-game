import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class HomeView {
  final GameEngine game;
  late Rect titleRect;
  Sprite? titleSprite;

  HomeView(this.game) {
    // Call onLoad to load the sprite
    onLoad();
  }

  Future<void> onLoad() async {
    // Load the image and create the sprite asynchronously
    await Flame.images.load('branding/vegan_power_logo.png');
    titleSprite =
        Sprite(Flame.images.fromCache('branding/vegan_power_logo.png'));

    // Set the size and position of the sprite after it's loaded
    double spriteWidth = game.tileSize * 7;
    double spriteHeight = game.tileSize * 4;

    double xPosition = (game.size.x - spriteWidth) / 2; // Center horizontally
    double yPosition =
        (game.size.y - spriteHeight) / 3; // Adjust vertical position

    titleRect = Rect.fromLTWH(
      xPosition,
      yPosition,
      spriteWidth,
      spriteHeight,
    );
  }

  void render(Canvas c) {
    // Only render if the sprite is loaded
    if (titleSprite != null) {
      titleSprite!.renderRect(c, titleRect);
    }
  }

  void update(double t) {}
}
