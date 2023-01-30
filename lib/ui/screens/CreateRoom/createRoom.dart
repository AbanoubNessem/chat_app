import 'package:chat_app/shared/AppCubit/appCubit.dart';
import 'package:chat_app/shared/AppCubit/appState.dart';
import 'package:chat_app/shared/AppStyle/appStyle.dart';
import 'package:chat_app/shared/Models/catagery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Home/homeScreen.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({Key? key}) : super(key: key);
  static String RouteName = "CreateRoomScreen";

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen>
    implements createRoomNavigator {
  var categries = Categery.getCategeries();
  Categery? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is visablePassState) print("done");
      }, builder: (context, state) {
        AppCubit.get(context).statesCreate = this;
        selectedItem = categries[0];
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
                    'Create Room',
                  ),
                  elevation: 0,
                  centerTitle: true,
                ),
                body: Form(
                  key: AppCubit.formKeyCreate,
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.23,
                          // ),
                          Image.asset(
                            "assets/images/icon.png",
                          ),
                          TextFormField(
                            controller: AppCubit.roomNameControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter first name';
                              } else if (RegExp(r"^[a-zA-Z]").hasMatch(value) ==
                                  false) {
                                return "This is not a name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Room Name",
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButton<Categery>(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    hint: Text('Categry'),
                                    value: selectedItem,
                                    isExpanded: true,
                                    items: categries
                                        .map((catId) =>
                                            DropdownMenuItem<Categery>(
                                                value: catId,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("${catId.name}"),
                                                    Image.asset(
                                                      '${catId.image}',
                                                      height: 30,
                                                      width: 30,
                                                    )
                                                  ],
                                                )))
                                        .toList(),
                                    onChanged: (cat) {
                                      if (cat == null) {
                                        return;
                                      } else {
                                        selectedItem = cat;

                                      }
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          TextFormField(
                            controller: AppCubit.roomDescControler,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter last name';
                              } else if (RegExp(r"^[a-zA-Z]").hasMatch(value) ==
                                  false) {
                                return "This is not a name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Room Descreption",
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          ElevatedButton(
                              onPressed: () {

                                AppCubit.get(context).validTextFormCreateRoom(
                                    AppCubit.roomNameControler.text,
                                    AppCubit.roomDescControler.text,
                                    selectedItem!.id);
                                AppCubit.roomNameControler.text = "";
                                AppCubit.roomDescControler.text = "";
                              },
                              child: Container(
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.04),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Room",
                                      style: AppStyle
                                          .lightTheme.textTheme.headlineMedium,
                                    ),
                                    const Icon(Icons.arrow_forward_sharp)
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          )
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
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void navigatorToHome() {
    Navigator.pushReplacementNamed(
      context,
      HomeScreen.RouteName,
    );
  }
}
