import 'package:MusicPlayer/Models/Song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    //1
    Song(
      songName: "All I Want Is You",
      artistName: "Nneelg",
      albumArtImagePath: "assets/Images/a.jpeg",
      audioPath: "Audio/Happiness.mp3",
    ),

    //2
    Song(
      songName: "I Cant Be With You",
      artistName: "Ilaa",
      albumArtImagePath: "assets/Images/b.jpeg",
      audioPath: "Audio/loversrock.mp3",
    ),

    //3
    Song(
      songName: "I Dont Care At All",
      artistName: "Gloct",
      albumArtImagePath: "assets/Images/c.jpeg",
      audioPath: "Audio/pieceofyou.mp3",
    ),
    //4
    Song(
      songName: "No Surprises",
      artistName: "Radio Head",
      albumArtImagePath: "assets/Images/d.jpeg",
      audioPath: "Audio/nosurprises.mp3",
    ),
    //5
    Song(
      songName: "Let Down",
      artistName: "Radio Head",
      albumArtImagePath: "assets/Images/e.jpeg",
      audioPath: "Audio/letdown.mp3",
    ),
    //6
    Song(
      songName: "Secret Door",
      artistName: "Artic Monkeys",
      albumArtImagePath: "assets/Images/f.jpeg",
      audioPath: "Audio/secretdoor.mp3",
    ),
    //7
    Song(
      songName: "About You",
      artistName: "The 1975",
      albumArtImagePath: "assets/Images/g.jpeg",
      audioPath: "Audio/aboutyou.mp3",
    ),
    //8
    Song(
      songName: "Waking Up Together With You",
      artistName: "Ardhito Pramono",
      albumArtImagePath: "assets/Images/h.jpeg",
      audioPath: "Audio/waking.mp3",
    ),
    //9
    Song(
      songName: "Anything You Want",
      artistName: "Reality Club",
      albumArtImagePath: "assets/Images/i.jpeg",
      audioPath: "Audio/ayw.mp3",
    ),
    //10
    Song(
      songName: "The Line",
      artistName: "Twenty One Pilots",
      albumArtImagePath: "assets/Images/j.jpeg",
      audioPath: "Audio/theline.mp3",
    ),
  ];

  int? _currentSongIndex;

  /*
Audio Play
  */

  //player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durasi
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //inisiasi
  bool _isPlaying = false;

  //play
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop
    await _audioPlayer.play(AssetSource(path)); //Baru
    _isPlaying = true;
    notifyListeners();
  }

  //pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause / resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //geser
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //skip
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // Skip kalau masih ada
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //balik ke awal kalau tadi terakhir
        currentSongIndex = 0;
      }
    }
  }

  //balek
  void playPreviousSong() async {
    //restart ke awal
    if (_currentDuration.inSeconds > 3) {
      seek(Duration.zero);
    }
    //kalo ga lebih balik ke lagu sebelum e
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //list durasi
  void listenToDuration() {
    //total
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //sekarang
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //selesai
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //hilangin audio

  /*

Getter
*/
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

/*

Setter

  */
  set currentSongIndex(int? newIndex) {
    //update lagu terbaru
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); //play lagu baru
    }
    // update UI Lagu
    notifyListeners();
  }
}
