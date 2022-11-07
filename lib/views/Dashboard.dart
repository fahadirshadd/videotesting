import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videotesting/widgets/custom_text.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(

            height: MediaQuery.of(context).size.height/4.5,
            decoration: BoxDecoration(color: Colors.indigo,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft:Radius.circular(0) ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.blue,
                  Colors.indigo
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0,left: 20,right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Welcome back,',color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w500,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: 'Peter Rick',color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold,),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                        )
                      ],
                    ),
                    CustomText(text: '${DateTime.now().day}th November, ${DateTime.now().year}',color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w500,),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 70,),
          Container(
            height: MediaQuery.of(context).size.height/5.5,
            width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20) ),
              border: Border.all(width: 3,color: Colors.indigoAccent),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt,color: Colors.indigo,size: 40,),
                  SizedBox(height: 10,),
                  CustomText(text: 'Record Video',color: Colors.indigo,fontWeight: FontWeight.bold,),
                ],
              ),
            ),
          ),
          SizedBox(height: 50,),
          InkWell(
            onTap: () {
              CustomDialogAnimated(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height/5.5,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20) ),
                border: Border.all(width: 3,color: Colors.indigoAccent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: Colors.indigo,size: 40,),
                    SizedBox(height: 10,),
                    CustomText(text: 'More Options',color: Colors.indigo,fontWeight: FontWeight.bold,),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
          CustomText(text: 'Note: This prototype app is in it\'s testing phase.',color: Colors.indigo,)
        ],
      ),
    );
  }

  Future<dynamic> CustomDialogAnimated(BuildContext context) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutSine.transform(a1.value) -   1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        SizedBox(height: 20,),
                        Text("Notice", style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 18),),
                        SizedBox(height: 20,),
                        Text('Welcome to App!',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w300,fontSize: 15),),
                        SizedBox(height: 30,),
                        Text('We are working day and night to develop more features for you. Please stay tuned with Analytica for future product releases.',textAlign: TextAlign.center,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w300,fontSize: 15,),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Icon(Icons.info,color: Colors.indigo,),
                            Text("  Visit analytica-data.com for more",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w600,fontSize: 12),),
                          ],),
                        SizedBox(height: 20,),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.w600),)),
                        SizedBox(height: 20,),
                      ]),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {return Container();});
  }
}
