import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:vegan_power/game_engine.dart';

class Player {
  final GameEngine game;
  final double framesPerSecond = 60; // Default mobile screen refresh rate.
  final double animationSpeed = 5; // higher value higher speed.

  double speed = 100;

  Offset targetLocation = Offset(0, 0);

  int animationFrames;

  Rect playerRect;
  double playerSize = 2;

  List<Sprite> playerSprite;
  double playerSpriteIndex = 0;

  Player(this.game, double x, double y) {
    playerRect = Rect.fromLTWH(x, y, game.tileSize * playerSize, game.tileSize * playerSize);
    playerSprite = List<Sprite>();

    playerSprite.add(Sprite('units/player_01.png'));
    playerSprite.add(Sprite('units/player_02.png'));
    playerSprite.add(Sprite('units/player_03.png'));
    playerSprite.add(Sprite('units/player_04.png'));
    animationFrames = playerSprite.length;
  }

  void render(Canvas c) {
    playerSprite[playerSpriteIndex.toInt()].renderRect(c, playerRect.inflate(1));
  }

  void update(double t) {
    playerSpriteIndex += animationSpeed * t;
    if (playerSpriteIndex >= animationFrames) {
      playerSpriteIndex -= animationFrames;
    }
    if(t > 0) {
      double stepDistance = speed * t;
      Offset toTarget = targetLocation -
          Offset(playerRect.left, playerRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(
            toTarget.direction, stepDistance);
        playerRect = playerRect.shift(stepToTarget);
      } else {
        playerRect = playerRect.shift(toTarget);
      }
    }
  }

}