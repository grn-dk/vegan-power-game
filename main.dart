import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';

import 'package:vegan_power/game_engine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  await Flame.images.loadAll(<String>[
    'bg/cloud_01.png',
    'bg/blue-gradient-background.jpg'
  ]);

  GameEngine game = GameEngine();
  runApp(game.widget);
}
