import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class HomeView {
  final GameEngine game;
  late Rect titleRect;
  late Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize,
      (game.size.y / 2) - (game.tileSize * 4),
      game.tileSize * 7,
      game.tileSize * 4,
    );
    titleSprite =
        Sprite(Flame.images.fromCache('branding/vegan_power_logo.png'));
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}
