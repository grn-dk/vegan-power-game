import 'dart:ui';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';

import 'package:flutter/gestures.dart';

import 'package:vegan_power/components/animal.dart';
import 'package:vegan_power/components/background.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/player.dart';
import 'package:vegan_power/components/display_score.dart';
import 'package:vegan_power/components/display_credits.dart';

import 'package:vegan_power/controllers/spawn_animals.dart';
import 'package:vegan_power/controllers/spawn_clouds.dart';
import 'package:vegan_power/controllers/spawn_fruits.dart';


class GameEngine extends Game with TapDetector {
  Size screenSize;
  double tileSize;

  Background background;
  int score;
  int life;
  double fruitSpeed;
  double animalSpeed;

  List<Cloud> clouds;
  List<Fruit> fruits;
  List<Animal> animals;

  //Cloud cloud;
  Random rnd;
  double gameTime;

  SpawnClouds cloudSpawner;
  SpawnFruits fruitSpawner;
  SpawnAnimals animalSpawner;

  Player player;

  DisplayScore displayScore;
  DisplayCredits displayCredits;

  GameEngine() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    //gameTime = 0;
    clouds = List<Cloud>();
    fruits = List<Fruit>();
    animals = List<Animal>();

    rnd = Random();

    score = 0;
    life = 5;
    fruitSpeed = 2;
    animalSpeed = 2;

    cloudSpawner = SpawnClouds(this);
    fruitSpawner = SpawnFruits(this);
    animalSpawner = SpawnAnimals(this);
    background = Background(this);
    displayScore = DisplayScore(this);
    displayCredits = DisplayCredits(this);
    //Spawn player in the middle of the screen
    player = Player(this, screenSize.width/2 - tileSize, screenSize.height/2);
    //player.targetLocation = Offset(screenSize.width/2 - tileSize/2, screenSize.height/2);
  }

  void render(Canvas canvas) {
    //Maybe I should draw borders on this one.
    background.render(canvas);
    clouds.forEach((Cloud cloud) => cloud.render(canvas));
    fruits.forEach((Fruit fruit) => fruit.render(canvas));
    animals.forEach((Animal animal) => animal.render(canvas));
    player.render(canvas);
    displayScore.render(canvas);

    //Only display credits when credits view is active
    //displayCredits.render(canvas);
  }

  void update(double t) {
    fruits.removeWhere((Fruit fruit) => fruit.eaten);
    animals.removeWhere((Animal animal) => animal.eaten);
    cloudSpawner.update(t);
    clouds.forEach((Cloud cloud) => cloud.update(t));
    clouds.removeWhere((Cloud cloud) => cloud.isOffScreen);

    fruitSpawner.update(t);
    fruits.forEach((Fruit fruit) => fruit.update(t));

    animalSpawner.update(t);
    animals.forEach((Animal animal) => animal.update(t));

    fruits.removeWhere((Fruit fruit) => fruit.isOffScreen);
    animals.removeWhere((Animal animal) => animal.isOffScreen);

    player.speed = 100.0 + (score * 2);

    player.update(t);

    //Fruit collision detection.
    fruits.forEach((Fruit fruit) {
      if (player.playerRect.contains(fruit.fruitRect.center)) {
        fruit.fruitEaten();
        score += 1;
        fruitSpeed += 0.05;
      }
    });

    //Animal collision detection.
    animals.forEach((Animal animal) {
      if (player.playerRect.contains(animal.animalRect.center)) {
        animal.animalEaten();
        life -= 1;
        animalSpeed -= 0.05;
      }
    });

    displayScore.update(t);
    displayCredits.update(t);

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

    player.targetLocation = Offset(d.globalPosition.dx, d.globalPosition.dy);

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
  void spawnAnimal() {
    //Spawn cloud at a random place horizontally within the screen.
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    //All clouds start at the top of the screen
    double y = -tileSize-tileSize;
    animals.add(Animal(this, x, y));
  }
}