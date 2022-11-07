import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:get/get.dart';
import 'package:uiblock/uiblock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../../views/BottomNavigationBar.dart';
import '../../../widgets/custom_text.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  _uploadVideo(context) async {
    UIBlock.block(context,loadingTextWidget: CustomText(text: 'Video uploading...',color: Colors.white,));
    dynamic timeStamp=DateTime.now();
    Reference ref = FirebaseStorage.instance.ref("videos/Video-$timeStamp.mp4");

    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      widget.path,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false, // It's false by default
    );

    UploadTask uploadTask = ref.putFile(
        File(mediaInfo!.path!), SettableMetadata(contentType: 'video/mp4'));
    print("uploading");

    uploadTask.whenComplete(() async {
      
      String downloadUrl = await ref.getDownloadURL();
      print("download url: $downloadUrl");
      FirebaseFirestore.instance.collection('videos').doc('video').set({
        "Video Title" : 'Video-$timeStamp',
        "url" : downloadUrl,
        "time": timeStamp,
      }).then((value) => print('Saved url in Firebase'));
      UIBlock.unblock(context);
      SnackBarCall(context);
      Get.offAll(CustomBottomNavigationBar(),transition: Transition.leftToRight);
    });
  }

  void SnackBarCall(context){
    AnimatedSnackBar(
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      builder: ((context) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 70,
          child: Center(
            child: Row(
              children: [
                Flexible(child: Text('Your video is uploaded successfuly.',style:TextStyle(color: Colors.white),)),
              ],
            ),
          ),
        );
      }),
    ).show(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: ()=>_uploadVideo(context),
        tooltip: 'Start Uploading',
        child: Icon(Icons.check,),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Container(),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}