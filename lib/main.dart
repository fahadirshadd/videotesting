import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:videotesting/features/Camera/screens/CameraScreen.dart';
import 'package:videotesting/views/OnBoarding.dart';
import 'package:videotesting/views/Videos.dart';

import 'views/Dashboard.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  UserDataController controller = Get.put(UserDataController());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Camera App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenView(
        navigateRoute: OnBoardingPage(),
        duration: 3000,
        pageRouteTransition: PageRouteTransition.SlideTransition,
        imageSize: 45,
        imageSrc: "assets/images/analytica.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}
