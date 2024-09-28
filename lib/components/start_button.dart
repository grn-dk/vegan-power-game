import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:vegan_power/game_engine.dart';
import 'package:vegan_power/view.dart';

class StartButton {
  final GameEngine game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite(Flame.images.fromCache('ui/start_game.png'));
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {

    //Reset values
    game.life = game.maxLife;
    game.fruitSpeed = game.startSpeedFruit;
    game.animalSpeed = game.startSpeedAnimal;
    game.score = 0;
    game.player.speed = game.player.startSpeedPlayer;

    game.player.playerRect = Rect.fromLTWH(game.screenSize.width/2 - game.tileSize, game.screenSize.height/2,
        game.tileSize * game.player.playerSize, game.tileSize * game.player.playerSize);

    game.player.targetLocation = Offset(game.player.playerRect.center.dx, game.player.playerRect.center.dy);

    game.killAll();

    //Start gaming loop
    game.activeView = View.playing;
  }
}