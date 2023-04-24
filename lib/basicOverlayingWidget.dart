import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class basicOverlayingWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const basicOverlayingWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // anywhere click vedio will pause
      onTap: (){
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: Stack(
        children: [
          buildplay(),
          //pause on centre of vedio
          Positioned(bottom: 0, left: 0, right: 0, child: buildIndicator()),
        ],
      ),
    );
  }

  Widget buildIndicator() =>
      VideoProgressIndicator(controller, allowScrubbing: true);

  Widget buildplay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          // when vedio turns pause then it show black color
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 80,
          ),
        );
}
