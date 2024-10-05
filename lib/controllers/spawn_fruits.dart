import 'package:vegan_power/game_engine.dart';

class SpawnFruits {
  final GameEngine game;

  final int maxSpawnInterval = 1500;
  final int minSpawnInterval = 1500;
  final int intervalChange = 2;

  late int currentInterval;
  late int nextSpawn;

  SpawnFruits(this.game) {
    start();
    game.spawnFruit();
  }

  void start() {
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    if (nowTimestamp >= nextSpawn) {
      game.spawnFruit();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
