import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_page/user.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Map<String, User> userMap = <String, User>{};
  final StreamController<Map<String, User>> _usersController =
      StreamController<Map<String, User>>();
  final StreamController<Post> _postController = StreamController<Post>();

  final StreamController<List<User>> _userListController =
      StreamController<List<User>>();

  Stream<Map<String, User>> get users => _usersController.stream;
  Stream<Post> get post => _postController.stream;
  Stream<List<User>> get userList => _userListController.stream;

  DatabaseService() {
    _firestore.collection('users').snapshots().listen(_usersUpdated);
    _firestore.collection('post').doc("").snapshots().listen(_postUpdated);
  }

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }

  void _postUpdated(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var users = _getPostFromSnapshot(snapshot);
    _postController.add(users);
  }

  Map<String, User> _getUsersFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      User user = User.fromJson(element.id, element.data());
      userMap[user.id] = user;
    }
    return userMap;
  }

  Post _getPostFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Post post = Post.fromJson(snapshot.data()!);
    return post;
  }
}

class Post {
  final String message;
  Post({required this.message});
  Post.fromJson(Map<String, dynamic> json) : this(message: json["message"]);
}
