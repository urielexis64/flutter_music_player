import 'package:flutter/material.dart';

class PlayerModel with ChangeNotifier {
  bool _isPlaying = false;
  AnimationController _controller;

  set controller(AnimationController controller) {
    this._controller = controller;
  }

  AnimationController get controller => this._controller;
}
