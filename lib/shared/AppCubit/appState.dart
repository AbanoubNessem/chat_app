
import 'package:chat_app/shared/Models/myUser.dart';

abstract class AppState {}

class AppInitialState extends AppState {}
class visablePassState extends AppState{}
class validTextFormRegisterState extends AppState{}
class validTextFormLoginState extends AppState{}
class validTextFormCreateRoomState extends AppState{}
class getRoomState extends AppState{}
class listenToChatMessageState extends AppState{}
abstract class registerAndLoginNavigator extends AppState {
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigatorToHome(MyUser user);
}
abstract class createRoomNavigator extends AppState {
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigatorToHome();
}
abstract class AddMessageState extends AppState {
  void clearMessage();
}