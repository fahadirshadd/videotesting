import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uiblock/uiblock.dart';

import '../../../views/BottomNavigationBar.dart';
import '../../../widgets/custom_text.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({ Key? key, required this.path}) : super(key: key);
  final String path;


  _uploadVideo(context) async {
    UIBlock.block(context,loadingTextWidget: CustomText(text: 'Image uploading...',color: Colors.white,));
    dynamic timeStamp=DateTime.now();
    Reference ref = FirebaseStorage.instance.ref("images/Image-$timeStamp.jpg");

    // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    //   widget.path,
    //   quality: VideoQuality.DefaultQuality,
    //   deleteOrigin: false, // It's false by default
    // );

    UploadTask uploadTask = ref.putFile(
        File(path), SettableMetadata(contentType: 'image/jpg'));
    print("uploading");

    uploadTask.whenComplete(() async {

      String downloadUrl = await ref.getDownloadURL();
      print("download url: $downloadUrl");
      FirebaseFirestore.instance.collection('images').doc().set({
        "Image Title" : 'Image-$timeStamp',
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
                Flexible(child: Text('Your image is uploaded successfuly.',style:TextStyle(color: Colors.white),)),
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
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}