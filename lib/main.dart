import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/game.dart';
import 'package:vegan_power/game_engine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences storage = await SharedPreferences.getInstance();

  // Use the latest methods for screen orientation and full-screen mode
  await Flame.device.setPortraitUpOnly();
  await Flame.device.fullScreen();

  // Initialize the game engine
  GameEngine game = GameEngine(storage);

  // Initialize the audio cache
  FlameAudio.bgm.initialize();
  await FlameAudio.audioCache.loadAll([
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

  // Use GameWidget to render the game
  runApp(GameWidget(game: game));
}
