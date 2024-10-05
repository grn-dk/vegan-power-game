import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:vegan_power/game_engine.dart';

class MusicButton {
  final GameEngine game;
  late Rect rect;
  late Sprite enabledSprite;
  late Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 3,
      game.size.y - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    enabledSprite = Sprite(Flame.images.fromCache('icons/music_icon.png'));
    disabledSprite = Sprite(Flame.images.fromCache('icons/no_music_icon.png'));
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      FlameAudio.bgm.pause();
    } else {
      isEnabled = true;
      FlameAudio.bgm.resume();
    }
  }
}
