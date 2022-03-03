import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fanpage/helper/post.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _db.collection("posts").snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container();
        });
  }
}

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => Home();
}

class Home extends State<HomePage2> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Post> posts = [];

  @override
  void initState() async {
    super.initState();
    var snapshots = _db.collection("posts").snapshots();
    snapshots.forEach((element) {
      for (var doc in element.docs) {
        posts.add(Post.fromJson(doc.id, doc.data()));
      }
    });
  }

  void post(String message) {
    _db.collection("posts").add({
      "contents": "yo",
      "timestamp": "1575351064106",
      "type": 0,
      "user": "0M8KX5dGQbPaEucoFPJGE9sDTt2"
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _db.collection("posts").snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          for (var element in snapshot.data!.docs) {
            posts.add(Post.fromJson(element.id, element["message"]));
          }
          return Container();
        });
  }
}
