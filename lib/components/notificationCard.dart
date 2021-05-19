import 'package:flutter/material.dart';

class NotificationsList extends StatefulWidget{
  String id;
  String text;

  NotificationsList({@required this.id,@required this.text});
  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextButton(
                            child:Text(widget.id, style: TextStyle(fontSize: 16)),
                            onPressed: (){
                              Navigator.pushNamed(context, "/single_message",arguments:{'id':widget.id});
                            },
                          ),
                          SizedBox(height: 6,),
                          Text(widget.text,style: TextStyle(fontSize: 13,color: Colors.grey.shade600),),
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