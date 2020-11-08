import 'dart:ui';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';

import 'package:flutter/gestures.dart';

import 'package:vegan_power/components/background.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';

import 'package:vegan_power/controllers/spawn_clouds.dart';
import 'package:vegan_power/controllers/spawn_fruits.dart';

class GameEngine extends Game with TapDetector {
  Size screenSize;
  double tileSize;
  Background background;

  List<Cloud> clouds;
  List<Fruit> fruits;

  //Cloud cloud;
  Random rnd;
  double gameTime;

  SpawnClouds cloudSpawner;
  SpawnFruits fruitSpawner;

  GameEngine() {
    initialize();
  }

  void initialize() async {
    gameTime = 0;
    clouds = List<Cloud>();
    fruits = List<Fruit>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    //Second resize just to make sure that we have the right size and maybe remove the black bottom bar that randomly appears.
    resize(await Flame.util.initialDimensions());

    cloudSpawner = SpawnClouds(this);
    fruitSpawner = SpawnFruits(this);
    background = Background(this);
  }

  void render(Canvas canvas) {
    //Maybe I should draw borders on this one.
    background.render(canvas);
    clouds.forEach((Cloud cloud) => cloud.render(canvas));
    fruits.forEach((Fruit fruit) => fruit.render(canvas));
  }

  void update(double t) {
    cloudSpawner.update(t);
    clouds.forEach((Cloud cloud) => cloud.update(t));
    clouds.removeWhere((Cloud cloud) => cloud.isOffScreen);

    fruitSpawner.update(t);
    fruits.forEach((Fruit fruit) => fruit.update(t));
    fruits.removeWhere((Fruit fruit) => fruit.isOffScreen);
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