import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoLink;
  final String videoTitle;
  final String videoSubtitle;
  const VideoPlayer(
      {super.key,
      required this.videoLink,
      required this.videoTitle,
      required this.videoSubtitle});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: primaryColor,
        progressColors: const ProgressBarColors(
          playedColor: primaryColor,
          handleColor: Colors.grey,
        ),
        onReady: () {
          print('Player is ready.');
        },
      ),
      builder: (context, player) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: (() {
                    nextScreenPop(context);
                  }),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF000000),
                  )),
            ),
            body: Column(
              children: [
                player,
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.videoTitle,
                          style: const TextStyle(
                              fontFamily: 'Sofia Pro', fontSize: 22),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.videoSubtitle,
                          style: TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontSize: 17,
                              color: Colors.grey[700]),
                          maxLines: 23,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
