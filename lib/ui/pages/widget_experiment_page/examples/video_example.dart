import 'package:base_project/utils/project_theme.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoExample extends StatefulWidget {
  @override
  _VideoExampleState createState() => _VideoExampleState();
}

class _VideoExampleState extends State<VideoExample> {
  VideoPlayerController assetVideoController;
  VideoPlayerController networkVideoController;
  ChewieController assetChewieController;
  ChewieController networkChewieController;

  @override
  void initState() {
    super.initState();

    networkVideoController = VideoPlayerController.network(
      'https://res.cloudinary.com/dem6vrsff/video/upload/v1599532791/samples/sea-turtle.mp4',
    );

    networkChewieController = ChewieController(
      videoPlayerController: networkVideoController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      errorBuilder: (_, errorMessage) => VideoErrorPlaceHolder(
        errorMessage: errorMessage,
      ),
    );

    assetVideoController = VideoPlayerController.asset(
      'assets/videos/sample.mp4',
    );

    assetChewieController = ChewieController(
      videoPlayerController: assetVideoController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      errorBuilder: (_, errorMessage) => VideoErrorPlaceHolder(
        errorMessage: errorMessage,
      ),
    );
  }

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
                "Video Example",
                style: TypoStyle.title,
              )),
          SizedBox(height: Gap.s),
          Chewie(
            controller: assetChewieController,
          ),
          SizedBox(height: Gap.s),
          Chewie(
            controller: networkChewieController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    assetChewieController.dispose();
    networkChewieController.dispose();
    assetVideoController.dispose();
    networkVideoController.dispose();
  }
}

class VideoErrorPlaceHolder extends StatelessWidget {
  final String errorMessage;

  const VideoErrorPlaceHolder({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Gap.s),
      child: Center(
        child: Text(
          errorMessage,
          style: TypoStyle.caption.copyWith(color: ProjectColor.white1),
        ),
      ),
    );
  }
}
