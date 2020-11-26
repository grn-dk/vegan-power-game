import 'dart:ui';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';

import 'package:flutter/gestures.dart';

import 'package:vegan_power/view.dart';

import 'package:vegan_power/components/animal.dart';
import 'package:vegan_power/components/background.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/credits_button.dart';
import 'package:vegan_power/components/display_credits.dart';
import 'package:vegan_power/components/display_life.dart';
import 'package:vegan_power/components/display_score.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/help_button.dart';
import 'package:vegan_power/components/player.dart';
import 'package:vegan_power/components/start_button.dart';


import 'package:vegan_power/controllers/spawn_animals.dart';
import 'package:vegan_power/controllers/spawn_clouds.dart';
import 'package:vegan_power/controllers/spawn_fruits.dart';

import 'package:vegan_power/views/home_view.dart';
import 'package:vegan_power/views/lost_view.dart';

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

  Random rnd;
  double gameTime;

  SpawnClouds cloudSpawner;
  SpawnFruits fruitSpawner;
  SpawnAnimals animalSpawner;

  Player player;

  DisplayScore displayScore;
  DisplayCredits displayCredits;
  DisplayLife displayLife;

  View activeView = View.home;

  HomeView homeView;
  LostView lostView;
  /*HelpView helpView;
  CreditsView creditsView;*/

  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;

  GameEngine() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    homeView = HomeView(this);
    lostView = LostView(this);
    /*helpView = HelpView(this);
    creditsView = CreditsView(this);*/

    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);

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
    displayLife = DisplayLife(this);
    //Spawn player in the middle of the screen
    player = Player(this, screenSize.width/2 - tileSize, screenSize.height/2);
    //player.targetLocation = Offset(screenSize.width/2 - tileSize/2, screenSize.height/2);
  }

  void render(Canvas canvas) {
    //Always visible section
    background.render(canvas);
    clouds.forEach((Cloud cloud) => cloud.render(canvas));
    //Always visible section end

    if (activeView == View.home) homeView.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }

    if (activeView == View.lost) {
      lostView.render(canvas);
    }

    //if (activeView == View.help) ;
    //Only display credits when credits view is active
    if (activeView == View.credits) displayCredits.render(canvas);

    if(activeView == View.playing) {
      fruits.forEach((Fruit fruit) => fruit.render(canvas));
      animals.forEach((Animal animal) => animal.render(canvas));
      player.render(canvas);
      displayLife.render(canvas);
    }
    if(activeView == View.playing || activeView == View.lost) {
      displayScore.render(canvas);
    }
    if(activeView == View.lost) {
      //Display hiscore
    }
  }

  void update(double t) {
    //Clouds
    cloudSpawner.update(t);
    clouds.forEach((Cloud cloud) => cloud.update(t));
    clouds.removeWhere((Cloud cloud) => cloud.isOffScreen);

    if(activeView == View.playing) {
      //Fruits
      fruitSpawner.update(t);
      fruits.forEach((Fruit fruit) => fruit.update(t));
      fruits.removeWhere((Fruit fruit) => fruit.eaten);
      fruits.removeWhere((Fruit fruit) => fruit.isOffScreen);

      //Animals
      animalSpawner.update(t);
      animals.forEach((Animal animal) => animal.update(t));
      animals.removeWhere((Animal animal) => animal.eaten);
      animals.removeWhere((Animal animal) => animal.isOffScreen);

      //Player
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
    }

    if (activeView == View.playing && life <= 0) {
      activeView = View.lost;
    }
    //displayCredits.update(t);

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
    bool isHandled = false;

    //Dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    //Startbutton
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    //Player
    if(!isHandled) {
      if(activeView == View.playing) {
        player.targetLocation = Offset(d.globalPosition.dx, d.globalPosition.dy);
      }
    }


    //print("Player tap down on ${d.globalPosition.dx} - ${d.globalPosition.dy}");
  }

  @override
  void onTapUp(TapUpDetails d) {
    bool isHandled = false;
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