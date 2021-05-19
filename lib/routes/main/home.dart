import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:banana/util/Colors.dart';

//Components
import 'package:banana/components/postCard.dart';
import 'package:banana/components/customDrawer.dart';
import 'package:banana/components/messagesBody.dart';
import 'package:banana/components/notificationCard.dart';

//Utils Class
import 'package:banana/util/Feed.dart';
import 'package:banana/util/Message.dart';
import 'package:banana/util/Notifications.dart';

Widget buildBody(int state,String id,dynamic context){
  if(state==0){
    return FutureBuilder(
      future:fetchFeed(state, id),
      builder:(context,data){
        if(data.hasData){
          return SingleChildScrollView(child:
          Column(
            children: [
              for(var item in data.data)UserCards().postCard(item)
            ],)
          );
        }return Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors().themeColor,
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors().themeColor),
          ),
        );
      }
    );
  }else if (state==2){
    return FutureBuilder(
      future:fetchNotifications(state,id),
      builder:(context,data){
        if(data.hasData){
          if(data.data.length==0){
            //no notifications view
            return Center(
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    color: AppColors().themeColor,
                    width: 350,
                    height: 650,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          Text(
                              "No notifications available yet.",
                            style:TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Text(
                              "When new notification found, they'll show up here.",
                              style: TextStyle(
                                color:AppColors().mostUsedBlack
                              ),
                          ),
                        ]
                      )
                    ),
                  )
                )
            );
                }else{
            //notifications card
           return ListView.builder(
              itemCount: data.data.length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index){
                return SingleChildScrollView(
                  child: NotificationsList(id:data.data[index].id.toString(),text:data.data[index].text,)
                );
              },
            );
          }
        }return Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors().themeColor,
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors().themeColor),
            //refresh after a certain time
          ),
        );
      }
    );
  }else if (state==3){
    return FutureBuilder(
      future:fetchMessages(state, id),
      builder:(context,data){
        if(data.hasData){
          return messages(data.data);
        }return Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors().themeColor,
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors().themeColor),
          ),
        );
      }
    );
  }else{
    print(state);
    return Center(
        child:Text("This page is under construction")
    );
  }
}
Future<List<Notifications>> fetchNotifications(int state,String id) async{
  List<Notifications> notifications = [];
  if(state==2){
    final response = await http.get(Uri.http('localhost:3000', '/notifications',{"_start":id,"_end":(int.parse(id)+1).toString()}));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var item in jsonDecode(response.body)[0]){
        notifications.add(Notifications(id:item["id"],text:item["text"]));
      }
      return notifications;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load feed information.');
    }
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed information.');
  }
}
Future<List<Feed>> fetchFeed(int state,String id) async{
  List<Feed> feeds = [];
  if(state==0){
    final response = await http.get(Uri.http('localhost:3000', '/feeds',{"_start":id,"_end":(int.parse(id)+1).toString()}));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      feeds = List<Feed>.from(jsonDecode(response.body)[0].map((model)=> Feed.fromJson(model)));
      return feeds;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load feed information.');
    }
  }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load feed information.');
    }
}

Future<List<ChatUsers>> fetchMessages(int state,String id) async{
  List<ChatUsers> msg = [];
  final response = await http.get(Uri.http('localhost:3000', '/messages',{"_start":id,"_end":(int.parse(id)+1).toString()}));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var decoded = jsonDecode(response.body)[0];
    for(var item in decoded){
      msg.add(ChatUsers(id:item["id"].toString(),text: item["text"], messageText: item["messageText"], image: item["p_pic"]));
    }
    return msg;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed information.');
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  List<String> CurrentTitle = ["Home","Search","Notifications","Messages"];
  List<IconData> IconsList = [Icons.home_filled,Icons.search,Icons.notifications,Icons.message];
  List<IconData> FABIcons = [Icons.keyboard,Icons.keyboard,null,Icons.mail];
  int currentState = 0;
  String id = null;

  void onTabTapped(int index) {
    setState(() {
      currentState = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=rcvdData["id"].toString();
    });
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: currentState==2 ? [
              GestureDetector(
              onTap: () {  Navigator.pushNamed(context, "/notifications_",arguments: {"id":id});},
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Settings-2-512.png"),
                maxRadius: 25,
              ),
            ),SizedBox(width:5,height:5)] : [],
            iconTheme: IconThemeData(color: AppColors().themeColor),
            title: Center(
              child: Row(
                children: [
                  Icon(IconsList[currentState],size:35.0,color:AppColors().batmanGrey),
                  SizedBox(width: 10.0,),
                  Text(CurrentTitle[currentState],style:TextStyle(color:AppColors().batmanGrey)),
                ],
              ),
            ),
            backgroundColor: AppColors().innerButtonWhite,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentState,
            onTap: onTabTapped,
            fixedColor: AppColors().themeColor,
            items:<BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Messages',
              ),
            ],
          ),
          body:buildBody(currentState,id,context),
          floatingActionButton: currentState!=2?Container(
              height: 70.0,
              width: 70.0,
              child: FloatingActionButton(
                onPressed:(){},
                child: Icon(FABIcons[currentState],color: AppColors().mostUsedBlack,size: 55.0,),
                backgroundColor: AppColors().themeColor,
              )
          ):null,
          endDrawer: (currentState!=2) ? customDrawer(id) : null
      )
    );
  }
}

