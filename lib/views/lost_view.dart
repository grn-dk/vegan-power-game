import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';

class LostView {
  final GameEngine game;
  Rect rect;
  Sprite sprite;

  LostView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
    sprite = Sprite('ui/game_over.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}