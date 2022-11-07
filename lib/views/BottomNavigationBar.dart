import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videotesting/views/Dashboard.dart';
import 'Videos.dart';
import 'profile.dart';
import '../widgets/custom_text.dart';



class CustomBottomNavigationBar extends StatefulWidget {

  CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  TabIndexController tabIndexController = Get.put(TabIndexController());
  RxInt _selectedindex=0.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
            ()=> Row(
          children: <Widget> [
            buildBottomNavBar(context,RxInt(0),_selectedindex!=0?Icons.home_outlined:Icons.home,Colors.white,Colors.indigo,_selectedindex==0?true:false,'Home'),
            buildBottomNavBar(context,RxInt(1),_selectedindex!=1?Icons.play_circle_outline:Icons.play_circle,Colors.white,Colors.indigo,_selectedindex==1?true:false,'Video'),
            buildBottomNavBar(context,RxInt(2),_selectedindex!=2?Icons.account_box_outlined:Icons.account_box,Colors.white,Colors.indigo,_selectedindex==3?true:false,'Profile'),

          ],
        ),
      ),
      body: SafeArea(
        child: _selectedindex==0? Dashboard():_selectedindex==1?const Videos(): const Profile(),
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context, RxInt index, IconData icon, Color color, Color iconColor, bool isActive, String title) {

    return Obx(
          ()=> GestureDetector(
        onTap: (){
          setState((){
            tabIndexController.selectedTabIndex=index;
            _selectedindex.value=tabIndexController.selectedTabIndex.value;

            print(_selectedindex);
          });
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width/3,
          decoration: BoxDecoration(color: color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_selectedindex==index?icon:icon,color: isActive ? Colors.indigo:iconColor,),
              CustomText(text: title,color: isActive ? Colors.indigo:iconColor,),
            ],
          ),//Image.asset('assets/images/navbaricon.png'),
        ),
      ),
    );
  }
}
class TabIndexController extends GetxController{
  RxInt selectedTabIndex=0.obs;
}
