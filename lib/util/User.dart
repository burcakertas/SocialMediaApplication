class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String picture;
  final List<String> followers;
  final List<String> followings;
  final bool accPrivate;
  final bool accDeactive;
  User({this.id,  this.name,  this.username, this.email, this.picture, this.followers, this.followings, this.accPrivate, this.accDeactive});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      name: json['name'],
      username: json['username'],
      email: json['email'],
      picture: json['p_pic'],
      followings: List.from(json['followings']),
      followers: List.from(json['followers']),
      accPrivate: json['accPrivate']!=null ? json['accPrivate'] : false,
      accDeactive: json['accDeactive']!=null ? json['accDeactive']:false,
    );
  }
}