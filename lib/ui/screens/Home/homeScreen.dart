import 'package:chat_app/shared/AppCubit/appCubit.dart';
import 'package:chat_app/shared/AppStyle/appStyle.dart';
import 'package:chat_app/shared/Models/roomItem.dart';
import 'package:chat_app/shared/providers/userProvider.dart';
import 'package:chat_app/ui/screens/CreateRoom/createRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/AppCubit/appState.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String RouteName = "Home";

  // static const List<Tab> myTabs = <Tab>[
  //   Tab(text: 'My Rooms'),
  //   Tab(text: 'Browse'),
  // ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(vsync: this, length: HomeScreen.myTabs.length);
  // }
  //
  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // UserProvider args = ModalRoute.of(context)!.settings.arguments as UserProvider;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getRooms(),
      child: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is getRoomState) print("done");
      }, builder: (context, state) {
        // AppCubit.get(context).statesCreate = this;
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
// bottom: TabBar(
//   controller: _tabController,
//   indicatorColor: Colors.white,
//   tabs: HomeScreen.myTabs,
// ),
                  leading: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: const Icon(
                      Icons.list,
                      size: 30,
                    ),
                  ),
                  actions: [
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      child: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    )
                  ],
                  backgroundColor: Colors.transparent,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.09,
                  title: const Text(
                    'Chat App',
                  ),
                  elevation: 0,
                  centerTitle: true,
                ),
                floatingActionButton: Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateRoomScreen.RouteName);
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
// body: Container(
//   color: Colors.transparent,
//   margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       Expanded(
//         child: TabBarView(
//           physics: const ScrollPhysics(),
//           controller: _tabController,
//             children: HomeScreen.myTabs.map((Tab tab){
//               final String label = tab.text!.toLowerCase();
//               return Center(
//                 child: Text(
//                   'This is the $label tab ',
//                   style: const TextStyle(fontSize: 36),
//                 ),
//               );
//             }).toList(),
//         ),
//       ),
//
//
//     ],
//   ),
// ),
                body: Container(
                   margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                    child: GridView.builder(
                  itemBuilder: (context, index) {
                    return RoomItem(
                        AppCubit.get(context).rooms[index]
                    );
                  },
                  itemCount: AppCubit.get(context).rooms.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    crossAxisSpacing: 1,

                  ),
                  shrinkWrap: true,



                )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
