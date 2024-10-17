import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  void playBackgroundMusic(String filePath, {double volume = 1.0}) {
    FlameAudio.bgm.stop(); // Stop any existing background music
    FlameAudio.bgm.play(filePath, volume: volume);
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  void dispose() {
    stopBackgroundMusic();
  }
}
