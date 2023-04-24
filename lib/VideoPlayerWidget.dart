import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'basicOverlayingWidget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller != null && controller.value.isInitialized
        ? Container(alignment: Alignment.topCenter, child: buildVedio())
        : Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget buildVedio() => Stack(children: <Widget>[
        buildVideoplayer(),
        Positioned.fill(child: basicOverlayingWidget(controller: controller)),
      ]);

  Widget buildVideoplayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
