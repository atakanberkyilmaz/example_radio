import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RadioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _currentUrl = '';
  bool _isPlaying = false;

  String get currentUrl => _currentUrl;
  bool get isPlaying => _isPlaying;

  Future<void> playRadio(String url) async {
    if (_currentUrl != url) {
      await _audioPlayer.setUrl(url);
      _currentUrl = url;
    }
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stopRadio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await stopRadio();
    } else {
      await _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    }
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    notifyListeners();
  }
}
