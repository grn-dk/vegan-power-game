import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class BackgroundComponent extends SpriteComponent {
  BackgroundComponent() : super();

  @override
  Future<void> onLoad() async {
    //sprite = await Sprite.load('bg/blue-gradient-background.jpg');
    sprite = Sprite(Flame.images.fromCache('bg/blue-gradient-background.jpg'));
    size = Vector2.all(0); // Set a default size
    anchor = Anchor.topLeft; // Position the background at the top-left corner
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
  }
}
