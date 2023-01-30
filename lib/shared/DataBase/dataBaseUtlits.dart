import 'package:chat_app/shared/Models/message.dart';
import 'package:chat_app/shared/Models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/myUser.dart';

class DataBaseUtlits {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.colectionName)
        .withConverter(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionRoomName)
        .withConverter(
            fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
            toFirestore: (room, _) => room.toJson());
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: (snapshot, _) =>
                Message.fromJson(snapshot.data()!),
            toFirestore: (message, _) => message.toJson());
  }

  static Future<void> createRoom(String name, String dsec, String catId) {
    var roomCollection = getRoomsCollection();
    var docRef = roomCollection.doc();
    Room room = Room(id: docRef.id, name: name, dsec: dsec, catId: catId);
    return docRef.set(room);
  }

  static Future<void> InsertMessageToFireStore(Message message) {
    var messageCollection = getMessageCollection(message.roomId);
    var docref = messageCollection.doc();
    message.id = docref.id;
    return docref.set(message);
  }

  static Future<void> createDBUser(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String userId) async {
    var readSnapshot = await getUserCollection().doc(userId).get();
    return readSnapshot.data();
  }

  static Future<List<Room>> getRoomsFromFireStore() async {
    var querySnapShot = await getRoomsCollection().get();
    return querySnapShot.docs.map((doc) => doc.data()).toList();
  }

  static Stream<QuerySnapshot<Message>> getMessageStreams(String roomId) {
    return getMessageCollection(roomId).orderBy("messageTime").snapshots();
  }
}
