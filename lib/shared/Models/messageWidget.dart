import 'package:chat_app/shared/Models/message.dart';
import 'package:chat_app/shared/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return userProvider.user?.id == message.senderId
        ? SendMessage(message)
        : RecivedMessage(message);
  }
}

class SendMessage extends StatelessWidget {
  Message message;

  SendMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(DateFormat("KK:mm a").format(DateTime.fromMicrosecondsSinceEpoch(message.messageTime)) .toString(),style: TextStyle(color: Colors.grey,fontSize: 12)),
          SizedBox(width: 5,),
          Expanded(
              child: Container(

                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Text(message.content,
                      style: TextStyle(color: Colors.white)))),
        ],
      ),
    );
  }
}

class RecivedMessage extends StatelessWidget {
  Message message;

  RecivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.senderName,style: TextStyle(color: Colors.grey,fontSize: 14)),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      child:
                          Text(message.content, style: TextStyle(color: Colors.black87))),
                ),
                SizedBox(width: 5,),
                Text(DateFormat("KK:mm a").format(DateTime.fromMicrosecondsSinceEpoch(message.messageTime)) .toString(),style: TextStyle(color: Colors.grey,fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
