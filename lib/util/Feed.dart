class Feed {
  final int id;
  final String name;
  final String username;
  final String email;
  final String picture;
  final String content;
  final String media;

  Feed({this.id,  this.name,  this.username, this.email, this.picture, this.content,this.media});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: int.parse(json['id']),
      name: json['name'],
      username: json['username'],
      email: json['email'],
      picture: json['p_pic'],
      content:json['content'],
      media:json['media']
    );
  }
}