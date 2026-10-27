// Web implementation using Web Audio Synthesizer in index.html
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:js' as js;

void toggleWebAudio(bool enabled) {
  try {
    js.context.callMethod('toggleRetroAudio', [enabled]);
  } catch (e) {
    // Graceful fallback
  }
}

void playWebSound(String type) {
  try {
    js.context.callMethod('playRetroSound', [type]);
  } catch (e) {
    // Graceful fallback
  }
}
