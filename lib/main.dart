import 'dart:io';

import 'package:camera3/vedioPickFromNetwork.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';


final urlLandscapeVideo = "http://ec2-15-207-71-113.ap-south-1.compute.amazonaws.com/media/v1.MOV";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  File? media;
  final ImagePicker _picker = ImagePicker();
  bool _isVideo = false;
  VideoPlayerController? _controller;

  void imagePickFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
    });
  }

  void imagePickFromGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
    });


  }

  void vedioPickFromCamera() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.camera);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
      _isVideo = true;
    });
    _controller= VideoPlayerController.file(media!);
    _controller!.initialize();
    _controller!.setLooping(true);
    _controller!.play();
    // _controller!.value.aspectRatio;
  }

  void vedioPickFromGallery() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
      _isVideo = true;
    });
    _controller= VideoPlayerController.file(media!);
    _controller!.initialize();
    _controller!.setLooping(true);
    _controller!.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Container(
                height: 350,
                child:
                _isVideo? VideoPlayer(_controller!)
                    :
                media != null
                    ? Image.file(media!)
                    : FlutterLogo(
                        size: 200,
                      ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  imagePickFromCamera();
                },
                icon: Icon(Icons.camera),
                label: Text("Pick image from camera"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  imagePickFromGallery();
                },
                icon: Icon(Icons.image_search),
                label: Text("Pick image from Gallery"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  vedioPickFromCamera();
                },
                icon: Icon(Icons.video_camera_front),
                label: Text("Pick Vedio from camera"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  vedioPickFromGallery();

                },
                icon: Icon(Icons.library_books),
                label: Text("Pick vedio from Gallery"),
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  vedioPickFromNetwork();

                },
                icon: Icon(Icons.library_books),
                label: Text("PIck vedio from network"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

