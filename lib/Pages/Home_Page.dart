import 'package:MusicPlayer/Components/drawer.dart';
import 'package:MusicPlayer/Models/Song.dart';
import 'package:MusicPlayer/Models/playlist_provider.dart';
import 'package:MusicPlayer/Pages/Song_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //menuju ke lagu
  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    //navigasi ke halaman lagu
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('P L A Y L I S T'),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          //manggil playlist
          final List<Song> playlist = value.playlist;

          //return list view UI
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                //Manggil 1 Lagu
                final Song song = playlist[index];

                //Return List Tile UI
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => goToSong(index),
                );
              });
        },
      ),
    );
  }
}
