import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan_page/user.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Map<String, User> userMap = <String, User>{};
  final StreamController<Map<String, User>> _usersController =_usersController
}

class Post {
  final String message;
  Post({required this.message});
  Post.fromJson(Map<String, dynamic> json) : this(message: json["message"]);
}
