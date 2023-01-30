
import 'package:chat_app/shared/AppCubit/appCubit.dart';
import 'package:chat_app/shared/AppCubit/appState.dart';
import 'package:chat_app/shared/AppStyle/appStyle.dart';
import 'package:chat_app/shared/Models/myUser.dart';
import 'package:chat_app/shared/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../Home/homeScreen.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({Key? key}) : super(key: key);
  static String RouteName = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> implements registerAndLoginNavigator {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is visablePassState) print('done');
      }, builder: (context, state) {
        AppCubit.get(context).states = this;
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/signIn.png",
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                  title: const Text(
                    'Create Account',
                  ),
                  elevation: 0,
                  centerTitle: true,
                ),
                body: Form(
                  key: AppCubit.formKeyRegister,
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.23,
                          ),
                          TextFormField(
                            controller: AppCubit.fristNameControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter first name';
                              }else if(RegExp(r"^[a-zA-Z]").hasMatch(value) == false){
                                return "This is not a name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "First Name",
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            controller: AppCubit.lastNameControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter last name';
                              } else if(RegExp(r"^[a-zA-Z]").hasMatch(value) == false){
                                return "This is not a name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            controller: AppCubit.emailControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter Email';
                              }else if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) == false){
                                return "Check your email";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            controller: AppCubit.passwordControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter password';
                              } else if(RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(value) == false){
                                return "Minimum 1 Upper case,1 lowercase,1 Number,1 Character";
                              }
                              return null;
                            },
                            obscureText: AppCubit.passvalue,
                            decoration:  InputDecoration(
                              labelText: "Password",
                              suffixIcon: InkWell(
                                  onTap: (){
                                    AppCubit.get(context).visablePass();
                                  },
                                  child: Icon(Icons.visibility)
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          ElevatedButton(
                              onPressed: ()async {
                                await AppCubit.get(context).validTextFormRegisterAndCreate();
                              },
                              child: Container(
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.04),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Account",
                                      style: AppStyle
                                          .lightTheme.textTheme.headlineMedium,
                                    ),
                                    const Icon(Icons.arrow_forward_sharp)
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void navigatorToHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.user = user ;
    Navigator.pushReplacementNamed(context, HomeScreen.RouteName);
  }
}














