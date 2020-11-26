import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';
import 'package:vegan_power/view.dart';

class CreditsButton {
  final GameEngine game;
  Rect rect;
  Sprite sprite;

  CreditsButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1.25),
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite('icons/credits_icon.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}