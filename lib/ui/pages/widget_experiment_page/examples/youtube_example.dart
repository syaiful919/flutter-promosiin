import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeExample extends StatefulWidget {
  @override
  _YoutubeExampleState createState() => _YoutubeExampleState();
}

class _YoutubeExampleState extends State<YoutubeExample> {
  YoutubePlayerController _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=fUv9gO8t8b4"),
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Gap.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Youtube Video Example",
                style: TypoStyle.title,
              )),
          SizedBox(height: Gap.s),
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _youtubeController.dispose();
  }
}
