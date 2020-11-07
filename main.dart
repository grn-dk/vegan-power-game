import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';

import 'package:vegan_power/game_engine.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg/cloud01.png',
    'bg/blue-gradient-background.png'
  ]);

  GameEngine game = GameEngine();
  runApp(game.widget);
}
