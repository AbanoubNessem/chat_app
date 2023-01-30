import 'package:chat_app/shared/Models/room.dart';
import 'package:chat_app/ui/screens/Chat/chat.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  Room room ;


  RoomItem(this.room,);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Chat.routeName,arguments: room);
      },
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all( Radius.circular(25)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset(imagePath),
              Center(
                  child: Image.asset(
                "assets/images/${room.catId}.png",
                width: 60,
                height: 60,
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Expanded(
                child: Center(
                    child: Text(
                  room.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Center(
                  child: Text(room.catId,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey))),
            ],
          ),
        ),
      ),
    );
  }
}
