import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      name: data['name'],
      email: data['email'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };

  final String id;
  final String name;
  final String email;
}
