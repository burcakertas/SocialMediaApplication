class Notifications {
  int id;
  String text;


  Notifications({this.id,  this.text });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
        id: int.parse(json['id']),
        text: json['text'],
    );
  }
}