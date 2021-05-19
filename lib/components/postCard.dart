import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:banana/util/Styles.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> splitter(String content){
  List<String> returner=[];
  if(content.length<40)
    return [content];
  int i = 0;
  for(i = 0; i< (content.length/40)-1;i++){
    returner.add(content.substring(i*40,(i+1)*40));
  }
  returner.add(content.substring(i*40));
  return returner;
}

class UserCards{
  Widget postCard(feed) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(feed.picture)
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(feed.name,
                    style: TextStyle (
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontSize: 18
                    ),
                  ),

                  Text(feed.username,
                    style: TextStyle (
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontSize: 12
                    ),
                  ),
                  for(var substr in splitter(feed.content))Text(
                    substr,
                    style: TextStyle (
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontSize: 12
                    ),
                  ),
                  feed.media!=null?Image.network("https://picsum.photos/250?image=9"):SizedBox(),
                  SizedBox(height:5,),
                  Row(
                    children: [
                      LikeButton(
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            FontAwesomeIcons.solidHeart,
                            color: isLiked ? Colors.redAccent : Colors.grey,
                          );
                        },
                      ),
                      LikeButton(
                        likeBuilder: (bool isUnLiked) {
                          return Icon(
                            FontAwesomeIcons.heartBroken,
                            color: isUnLiked ? Colors.redAccent : Colors.grey,
                          );
                        },
                      ),
                      LikeButton(
                        likeBuilder: (bool reBanana) {
                          return Icon(
                            FontAwesomeIcons.retweet,
                            color: reBanana ? Colors.blueAccent : Colors.grey,
                          );
                        },
                      ),
                      LikeButton(
                        likeBuilder: (bool reBanana) {
                          return Icon(
                            FontAwesomeIcons.solidBookmark,
                            color: reBanana ? Colors.green : Colors.grey,
                          );
                        },
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Media(feeds){
    int length = feeds.length;
    if(length%2==0){
      return Column(
          children: [
            for(int i=0;i<length;i+=2)
              Row(children: [
                  Image.network("https://picsum.photos/250?image=9",height: 200,width: 200,),
                  Image.network("https://picsum.photos/250?image=9",height: 200,width: 200,),
              ],
              )
          ],
        );
    }else if(length>1){
      return Column(
          children: [
            for(int i=0;i<length-1;i+=2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Card(child: Image.network("https://picsum.photos/250?image=9",height: 150,width: 150,)),
                Card(child: Image.network("https://picsum.photos/250?image=9",height: 150,width: 150,)),
              ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Image.network("https://picsum.photos/250?image=9",height: 150,width: 150,),
              ],
              )
          ],
        );
    }

  }

  Widget Followers(user) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user.picture)
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.name,
                    style: TextStyle (
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontSize: 18
                    ),
                  ),

                  Text(user.username,
                    style: TextStyle (
                        color: Color.fromRGBO(78, 78, 78, 1),
                        fontSize: 12
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle (
                        color: Color.fromRGBO(78, 78, 78, 1),
                        fontSize: 12
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Followings(user) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user.picture)
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(user.name,
                        style: TextStyle (
                            color: Color.fromRGBO(78, 78, 78, 1),
                            fontSize: 18
                        ),
                      ),
                      SizedBox(width: 170-8*user.name.length.toDouble()>-1 ? 170-8*user.name.length.toDouble() : -1*(170-8*user.name.length.toDouble()),),
                      ElevatedButton(
                        onPressed:(){},
                          child:Text("Following",
                              style:TextStyle(
                                  fontSize: 12,
                                  color: AppColors().innerButtonWhite
                              )
                          ),
                          style: AppStyles().submitButton
                      ),
                    ],
                  ),
                  Text(user.username,
                    style: TextStyle (
                        color: Color.fromRGBO(78, 78, 78, 1),
                        fontSize: 12
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle (
                        color: Color.fromRGBO(78, 78, 78, 1),
                        fontSize: 12
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget MessagesListCard(user) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user.picture)
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.name,
                    style: TextStyle (
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontSize: 18
                    ),
                  ),

                  Text(user.username,
                    style: TextStyle (
                        color: Color.fromRGBO(78, 78, 78, 1),
                        fontSize: 12
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget NotificationsListCard(notification) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(notification.picture)
                        )
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(notification.name,
                    style: TextStyle (
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontSize: 18
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}