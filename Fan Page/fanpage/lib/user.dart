class User {
  final String id;
  final String displayName;
  final String email;
  final String role;

  User({
    required this.id,
    required this.displayName,
    required this.role,
    required this.email,
  });

  User.fromJson(String id, Map<String, dynamic> json)
      : this(
            id: id,
            displayName: json["display_name"],
            email: json["email"],
            role: json["role"]);

  Map<String, dynamic> toJson() {
    return {"display_name": displayName, "email": email, "role": role};
  }
}
