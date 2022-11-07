//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../models/custom_web_services.dart';
// import '../models/videos_data.dart';
//
// class VideosController extends GetxController {
//   var videoList = <VideosData>[].obs;
//
//
//   Future<void> getVideosData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     var response = await http.get(Uri.parse(CustomWebServices.getVideosUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer ${prefs.getString('token')}"
//         });
//     print(prefs.getString('token'));
//     if (response.statusCode == 200) {
//
//       var responseData = response.body;
//       videoList.value = videosDataFromJson(responseData);
//
//       print(videoList[0].title!.rendered);
//       print(videoList.length);
//     }
//     else {
//       print(response.statusCode);
//     }
//   }
//
//
//
// }