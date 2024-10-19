import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegan_power/components/credits_button.dart';
import 'package:vegan_power/components/display_credits.dart';
import 'package:vegan_power/components/display_help.dart';
import 'package:vegan_power/components/display_high_score.dart';
import 'package:vegan_power/components/display_life.dart';
import 'package:vegan_power/components/display_score.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/animal.dart';
import 'package:vegan_power/components/player.dart';
import 'package:vegan_power/components/background_component.dart';
import 'package:vegan_power/components/start_button.dart';
import 'package:vegan_power/components/sound_button.dart';
import 'package:vegan_power/components/music_button.dart';
import 'package:vegan_power/components/help_button.dart';
import 'package:vegan_power/controllers/spawn_clouds.dart';
import 'package:vegan_power/controllers/spawn_fruits.dart';
import 'package:vegan_power/controllers/spawn_animals.dart';
import 'package:vegan_power/controllers/sounds.dart';
import 'package:vegan_power/views/home_view.dart';
import 'package:vegan_power/views/lost_view.dart';
import 'package:vegan_power/view_list.dart';
import 'package:vegan_power/controllers/audio_manager.dart';

import 'package:flutter/material.dart';

class GameEngine extends FlameGame
    with TapDetector, PanDetector, HasCollisionDetection {
  final int maxLife = 7;
  final SharedPreferences storage;

  late Random rnd;
  late double gameTime;
  late double tileSize;

  late BackgroundComponent background;

  int score = 0;
  late int life;

  double fruitSpeed = 1.5;
  double animalSpeed = 2.0;

  late Sounds sounds;
  late SpawnClouds cloudSpawner;
  late SpawnFruits fruitSpawner;
  late SpawnAnimals animalSpawner;

  late List<Cloud> clouds;
  late List<Fruit> fruits;
  late List<Animal> animals;

  late Player player;

  late DisplayScore displayScore;
  late DisplayCredits displayCredits;
  late DisplayHelp displayHelp;
  late DisplayLife displayLife;
  late DisplayHighScore displayHighScore;

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
    // Load all images
    await images.loadAll(<String>[
      'branding/vegan_power_logo.png',
      'ui/heart_empty_32x32.png',
      'ui/game_over.png',
      'ui/start_game.png',
      'ui/heart_full_32x32.png',
      'bg/cloud_02.png',
      'bg/cloud_01.png',
      'units/elephant.png',
      'units/cow.png',
      'units/watermelon.png',
      'units/penguin.png',
      'units/strawberry_01.png',
      'units/pig.png',
      'units/dog.png',
      'units/banana_02.png',
      'units/player_01.png',
      'units/chicken.png',
      'units/player_02.png',
      'units/banana_01.png',
      'units/player_04.png',
      'units/orange.png',
      'units/banana_03.png',
      'units/player_03.png',
      'units/pear.png',
      'icons/no_music_icon.png',
      'icons/credits_icon.png',
      'icons/no_sound_icon.png',
      'icons/music_icon.png',
      'icons/help_icon.png',
      'icons/sound_icon.png',
      'bg/blue-gradient-background.jpg',
    ]);

    homeView = HomeView(this);
    lostView = LostView(this);

    // Initialize tileSize based on the game size, now that it is available
    tileSize = size.x / 10;

    background = BackgroundComponent();
    add(background);

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

    // Play background music using the AudioManager
    //AudioManager().playBackgroundMusic('music/bensound-jazzyfrenchy.mp3', volume: 0.3);

    // Add initial game components
    cloudSpawner = SpawnClouds(this);
    //fruitSpawner = SpawnFruits(this);
    //animalSpawner = SpawnAnimals(this);
    /*displayScore = DisplayScore(this);
    displayCredits = DisplayCredits(this);
    displayHelp = DisplayHelp(this);
    displayHighScore = DisplayHighScore(this);
    displayLife = DisplayLife(this);
    */
    //Spawn player in the middle of the screen
    player = Player(this, size.x / 2 - tileSize, size.y / 2);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Render the background first
    // Render the clouds
    clouds.forEach((Cloud cloud) => cloud.render(canvas));

    if (activeView == ViewList.home) homeView.render(canvas);
  }

  void spawnCloud() {
    double x = rnd.nextDouble() * (size.x - 100);
    double y = -100;
    Cloud cloud = Cloud(this, x, y);
    clouds.add(cloud);
    add(cloud);
  }

  /*void spawnCloud() {
    //Spawn cloud at a random place horizontally within the screen.
    double x = rnd.nextDouble() * (size.x - (tileSize * 2.025));
    //All clouds start at the top of the screen
    double y = -tileSize - tileSize;
    clouds.add(Cloud(this, x, y));
  }*/

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

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    tileSize = size.x / 10;
    //background.size = size; // Update background size when the game is resized
  }

  @override
  void onRemove() {
    super.onRemove();
    removeAll(children);
    processLifecycleEvents();
    images.clearCache();
    assets.clearCache();
    // Stop the background music when the game is removed
    AudioManager().dispose();
  }
}
