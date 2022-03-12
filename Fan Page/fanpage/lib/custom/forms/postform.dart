import 'package:fanpage/database_service.dart';
import 'package:fanpage/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/loading.dart';

class PostForm extends StatefulWidget {
  const PostForm({
    Key? key,
  }) : super(key: key);
  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  var loading = false;
  var message = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    // ignore: prefer_const_constructors
                    Expanded(
                      child: TextField(
                        controller: message,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                          postMessage();
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  void postMessage() async {
    var post = message.text.trim();
    if (post.isNotEmpty) {
      await db.addPost(auth.currentUser!.uid, post);
      snackBar(context, "Message successfully added.");
      Navigator.of(context).pop();
    } else {
      snackBar(context, "Message not formated properly.");
      setState(() {
        loading = false;
      });
    }
  }
}
