import 'package:flutter/material.dart';
import 'package:music_player_app/components/AppDrawer.dart';
import 'package:music_player_app/models/Song.dart';
import 'package:music_player_app/models/playListProvider.dart';
import 'package:music_player_app/pages/SongPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PlayListProvider playListProvider;

  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SongPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "P L A Y L I S T",
          style: TextStyle(fontSize: 22 * size.height / 700),
        ),
      ),
      drawer: const AppDrawer(),
      body: Consumer<PlayListProvider>(builder: (context, value, child) {
        final List<Song> playList = value.playList;

        return ListView.builder(
          itemBuilder: ((context, index) {
            final Song song = playList[index];
            return ListTile(
              title: Text(
                song.songName,
                style: TextStyle(),
              ),
              subtitle: Text(song.artistName),
              leading: Image.asset(song.albumArtImagePath),
              onTap: () {
                goToSong(index);
              },
            );
          }),
          itemCount: playList.length,
        );
      }),
    );
  }
}
