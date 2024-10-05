class Sounds {
  final List<String> fruitEatenSounds = [
    'sfx/mums.mp3','sfx/njumnjum.mp3','sfx/mmm.mp3','sfx/yummie.mp3',
    'sfx/dobre.mp3','sfx/nam_nam.mp3','sfx/arroy.mp3'
  ];

  final List<String> animalsEatenSounds = [
    'sfx/noo.mp3','sfx/nein.mp3','sfx/aaaa.mp3','sfx/nej.mp3','sfx/mai.mp3',
    'sfx/nie.mp3'
  ];

  late int countFruitEatenSounds;
  late int countAnimalsEatenSounds;

  Sounds() {
    countFruitEatenSounds = fruitEatenSounds.length;
    countAnimalsEatenSounds = animalsEatenSounds.length;
  }
}