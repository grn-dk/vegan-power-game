import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:vegan_power/components/cloud.dart';
import 'package:vegan_power/components/fruit.dart';
import 'package:vegan_power/components/animal.dart';
import 'package:vegan_power/components/background.dart';

class GameEngine extends FlameGame with TapDetector, PanDetector, HasCollisionDetection {
  final int maxLife = 7;
  final double startSpeedAnimal = 2.0;
  final double startSpeedFruit = 2.0;
  final SharedPreferences storage;
  late Random rnd;
  late double tileSize;
  double fruitSpeed = 1.5;  
  double animalSpeed = 2.0;  
  int score = 0;  

  GameEngine(this.storage) {
    rnd = Random();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    tileSize = size.x / 10;  

    // Add background
    final background = SpriteComponent()
      ..sprite = await loadSprite('bg/blue-gradient-background.jpg')
      ..size = size;  // Set background size to fill the screen
    add(background);

    // Add initial game components
    spawnCloud();
    spawnAnimal();
    /*spawnFruit();*/
  }

  void spawnCloud() {
    double x = rnd.nextDouble() * (size.x - 100); 
    double y = -100;
    add(Cloud(this, x, y)); 
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
