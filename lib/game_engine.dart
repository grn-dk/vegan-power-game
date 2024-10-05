import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/animal.dart';
import 'package:vegan_power/components/player.dart';
import 'package:vegan_power/components/background.dart';
import 'package:vegan_power/components/start_button.dart';
import 'package:vegan_power/components/sound_button.dart';
import 'package:vegan_power/components/music_button.dart';
import 'package:vegan_power/components/help_button.dart';
import 'package:vegan_power/components/credits_button.dart';
import 'package:vegan_power/controllers/spawn_clouds.dart';
import 'package:vegan_power/controllers/sounds.dart';
import 'package:vegan_power/views/home_view.dart';
import 'package:vegan_power/views/lost_view.dart';
import 'package:vegan_power/view_list.dart';

import 'package:flutter/material.dart';

class GameEngine extends FlameGame
    with TapDetector, PanDetector, HasCollisionDetection {
  final int maxLife = 7;
  final SharedPreferences storage;

  late Random rnd;
  late double gameTime;
  late double tileSize;

  late Background background;

  int score = 0;
  late int life;

  double fruitSpeed = 1.5;
  double animalSpeed = 2.0;

  late Sounds sounds;

  late List<Cloud> clouds; // Declare clouds as late
  late List<Fruit> fruits;
  late List<Animal> animals;
  late Player player;

  ViewList activeView = ViewList.home;

  late HomeView homeView;
  late LostView lostView;

  late StartButton startButton;
  late HelpButton helpButton;
  late CreditsButton creditsButton;
  late MusicButton musicButton;
  late SoundButton soundButton;

  GameEngine(this.storage) {
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    //gameTime = 0;
    clouds = <Cloud>[];
    fruits = <Fruit>[];
    animals = <Animal>[];

    rnd = Random();

    score = 0;
    life = maxLife;

    /*fruitSpeed = startSpeedFruit;
    animalSpeed = startSpeedAnimal;
    */

    sounds = Sounds();
    /*cloudSpawner = SpawnClouds(this);
    fruitSpawner = SpawnFruits(this);
    animalSpawner = SpawnAnimals(this);
    background = Background(this);
    displayScore = DisplayScore(this);
    displayCredits = DisplayCredits(this);
    displayHelp = DisplayHelp(this);
    displayHighScore = DisplayHighScore(this);
    displayLife = DisplayLife(this);
    */
  
    FlameAudio.bgm.play('music/bensound-jazzyfrenchy.mp3', volume: .3);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    tileSize = size.x / 10;

    //background = Background(this);

    // Add initial game components
    spawnCloud();
    //Spawn player in the middle of the screen
    player = Player(this, size.x / 2 - tileSize, size.y / 2);
    //spawnAnimal();
    /*spawnFruit();
    
    */
  }

  @override
  void render(Canvas canvas) {
    // First call the super method to render all the default components
    super.render(canvas);

    // Always visible section
    background.render(canvas);
    clouds.forEach((Cloud cloud) => cloud.render(canvas));

    // Custom drawing logic (example: rendering score)
    final textStyle = TextStyle(color: Colors.white, fontSize: 24);
    final textSpan = TextSpan(text: 'Score: $score', style: textStyle);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(10, 10)); // Draw the score at position (10, 10)
  }

  void spawnCloud() {
    double x = rnd.nextDouble() * (size.x - 100);
    double y = -100;
    Cloud cloud = Cloud(this, x, y); // Create a Cloud instance
    clouds.add(cloud); // Add it to the clouds list
    add(cloud); // Add it to the Flame engine
  }

  void spawnFruit() {
    double x = rnd.nextDouble() * (size.x - 100);
    double y = -100;
    add(Fruit(this, x, y));
  }

  void spawnAnimal() {
    double x = rnd.nextDouble() * (size.x - 100);
    double y = -100;
    add(Animal(this, x, y));
  }

  void killAll() {
    children.whereType<Animal>().forEach((animal) => animal.eaten = true);
    children.whereType<Fruit>().forEach((fruit) => fruit.eaten = true);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
  }
}
