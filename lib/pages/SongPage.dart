import 'package:flutter/material.dart';
import 'package:music_player_app/components/neuBox.dart';
import 'package:music_player_app/models/playListProvider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String foramtTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      // get the playList
      final playList = value.playList;
      // get current song index
      final currentSong = playList[value.currentSongIndex ?? 0];

      // return scaffold
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text("P L A Y L I S T"),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.albumArtImagePath),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(currentSong.artistName)
                              ],
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(foramtTime(value.currentDuration)),
                              const Icon(Icons.shuffle),
                              const Icon(Icons.repeat),
                              Text(foramtTime(value.totalDuration))
                            ],
                          ),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape()),
                          child: Slider(
                            value: value.currentDuration.inSeconds.toDouble(),
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            activeColor: Colors.green,
                            onChanged: (double localValue) {},
                            onChangeEnd: (double localValue) {
                              value.seekSong(
                                  Duration(seconds: localValue.toInt()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              value.playPreviousSong();
                            },
                            child:
                                const NeuBox(child: Icon(Icons.skip_previous))),
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: () {
                              value.pauseOrResume();
                            },
                            child: NeuBox(
                                child: Icon(value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow))),
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              value.playNextSong();
                            },
                            child: const NeuBox(child: Icon(Icons.skip_next))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }
}
