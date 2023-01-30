import 'package:chat_app/shared/AppCubit/appState.dart';
import 'package:chat_app/shared/DataBase/dataBaseUtlits.dart';
import 'package:chat_app/shared/Models/message.dart';
import 'package:chat_app/shared/Models/myUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import '../Models/room.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  late registerAndLoginNavigator states;
  late createRoomNavigator statesCreate;
  late AddMessageState stateAdd;

  static AppCubit get(context) => BlocProvider.of(context);
  static bool passvalue = true;
  static var formKeyRegister = GlobalKey<FormState>();
  static var formKeylogin = GlobalKey<FormState>();
  static var formKeyCreate = GlobalKey<FormState>();
  static var fristNameControler = TextEditingController();
  static var lastNameControler = TextEditingController();
  static var emailControler = TextEditingController();
  static var passwordControler = TextEditingController();
  static var emailLoginControler = TextEditingController();
  static var passwordLoginControler = TextEditingController();
  static var roomNameControler = TextEditingController();
  static var roomDescControler = TextEditingController();
  static var messageContentControler = TextEditingController();
  List<Room> rooms = [];

  void visablePass() {
    if (passvalue == true) {
      passvalue = false;
    } else {
      passvalue = true;
    }
    emit(visablePassState());
  }

  Future<bool> validTextFormRegisterAndCreate() async {
    if (formKeyRegister.currentState!.validate()) {
      try {
        states.showLoading();
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailControler.text,
          password: passwordControler.text,
        );
        var user = MyUser(
            id: credential.user?.uid ?? "",
            firstName: fristNameControler.text,
            lastName: lastNameControler.text,
            email: emailControler.text);
        var created = DataBaseUtlits.createDBUser(user);
        states.hideLoading();
        states.navigatorToHome(user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          states.hideLoading();
          print('The password provided is too weak.');
          states.showMessage('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          states.hideLoading();
          print('The account already exists for that email.');
          states.showMessage('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      emit(validTextFormRegisterState());
      return true;
    } else {
      emit(validTextFormRegisterState());
      return false;
    }
  }

  void validTextFormCreateRoom(String name, String dsec, String catId) async {
    if (formKeyCreate.currentState!.validate()) {
      try {
        statesCreate.showLoading();
        var data = await DataBaseUtlits.createRoom(name, dsec, catId);
        statesCreate.hideLoading();
        statesCreate.navigatorToHome();
      } catch (e) {
        statesCreate.hideLoading();
        statesCreate.showMessage('something wrong');
      }
    }
  }

  Future<bool> validTextFormLoginAddCreate() async {
    if (formKeylogin.currentState!.validate()) {
      try {
        states.showLoading();
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLoginControler.text,
          password: passwordLoginControler.text,
        );
        var loged = await DataBaseUtlits.readUser(credential.user?.uid ?? "");

        states.hideLoading();
        states.navigatorToHome(loged!);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          states.hideLoading();
          print('No user found for that email.');
          states.showMessage('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          states.hideLoading();
          print('Wrong password provided for that user.');
          states.showMessage('Wrong password provided for that user.');
        }
      } catch (e) {
        print(e);
      }
      emit(validTextFormRegisterState());
      return true;
    } else {
      emit(validTextFormRegisterState());
      return false;
    }
  }

  bool validTextFormLogin() {
    if (formKeylogin.currentState!.validate()) {
      SnackBar(content: Text('Processing Data'));
      emit(validTextFormLoginState());
      return true;
    } else {
      emit(validTextFormLoginState());
      return false;
    }
  }

  void getRooms() async {
    rooms = await DataBaseUtlits.getRoomsFromFireStore();
    emit(getRoomState());
  }

  late MyUser currentUser;
  late Room room;

  void AddMessageToChat(String messageContent, Room room, MyUser myUser) async {
    Message message = Message(
        roomId: room.id,
        content: messageContent,
        senderId: myUser.id,
        senderName: myUser.firstName,
        messageTime: DateTime.now().microsecondsSinceEpoch);

    try {
      var res = await DataBaseUtlits.InsertMessageToFireStore(message);
      stateAdd.clearMessage();
    } catch (e) {
      states.showMessage(e.toString());
    }
  }

  Stream<QuerySnapshot<Message>> listenToChatMessage() {
    return  DataBaseUtlits.getMessageStreams(room.id);
  }
}
