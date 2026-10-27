import 'package:flutter/foundation.dart';
import 'audio_synth_stub.dart' if (dart.library.js) 'audio_synth_web.dart';

class AudioController extends ChangeNotifier {
  static final AudioController instance = AudioController._internal();
  AudioController._internal();

  bool _isMuted = false;
  bool get isMuted => _isMuted;
  bool get isEnabled => !_isMuted;

  void toggleMute() {
    _isMuted = !_isMuted;
    toggleWebAudio(!_isMuted);
    notifyListeners();
  }

  void play(String soundType) {
    if (_isMuted) return;
    playWebSound(soundType);
  }

  void laser() => play('laser');
  void explosion() => play('explosion');
  void powerup() => play('powerup');
  void click() => play('click');
  void gameover() => play('gameover');
}
