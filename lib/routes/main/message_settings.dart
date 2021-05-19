import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:banana/util/User.dart';
import 'package:custom_switch/custom_switch.dart';
import'package:http/http.dart' as http;
import 'dart:convert';

Future<User> fetchUser(String id) async {
  final response = await http.get(Uri.http('localhost:3000', '/users',{"id":id}));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user information.');
  }
}
class MessageSettings extends StatefulWidget {
  @override
  _MessageSettingsState createState() => _MessageSettingsState();
}

class _MessageSettingsState extends State<MessageSettings> {
  String id = null;
  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=rcvdData["id"].toString();
    });
    return FutureBuilder(future: fetchUser(id),builder: (context,data){
      if(data.hasData){
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(200.0),
              child: AppBar(
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: AppColors().mostUsedBlack),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: AppColors().themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data.data.picture)
                                    )
                                )
                            ),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(data.data.name),
                                Text("@${data.data.username}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body:Container(
                child:Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromRGBO(230, 230, 230, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Mute conversation",
                                style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            CustomSwitch(
                              activeColor: AppColors().themeColor,
                              value: false,
                              onChanged: (value) {
                                print("VALUE : $value");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromRGBO(230, 230, 230, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Block ",
                                style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(56, 159, 240, 1)
                                )
                            ),
                            Text("@onurarda ",
                                style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromRGBO(230, 230, 230, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Report ",
                                style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(144,209,80,1)
                                )
                            ),
                            Text("@onurarda ",
                                style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromRGBO(230, 230, 230, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Delete conversation ",
                                style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(234,69,51,1)
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            )
        );
      } return Container(child:Center(child:Text("An error occured.")));
    },);
  }
}

/*return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: AppColors().mostUsedBlack),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppColors().themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/trump_president_avatar_male-512.png")
                              )
                          )
                      ),
                              SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Arda"),
                                  Text("@onurarda"),
                                ],
                              ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body:Container(
        child:Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(230, 230, 230, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Mute conversation",
                        style:TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        )
                    ),
                    CustomSwitch(
                      activeColor: AppColors().themeColor,
                      value: false,
                      onChanged: (value) {
                        print("VALUE : $value");
                      },
                    ),
                  ],
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(230, 230, 230, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Block ",
                        style:TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(56, 159, 240, 1)
                        )
                    ),
                    Text("@onurarda ",
                        style:TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(230, 230, 230, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Report ",
                        style:TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(144,209,80,1)
                        )
                    ),
                    Text("@onurarda ",
                        style:TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(230, 230, 230, 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Delete conversation ",
                        style:TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(234,69,51,1)
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      )
    );*/