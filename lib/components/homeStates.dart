import 'package:flutter/material.dart';
import 'package:banana/components/postCard.dart';

class HomeStates{

  Widget feeds(feeds){
      return Container(
          child:SingleChildScrollView(
            child: Column(
              children: [
                for(int i=0;i<feeds.length;i++)
                  UserCards().postCard(feeds[i])
              ],
            ),
          )
      );
    }

}