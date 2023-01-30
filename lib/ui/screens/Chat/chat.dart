import 'package:chat_app/shared/Models/message.dart';
import 'package:chat_app/shared/Models/messageWidget.dart';
import 'package:chat_app/shared/Models/room.dart';
import 'package:chat_app/shared/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../shared/AppCubit/appCubit.dart';
import '../../../shared/AppCubit/appState.dart';

class Chat extends StatefulWidget {
  static String routeName = "chat";

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> implements AddMessageState {
  String messageContent = "";

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getRooms()..room=room..listenToChatMessage(),
      child: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is listenToChatMessageState) print("doneeeeeee");
      }, builder: (context, state) {
        AppCubit.get(context).stateAdd = this;
        AppCubit.get(context).currentUser = provider.user!;
        AppCubit.get(context).room = room;
        AppCubit.get(context).listenToChatMessage();
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
                  actions: [
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      child: const Icon(
                        Icons.more_vert_outlined,
                        size: 30,
                      ),
                    )
                  ],
                  backgroundColor: Colors.transparent,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.09,
                  title: Text(room.name),
                  elevation: 0,
                  centerTitle: true,
                ),
                body: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: StreamBuilder<QuerySnapshot<Message>>(
                            stream: AppCubit.get(context).listenToChatMessage(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              var messages = snapshot.data?.docs
                                  .map((message) => message.data())
                                  .toList();
                              print("message${messages?.length}");

                              return ListView.builder(
                                itemCount: messages?.length??0,
                                itemBuilder: (context, index) {

                                  return Container(

                                    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                      child:MessageWidget(messages![index]),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              onChanged: (value) {
                                messageContent = value;
                              },
                              controller: AppCubit.messageContentControler,
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  cut: true,
                                  paste: true,
                                  selectAll: true),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25))),
                                hintText: "massage",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                AppCubit.get(context).AddMessageToChat(
                                    AppCubit.messageContentControler.text,
                                    AppCubit.get(context).room,
                                    AppCubit.get(context).currentUser);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.01,
                                  top: MediaQuery.of(context).size.width * 0.03,
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.03,
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blue),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Send',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.send, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
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
  void clearMessage() {
    AppCubit.messageContentControler.clear();
  }
}
