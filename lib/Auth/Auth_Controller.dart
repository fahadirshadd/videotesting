import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';


fba.FirebaseAuth auth = fba.FirebaseAuth.instance;

Future<bool> signUpWithEmailAndPassword(String email, String password,context) async {
  try{
    fba.UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null) {
      return true;
    } else {
      return false;
    }
  }catch(ex){
    print(ex);
    AnimatedSnackBar(
      builder: ((context) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 70,
          child: Center(
            child: Row(
              children: [
                Flexible(child: Text('User auto Logged In as guest',style:TextStyle(color: Colors.white),)),
              ],
            ),
          ),
        );
      }),
    ).show(context);
    return false;
  }
}