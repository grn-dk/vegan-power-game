import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_engine.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Flame.audio.disableLog();
  SharedPreferences storage = await SharedPreferences.getInstance();

  await Flame.device.fullScreen();
  await Flame.device.setOrientation(DeviceOrientation.portraitUp);

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

  GameEngine game = GameEngine(storage);

  Flame.bgm.initialize();
  Flame.audio.loadAll([
    'sfx/mums.mp3',
    'sfx/njumnjum.mp3',
    'sfx/noo.mp3',
    'sfx/nein.mp3',
    'sfx/mmm.mp3',
    'sfx/aaaa.mp3',
    'sfx/yummie.mp3',
    'sfx/dobre.mp3',
    'sfx/nej.mp3',
    'sfx/mai.mp3',
    'sfx/nie.mp3',
    'sfx/nam_nam.mp3',
    'sfx/arroy.mp3',
    'music/bensound-jazzyfrenchy.mp3',
  ]);

  runApp(game.widget);
}
