import 'package:cloud_firestore/cloud_firestore.dart';

class Convo {
  Convo({required this.id, required this.userIds, required this.lastMessage});

  factory Convo.fromMap(String id, Map<String, dynamic> data) {
    return Convo(
        id: id, userIds: data['userIds'], lastMessage: data['lastMessage']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'userIds': userIds,
        'lastMessage': lastMessage,
      };

  final String id;
  final String userIds;
  final String lastMessage;
}

class Message {
  Message(
      {required this.id,
      required this.content,
      required this.idfrom,
      required this.idTo,
      required this.timestamp});

  factory Message.fromMap(String id, Map<String, dynamic> data) {
    return Message(
        id: id,
        content: data['content'],
        idfrom: data['idfrom'],
        idTo: data['idTo'],
        timestamp: data['timestamp']);
  }

  final String id;
  final String content;
  final String idfrom;
  final String idTo;
  final DateTime timestamp;
}
