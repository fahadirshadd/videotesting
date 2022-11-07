import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/video_model.dart';
import '../widgets/VideoCard.dart';
import '../widgets/custom_text.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {

  //VideosController videosController = Get.find();

  UserDataController controller = Get.find();


  @override
  void initState() {
    super.initState();

    controller.VideoLoader();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0,left: 30,right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=>Get.back(),
                    child: Container(
                      child: null,
                    ),
                  ),
                  const CustomText(text: 'Watch Videos',fontSize: 25.0,fontWeight: FontWeight.w800,color: Colors.indigo,),
                  const SizedBox(child: null,),
                ],
              ),
              Obx(()=> SizedBox(height: controller.videoPosts.value.isEmpty?180:20,)),
              Obx(
                    ()=> controller.videoPosts.value.isEmpty?Center(child: Image.asset('assets/images/loadingdata.gif',height: 50,)):ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.videoPosts.value.length,
                  itemBuilder: (context,index){
                    print("Videos loaded: ${controller.videoPosts.length}");
                    return VideoCard(videoModel: controller.videoPosts.value[index],);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDataController extends GetxController{
  RxList<dynamic> videoPosts = [].obs;
  Future VideoLoader()async{
    print('loading videos....');
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var data = await FirebaseFirestore.instance
        .collection("videos")
    .orderBy('time',descending: true )
        .get();
    videoPosts.value = List.from(data.docs.map((doc) => VideoModel.fromJson(doc.data())));

  }
}