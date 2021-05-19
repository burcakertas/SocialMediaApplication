import 'package:flutter/material.dart';

Widget messages(msg_list){
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16,left: 16,right: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100
                  )
              ),
            ),
          ),
        ),
        ListView.builder(
          itemCount: msg_list.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index){
            return SingleChildScrollView(
              child: ConversationList(
                id: msg_list[index].id,
                name: msg_list[index].text,
                messageText: msg_list[index].messageText,
                imageUrl: msg_list[index].image,
                isMessageRead: (index == 0 || index == 3)?true:false,
              ),
            );
          },
        ),
      ]
    ),
  );
}

class ConversationList extends StatefulWidget{
  String id;
  String name;
  String messageText;
  String imageUrl;
  bool isMessageRead;
  ConversationList({@required this.id,@required this.name,@required this.messageText,@required this.imageUrl,@required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/single_message",arguments:{'id':widget.id});
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextButton(
                            child:Text(widget.name, style: TextStyle(fontSize: 16)),
                            onPressed: (){
                              Navigator.pushNamed(context, "/single_message",arguments:{'id':widget.id});
                              },
                          ),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.id,style: TextStyle(fontSize: 12),),
          ],
        ),
      ),
    );
  }
}