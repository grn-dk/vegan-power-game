import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/animal.dart';
import 'package:vegan_power/components/background.dart';
import 'package:vegan_power/controllers/spawn_clouds.dart';

import 'package:flutter/material.dart';

class GameEngine extends FlameGame
    with TapDetector, PanDetector, HasCollisionDetection {
  final int maxLife = 7;
  final double startSpeedAnimal = 2.0;
  final double startSpeedFruit = 2.0;
  final SharedPreferences storage;
  late Random rnd;
  late double tileSize;
  double fruitSpeed = 1.5;
  double animalSpeed = 2.0;

  late List<Cloud> clouds; // Declare clouds as late
  /*List<Fruit> fruits;
  List<Animal> animals;*/

  late Background background;
  int score = 0;

  GameEngine(this.storage) {
    rnd = Random();
    clouds = []; // Initialize clouds as an empty list in the constructor
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    tileSize = size.x / 10;

    background = Background(this);

    // Add background
    /*final background = SpriteComponent()
      ..sprite = await loadSprite('bg/blue-gradient-background.jpg')
      ..size = size; // Set background size to fill the screen
    add(background);*/

    // Add initial game components
    spawnCloud();
    //spawnAnimal();
    /*spawnFruit();*/
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
