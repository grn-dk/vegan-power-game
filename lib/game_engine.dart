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

  late List<Cloud> clouds;
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

  GameEngine(this.storage);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Initialize tileSize based on the game size, now that it is available
    tileSize = size.x / 10;

    // Initialize the background now that the size is available
    background = Background(this);

    // Initialize components that depend on tileSize
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    clouds = <Cloud>[];
    fruits = <Fruit>[];
    animals = <Animal>[];

    rnd = Random();
    score = 0;
    life = maxLife;

    sounds = Sounds();

    // Play background music
    FlameAudio.bgm.play('music/bensound-jazzyfrenchy.mp3', volume: .3);

    // Add initial game components
    spawnCloud();
    player = Player(this, size.x / 2 - tileSize, size.y / 2);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Render the background first
    background.render(canvas);

    // Render the clouds
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
    Cloud cloud = Cloud(this, x, y);
    clouds.add(cloud);
    add(cloud);
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
