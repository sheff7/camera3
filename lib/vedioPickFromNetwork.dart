
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayerWidget.dart';
import 'main.dart';



class vedioPickFromNetwork extends StatefulWidget {
  const vedioPickFromNetwork({Key? key}) : super(key: key);

  @override
  State<vedioPickFromNetwork> createState() => _vedioPickFromNetworkState();
}

class _vedioPickFromNetworkState extends State<vedioPickFromNetwork> {


  final textController = TextEditingController(text: urlLandscapeVideo);

  late VideoPlayerController controller;


  // String url =
  //     "http://ec2-15-207-71-113.ap-south-1.compute.amazonaws.com/media/v1.MOV";

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(textController.text)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final isMuted = controller.value.volume == 0;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          // children: [
          //   VideoPlayerWidget(controller: controller),
          //   const SizedBox(
          //     height: 32,
          //   ),
          //   if (controller != null && controller.value.isInitialized)
          //     CircleAvatar(
          //         radius: 30,
          //         backgroundColor: Colors.red,
          //         child: IconButton(
          //             onPressed:() => controller.setVolume(isMuted ? 1 : 0) ,
          //             icon: Icon(isMuted ? Icons.volume_mute : Icons.volume_up)))
          // ],


          children: [
            VideoPlayerWidget(controller: controller),
            buildTextField(),
          ],


        ),
      ),
    );
  }

  Widget buildTextField() =>
      Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: "Enter Vedio Url"
                ),


              ),
            ),
            const SizedBox(width: 12,),
            FloatingActionButton(onPressed: (){
              if(textController.text.trim().isEmpty) return;
//incase our text is new text then again initializing
              controller = VideoPlayerController.network(textController.text)
                ..addListener(() => setState(() {}))
                ..setLooping(true)
                ..initialize().then((value) => controller.play());
              //
            }
            )
          ],
        ),

      );
}

