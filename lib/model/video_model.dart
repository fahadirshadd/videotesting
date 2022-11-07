class VideoModel{
  String? Title;
  String? url;
  dynamic? timeStamp;

  VideoModel({this.Title, this.url,this.timeStamp});

VideoModel.fromJson(Map<String, dynamic> json) {
  Title = json['Video Title'];
  url = json['url'];
  timeStamp = json['time'];
}

}

class ImageModel{
  String? Title;
  String? url;
  dynamic? timeStamp;

  ImageModel({this.Title, this.url,this.timeStamp});

  ImageModel.fromJson(Map<String, dynamic> json) {
    Title = json['Image Title'];
    url = json['url'];
    timeStamp = json['time'];
  }

}