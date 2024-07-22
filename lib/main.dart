import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: MaterialApp(
        home: RadioScreen(),
      ),
    );
  }
}

class RadioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _currentUrl = 'https://limitsiz.kesintisizyayin.com/8002/stream';
  bool _isPlaying = false;

  String get currentUrl => _currentUrl;
  bool get isPlaying => _isPlaying;

  Future<void> playRadio() async {
    await _audioPlayer.setUrl(_currentUrl);
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stopRadio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resumeRadio() async {
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await stopRadio();
    } else {
      await resumeRadio();
    }
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    notifyListeners();
  }
}

class RadioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radioProvider = Provider.of<RadioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Radio App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://r.resimlink.com/Dcx1mRNUA-Hd.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'NGG Medya',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sıla Yolu FM',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 64,
                  icon: Icon(Icons.play_arrow),
                  onPressed: radioProvider.playRadio,
                ),
                IconButton(
                  iconSize: 64,
                  icon: Icon(Icons.stop),
                  onPressed: radioProvider.stopRadio,
                ),
                IconButton(
                  iconSize: 64,
                  icon: Icon(Icons.pause),
                  onPressed: radioProvider.togglePlayPause,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Volume'),
            Slider(
              value: radioProvider._audioPlayer.volume,
              onChanged: (value) {
                radioProvider.setVolume(value);
              },
              min: 0,
              max: 1,
            ),
            SizedBox(height: 20),
            Text(
              'Playlist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(''),
                  ),
                  ListTile(
                    title: Text(''),
                  ),
                  ListTile(
                    title: Text(''),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
