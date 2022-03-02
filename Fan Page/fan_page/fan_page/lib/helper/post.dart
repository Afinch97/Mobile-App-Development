class Post {
  final String id;
  final String message;
  const Post({required this.id, required this.message});

  Post.fromJson(String id, Map<String, dynamic> json)
      : this(
          id: id,
          message: json['message']! as String,
        );

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "message": message,
    };
  }
}
