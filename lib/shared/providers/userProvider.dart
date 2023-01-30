import 'package:chat_app/shared/DataBase/dataBaseUtlits.dart';
import 'package:chat_app/shared/Models/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user;
  User? fireBaseUser;

  UserProvider() {
    fireBaseUser = FirebaseAuth.instance.currentUser;
    initMyUser();
  }
  initMyUser() async {
    if (fireBaseUser != null) {
      user = await DataBaseUtlits.readUser(fireBaseUser?.uid ?? "");
    }
  }
}
