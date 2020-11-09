import 'dart:ui';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';

import 'package:flutter/gestures.dart';

import 'package:vegan_power/components/background.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/player.dart';

import 'package:vegan_power/controllers/spawn_clouds.dart';
import 'package:vegan_power/controllers/spawn_fruits.dart';

class GameEngine extends Game with TapDetector {
  Size screenSize;
  double tileSize;
  Background background;
  int score;

  List<Cloud> clouds;
  List<Fruit> fruits;

  //Cloud cloud;
  Random rnd;
  double gameTime;

  SpawnClouds cloudSpawner;
  SpawnFruits fruitSpawner;

  Player player;

  GameEngine() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    //gameTime = 0;
    clouds = List<Cloud>();
    fruits = List<Fruit>();
    rnd = Random();
    score = 0;

    cloudSpawner = SpawnClouds(this);
    fruitSpawner = SpawnFruits(this);
    background = Background(this);
    //Spawn player in the middle of the screen
    player = Player(this, screenSize.width/2 - tileSize/2, screenSize.height/2);
    player.targetLocation = Offset(screenSize.width/2 - tileSize/2, screenSize.height/2);
  }

  void render(Canvas canvas) {
    //Maybe I should draw borders on this one.
    background.render(canvas);
    clouds.forEach((Cloud cloud) => cloud.render(canvas));
    fruits.forEach((Fruit fruit) => fruit.render(canvas));
    player.render(canvas);
  }

  void update(double t) {
    fruits.removeWhere((Fruit fruit) => fruit.eaten);
    cloudSpawner.update(t);
    clouds.forEach((Cloud cloud) => cloud.update(t));
    clouds.removeWhere((Cloud cloud) => cloud.isOffScreen);

    fruitSpawner.update(t);
    fruits.forEach((Fruit fruit) => fruit.update(t));
    fruits.removeWhere((Fruit fruit) => fruit.isOffScreen);

    player.update(t);

    //Fruit collision detection.
    fruits.forEach((Fruit fruit) {
      if (player.playerRect.contains(fruit.fruitRect.center)) {
        fruit.fruitEaten();
        score += 1;
      }
    });
    /*
    gameTime += t;
    if(gameTime > 1) {
      //print ("clouds length: ${clouds.length} and t: $t ");
      gameTime = 0;
    }*/
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  @override
  void onTapDown(TapDownDetails d) {
    //bool isHandled = false;

    /*player.playerRect = player.playerRect.translate((d.globalPosition.dx
        - player.playerRect.topLeft.dx  - (player.playerRect.width/2) ),
        (d.globalPosition.dy - player.playerRect.topLeft.dy - (player.playerRect.height/2) ));
    */
    player.targetLocation = Offset(d.globalPosition.dx, d.globalPosition.dy);
    //player.targetLocation = Offset(0,0);
    //print("Player tap down on ${d.globalPosition.dx} - ${d.globalPosition.dy}");
  }

  @override
  void onTapUp(TapUpDetails d) {
  }

  void spawnCloud() {
    //Spawn cloud at a random place horizontally within the screen.
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    //All clouds start at the top of the screen
    double y = -tileSize-tileSize;
    clouds.add(Cloud(this, x, y));
  }

  void spawnFruit() {
    //Spawn cloud at a random place horizontally within the screen.
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    //All clouds start at the top of the screen
    double y = -tileSize-tileSize;
    fruits.add(Fruit(this, x, y));
  }
}