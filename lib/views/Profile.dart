import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';
import '../constants/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final googleController =Get.put(GoogleLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32,top: 20,right: 32),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(child: Icon(Icons.filter_list_rounded,color: AppColors.mainAppColor,),
                        onTap: () async {
                        },
                      ),
                      InkWell(child: Container(
                        height: MediaQuery.of(context).size.height/20,
                        width: MediaQuery.of(context).size.width/3.6,
                        decoration: BoxDecoration(color: AppColors.boostColor,borderRadius: BorderRadius.circular(20),),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CustomText(text: '  0 ',fontWeight: FontWeight.w700,color: AppColors.white,),
                              CustomText(text: 'Boosts  ',fontWeight: FontWeight.w700,color: AppColors.white,),
                              Icon(Icons.rocket_launch,color: AppColors.white,),
                            ],
                          ),
                        ),
                      ),
                        onTap: () async {
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    height: MediaQuery.of(context).size.height/5,
                    decoration: BoxDecoration(shape:BoxShape.circle,image: DecorationImage(fit: BoxFit.cover,image: NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),border:Border.all(color: Colors.white),color:Colors.white54),
                  ),
                  SizedBox(height: 35,),
                  CustomText(
                    text: "Peter Rick",
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: AppColors.mainAppColor,
                  ),
                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: UpgradePromoCard(context,'99+','Video Uploads','Go','unlimited','with Gold',AppColors.goldColor)),
                    SizedBox(width: 15,),
                      Expanded(child: UpgradePromoCard(context,'0','Instant Previews','Get','free','credit with gold.',AppColors.boostColor),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  ProfileEditingOptions(context,'Edit Profile',Icons.edit,null),
                  new Divider(
                    color: Colors.black12,
                  ),
                  ProfileEditingOptions(context,'Settings',Icons.settings,null),
                  new Divider(
                    color: Colors.black12,
                  ),
                  ProfileEditingOptions(context,'Help Center',Icons.help_outline_rounded,null),
                  new Divider(
                    color: Colors.black12,
                  ),
                  ProfileEditingOptions(context,'Contact Support',Icons.settings,null),
                ]
            ),
          ),
        ),
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
            CustomText(text: '$text',color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 16.0,),
            Icon(icon,color: Colors.indigo,),
          ],
        ),
      ),
    );
  }

  Container UpgradePromoCard(BuildContext context,numCount,text1,text2,text3,text4,color) {
    return Container(
      decoration: BoxDecoration(color: AppColors.chipsShade,borderRadius: BorderRadius.circular(20)),
      // height: MediaQuery.of(context).size.height/3.5,
       width: MediaQuery.of(context).size.width/2.5,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: '$numCount',color: Colors.indigo,fontSize: 30.0,fontWeight: FontWeight.bold,),
              SizedBox(height: 5,),
              CustomText(text: '$text1',color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold,),
              SizedBox(height: 5,),
              Wrap(
                children: [
                  CustomText(text: '$text2 ',color: Colors.indigo),
                  CustomText(text: '$text3 ',color: color,),
                  CustomText(text: '$text4',color: Colors.indigo)
                ],
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){},
                child: Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width/3.6,
                  decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(20),),
                  child: Center(child: CustomText(text: 'Upgrade',color: AppColors.white,fontWeight: FontWeight.bold,),),
                ),
              ),

            ]
        ),
      ),
    );
  }
}
