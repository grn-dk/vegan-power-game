import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';
import 'package:vegan_power/view_list.dart';



class CreditsButton {
  final GameEngine game;
  late Rect rect;
  late Sprite sprite;

  CreditsButton(this.game) {
    rect = Rect.fromLTWH(
      game.size.x - (game.tileSize * 1.25),
      game.size.y - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite(Flame.images.fromCache('icons/credits_icon.png'));
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = ViewList.credits;
  }
}
