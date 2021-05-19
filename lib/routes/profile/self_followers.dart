import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:banana/util/User.dart';
import 'package:banana/util/Styles.dart';
import 'package:banana/components/postCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<User>> fetchUsers(String id) async {
  final response = await http.get(Uri.http('localhost:3000', '/followers',{"_start":id,"_end":(int.parse(id)+1).toString()}));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    List<User> followers_ = [];
    var responseCoded = jsonDecode(response.body)[0];
    for(var i = 0; i<responseCoded.length;i++)
      followers_.add(User.fromJson(responseCoded[i]));
    return followers_;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user information.');
  }
}

class SelfFollowers extends StatefulWidget {

  @override
  _SelfFollowersState createState() => _SelfFollowersState();
}

class _SelfFollowersState extends State<SelfFollowers> {
  String id = null;
  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=rcvdData["id"].toString();

    });
    return FutureBuilder(future:fetchUsers(id),builder: (context,users){
      if(users.hasData){
        return Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: AppColors().mostUsedBlack),
                onPressed: () => Navigator.of(context).pop(),
              ),
              bottom: PreferredSize(
                  child: Container(
                    color: AppColors().mostUsedBlack,
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(4.0)),
              iconTheme: IconThemeData(
                color: AppColors().mostUsedBlack,
              ),
              title: Text("Followers",
                style: TextStyle(
                  color: AppColors().mostUsedBlack,
                ),
              ),
              centerTitle: true,
              backgroundColor: AppColors().innerButtonWhite,

            ),
            body:SingleChildScrollView(child: Column(
              children: [
                for(int i=0;i<users.data.length;i++)
                  UserCards().Followers(users.data[i])
              ],
            ),)
        );
      }return Container();
    });
  }
}
