import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:banana/util/User.dart';
import 'package:banana/util/Feed.dart';
import 'package:banana/components/postCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
Future<List<Feed>> buildContext(String id,int currentState) async {
  if(currentState==1){
    final response = await http.get(Uri.http('localhost:3000', '/user_bananas',{"_start":id,"_end":(int.parse(id)+1).toString()}));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Feed> feeds = [];
      var decoded = jsonDecode(response.body)[0];
      for(int i = 0; i < decoded.length;i++){
        feeds.add(Feed.fromJson(decoded[i]));
      }
      return feeds;
    }
  }else if(currentState==2){
      final response = await http.get(Uri.http('localhost:3000', '/user_bananas',{"_start":id,"_end":(int.parse(id)+1).toString()}));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        List<Feed> feeds = [];
        var decoded = jsonDecode(response.body)[0];
        for(int i = 0; i < decoded.length;i++){
          if(decoded[i]["media"]!=null){feeds.add(Feed.fromJson(decoded[i]));}
        }

        return feeds;
      }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user information.');
    }
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String id = null;
  int currentShow;
@override
  void initState() {
    // TODO: implement initState
    currentShow=1;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=rcvdData["id"].toString();
    });
    return FutureBuilder(
      future:fetchUser(id),
      builder:(context,user){
        if(user.hasData){
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
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:18.0),
                              child: GestureDetector(
                                child:Image(
                                  image:NetworkImage(
                                    "${user.data.picture}",
                                  ),
                                  height: 80,
                                ),
                                //onTap: (){
                                  //Navigator.pushNamed(context, "/profile",arguments:{'id':id});
                                //},
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(170, 0, 0, 0), // Padding Issue
                                              child: TextButton(onPressed: (){Navigator.pushNamed(context, "/change_profile",arguments:{'id':id});}, child: Text("Change profile",
                                                  style:TextStyle(
                                                      fontSize: 12.0,
                                                      color:AppColors().batmanGrey
                                                  )
                                              ),
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                              side: BorderSide(color: AppColors().batmanGrey)
                                                          )
                                                      )
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text("${user.data.name}",style: TextStyle(fontSize: 16.0,color:AppColors().mostUsedBlack),),
                                        Text("@${user.data.username}",style: TextStyle(fontSize: 18.0,color: AppColors().mostUsedBlack),),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: (){Navigator.pushNamed(context, "/self_followers",arguments: {'id':id});},
                                              child: Text("Followers ${user.data.followers.length}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: AppColors().mostUsedBlack
                                                  )
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: (){Navigator.pushNamed(context, "/self_following",arguments: {'id':id});},
                                              child: Text("Following ${user.data.followings.length}",
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
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(child: Text("Bananas and Peels",style: TextStyle(color:AppColors().batmanGrey,decoration: currentShow==1?TextDecoration.underline:null),),onPressed: (){setState(() {
                          currentShow=1;
                        });}),
                        TextButton(child: Text("Media",style: TextStyle(color:AppColors().batmanGrey,decoration: currentShow==2?TextDecoration.underline:null)),onPressed: (){setState(() {
                          currentShow=2;
                        });}),
                        TextButton(child: Text("Locations",style: TextStyle(color:AppColors().batmanGrey,decoration: currentShow==3?TextDecoration.underline:null)),onPressed: (){setState(() {
                          currentShow=3;
                        });}),
                      ],
                    ),
                    Divider(color: AppColors().batmanGrey,),
                    FutureBuilder(future:buildContext(id, currentShow),builder: (context,data){
                     if(data.hasData){
                       if(currentShow==1){
                         return Column(
                           children: [ for(var item in data.data ) UserCards().postCard(item)
                           ],
                         );
                       }else if(currentShow==2){
                         return Column(
                           children: [ for(var item in data.data ) UserCards().postCard(item)
                           ],
                         );
                       }
                     }return Container(child:Center(child: Text("No data exists")));
                    }),
                  ],
                ),
              ),
            ),
            floatingActionButton: Container(
              height: 70.0,
              width: 70.0,
              child: FloatingActionButton(
                onPressed:(){},
                child: Icon(Icons.keyboard,color: AppColors().mostUsedBlack,size: 55.0,),
                backgroundColor: AppColors().themeColor,
              ),
            ),
          );
      }
        else{
          return Container(child:Center(child:Text("Problem occured...")));
        }
    }
    );

  }
}
