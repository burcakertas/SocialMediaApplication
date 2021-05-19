import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:banana/util/User.dart';
import 'package:auto_size_text/auto_size_text.dart';


Future<User> fetchDrawer(String id) async {
  final response = await http.get(Uri.http('localhost:3000', '/users',{"id":id}));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(User.fromJson(jsonDecode(response.body)[0]));
    return User.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user information.');
  }
}

class customDrawer extends StatefulWidget {
  customDrawer(this.id);
  final String id;
  @override
  _customDrawerState createState() => _customDrawerState();
}
class _customDrawerState extends State<customDrawer> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String id;
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=rcvdData["id"].toString();
    });
    return Drawer(
        child:FutureBuilder<User>(
          future: fetchDrawer(widget.id),
          builder: (context, user) {
            if (user.hasData) {
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(200.0),
                  child: AppBar(
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back, color: AppColors().themeColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: AppColors().themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              child:Image(
                                                image:NetworkImage(
                                                  "${user.data.picture}",
                                                ),
                                                height: 80,
                                              ),
                                              onTap: (){
                                                Navigator.pushNamed(context, "/profile",arguments:{'id':id});
                                              },
                                            ),
                                            SizedBox(
                                              child: Row(children: [
                                                TextButton(
                                                  child:AutoSizeText("${user.data.name}",
                                                      style:TextStyle(
                                                          color:AppColors().mostUsedBlack,
                                                      ),
                                                    maxFontSize: 20.0,
                                                    maxLines: 1,
                                                  ),
                                                  onPressed: (){Navigator.pushNamed(context, "/profile",arguments: {'id':id});},
                                                ),
                                                TextButton(
                                                  child:AutoSizeText("${user.data.username}",
                                                      style:TextStyle(
                                                          color:AppColors().mostUsedBlack,
                                                      ),
                                                      maxFontSize: 15.0,
                                                      maxLines: 1
                                                  ),
                                                  onPressed: (){Navigator.pushNamed(context, "/profile",arguments:{'id':id});},
                                                ),
                                              ],),
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: (){Navigator.pushNamed(context, "/self_followers",arguments:{'id':id});},
                                                  child: Text("Followers",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: AppColors().mostUsedBlack
                                                      )
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: (){Navigator.pushNamed(context, "/self_following",arguments:{'id':id});},
                                                  child: Text("Following",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: AppColors().mostUsedBlack
                                                      )
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body:ListView(
// Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: Text('Profile'),
                      onTap: () {
                        Navigator.pushNamed(context, "/profile",arguments:{'id':id});
                      },
                    ),
                    ListTile(
                      title: Text('Lists'),
                      onTap: () {
// Update the state of the app.
// ...
                      },
                    ),
                    ListTile(
                      title: Text('Topics'),
                      onTap: () {
// Update the state of the app.
// ...
                      },
                    ),
                    ListTile(
                      title: Text('Bookmarks'),
                      onTap: () {
// Update the state of the app.
// ...
                      },
                    ),
                    ListTile(
                      title: Text('Follower Requests'),
                      onTap: () {
// Update the state of the app.
// ...
                      },
                    ),
                    Divider(
                        color:AppColors().mostUsedBlack
                    ),
                    ListTile(
                      title: Text('Settings and Privacy'),
                      onTap: () {
// Update the state of the app.
// ...
                      },
                    ),
                    ListTile(
                      title: Text('Help Center'),
                      onTap: () {
// Update the state of the app.
// ...
                      },
                    ),
                    Divider(
                        color:AppColors().mostUsedBlack
                    ),
                    ListTile(
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.popUntil(context,ModalRoute.withName('/login'));
                      },
                    ),
                  ],
                ),
              );
            } else if (user.hasError) {
              return Text("${user.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
    );
  }
}



