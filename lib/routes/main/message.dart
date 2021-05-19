import 'package:banana/util/Message.dart';
import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
Future<ChatUsersDetailed> fetchMessages(String id) async {
  final response = await http.get(Uri.http('localhost:3000', '/messages_single',{"_start":id,"_end":(int.parse(id)+1).toString()}));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var decoded = jsonDecode(response.body)[0];

    var generated =  ChatUsersDetailed(id:decoded["id"].toString(), text:decoded["text"],  messageText:decoded["messageText"], image:decoded["p_pic"],conversations:["amk","amk","amk","amk"]);
    return generated;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user information.');
  }
}

class SingleMessage extends StatefulWidget {
  @override
  _SingleMessageState createState() => _SingleMessageState();
}

class _SingleMessageState extends State<SingleMessage> {
  String id = null;
  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    setState(() {
      id=rcvdData["id"].toString();
    });
    return FutureBuilder(future:fetchMessages(id),builder: (context,data){
      if(data.hasData){
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.black,),
                      ),
                      SizedBox(width: 2,),
                      CircleAvatar(
                        backgroundImage: NetworkImage(data.data.image),
                        maxRadius: 20,
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(data.data.text,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                            SizedBox(height: 6,),
                            Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                          ],
                        ),
                      ),
                      //Icon(Icons.settings,color: Colors.black54,),
                      GestureDetector(
                        onTap: () {  Navigator.pushNamed(context, "/message_",arguments: {"id":id});},
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Settings-2-512.png"),
                          maxRadius: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: data.data.conversations.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    physics: PageScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Align(
                          alignment: (index%2==0?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (index%2!=0?Colors.grey.shade200:Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(data.data.conversations[index], style: TextStyle(fontSize: 15),),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 15,),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          FloatingActionButton(
                            onPressed: (){},
                            child: Icon(Icons.send,color: Colors.white,size: 18,),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],

                      ),
                    ),
                  ),
                  Container(child: SizedBox(height:10,),color: Colors.white,)
                ],
              ),
            ),
        );
      }

      return Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors().themeColor,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors().themeColor),
        ),
      );

    });
  }
}
