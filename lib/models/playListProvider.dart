import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/Song.dart';

class PlayListProvider extends ChangeNotifier {
  // play list of songs
  final List<Song> _playList = [
    // song 1
    Song(
        songName: "Norouz",
        artistName: "Homayoun",
        albumArtImagePath: "assets/images/homayoun.jpg",
        audioPath: "musics/homayoun.mp3"),

    // song 2
    Song(
        songName: "Dar Zolfe To Avizaam",
        artistName: "Alireza",
        albumArtImagePath: "assets/images/alireza.jpg",
        audioPath: "musics/alireza.mp3"),

    // song 3
    Song(
        songName: "Vaghti Mikhandi",
        artistName: "Ehsan",
        albumArtImagePath: "assets/images/ehsan.jpg",
        audioPath: "musics/ehsan.mp3"),
  ];

  // current song playList index
  int? _currentSongIndex;

  // A D U I O P L A Y E R

  // aduio player
  final _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlayListProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void playSong() async {
    print("1 : ${_currentSongIndex}");
    final String path = _playList[_currentSongIndex!].audioPath;
    print("path : $path");
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pauseSong() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resumeSong() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pauseSong();
    } else {
      resumeSong();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seekSong(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seekSong(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // dispose audio player

  // Getters
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  // Setters
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      playSong();
    }
    notifyListeners();
  }
}
