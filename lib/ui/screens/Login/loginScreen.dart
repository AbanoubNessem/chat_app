import 'package:chat_app/shared/AppCubit/appCubit.dart';
import 'package:chat_app/shared/AppCubit/appState.dart';
import 'package:chat_app/shared/AppStyle/appStyle.dart';
import 'package:chat_app/shared/Models/myUser.dart';
import 'package:chat_app/ui/screens/Home/homeScreen.dart';
import 'package:chat_app/ui/screens/Register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/userProvider.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);
  static String RouteName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements registerAndLoginNavigator {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is validTextFormLoginState) print('done');
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
                    'Login',
                  ),
                  elevation: 0,
                  centerTitle: true,
                ),
                body: Form(
                  key:AppCubit.formKeylogin,
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
                          Text(
                            "Welcome Back!",
                            style: AppStyle.lightTheme.textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          TextFormField(
                            controller: AppCubit.emailLoginControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter email';
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
                            controller: AppCubit.passwordLoginControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter password';
                              }else if(RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(value) == false){
                                return "Minimum 1 Upper case, "
                                    " 1 lowercase, "
                                    " 1 Number "
                                    ",1 Character";
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
                                  child: Icon(Icons.visibility),
                                )
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Text(
                            "Forget password ?",
                            style: AppStyle.lightTheme.textTheme.headlineSmall,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                AppCubit.get(context).validTextFormLoginAddCreate();
                              },
                              child: Container(
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.04),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Login",
                                      style: AppStyle
                                          .lightTheme.textTheme.headlineMedium,
                                    ),
                                    const Icon(Icons.arrow_forward_sharp)
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Center(
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, RegisterScreen.RouteName);
                              },
                              child: Text(
                                "Or create My Account",
                                style: AppStyle.lightTheme.textTheme.headlineSmall,
                              ),
                            ),
                          ),
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
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user ;
    Navigator.pushReplacementNamed(context, HomeScreen.RouteName,);
  }
}





