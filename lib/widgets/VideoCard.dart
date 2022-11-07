import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import '../model/video_model.dart';
import 'custom_text.dart';

class VideoCard extends StatefulWidget {
  late VideoModel videoModel;

  VideoCard({
    Key? key, required this.videoModel,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? videoController;
  @override
  void initState() {
    print('video loading....');
    videoController = VideoPlayerController.network(widget.videoModel.url.toString())
      ..initialize().then((_) {
        videoController!.pause();
        videoController!.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    videoController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoController!.value.isInitialized && videoController!=null ?Column(
      children: [
        SizedBox(
          //height: MediaQuery.of(context).size.height/3.9,
          width: double.maxFinite,
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  setState((){
                    videoController!.value.isPlaying?videoController!.pause():videoController!.play();
                  });
                },
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: videoController!.value.size.width,
                    height: videoController!.value.size.height/1.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: videoController!=null && videoController!.value.isInitialized?VideoPlayer(videoController!,):Container(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),

              /*videoController!=null && videoController!.value.isInitialized?AspectRatio(aspectRatio: videoController!.value.aspectRatio,child: VideoPlayer(videoController!)):Container(
                child: CircularProgressIndicator(),
              ),*/
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: (){
                    setState((){
                      videoController!.value.isPlaying?videoController!.pause():videoController!.play();
                    });
                  },
                  child: Icon(videoController!.value.isPlaying?null:Icons.play_arrow_rounded,size: 100,color: Colors.white,),
                ),
              ),
            ],
          ),

        ),
        SizedBox(height: 20,),
        CustomText(text: 'Watch Video:  ${widget.videoModel.Title}',fontSize: 20.0,fontWeight: FontWeight.bold,maxLines: 3,overflow: TextOverflow.ellipsis,),
        SizedBox(height: 30,),
      ],
    ):Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: getShimmerLoading(),
          )
      ),
    );
  }


  InkWell ProfileEditingOptions(BuildContext context,text,icon,onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: '$text',fontWeight: FontWeight.bold,fontSize: 16.0,),
            Icon(icon),
          ],
        ),
      ),
    );
  }


  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 18.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 14.0,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
