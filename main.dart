import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vegan_power/game_engine.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences storage = await SharedPreferences.getInstance();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  await Flame.images.loadAll(<String>[
    'branding/vegan_power_logo.png',
    'ui/heart_empty_32x32.png',
    'ui/game_over.png',
    'ui/start_game.png',
    'ui/heart_full_32x32.png',
    'bg/cloud_02.png',
    'bg/cloud_01.png',
    'units/elephant.png',
    'units/cow.png',
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
    'units/banana_03.png',
    'units/player_03.png',
    'icons/no_music_icon.png',
    'icons/credits_icon.png',
    'icons/no_sound_icon.png',
    'icons/music_icon.png',
    'icons/help_icon.png',
    'icons/sound_icon.png',
    'bg/blue-gradient-background.jpg',
  ]);

  GameEngine game = GameEngine(storage);
  runApp(game.widget);
  Flame.bgm.initialize();
  Flame.audio.disableLog();
  Flame.audio.loadAll([
    'music/bensound-jazzyfrenchy.mp3',
    'sfx/nam_nam.mp3',
    'sfx/noo.mp3',
  ]);


}
