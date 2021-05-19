import 'package:banana/util/Styles.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:<Widget> [
          Center(
            child:Image(
              image:AssetImage(
                "assets/banana_welcome.png"
              ),
              width: 90,
              height: 90,
            )
          ),
          Center(
            child: Text("Reach the whole world \n\t\t with a single click."
            ,style: AppStyles().welcomeLargeText
            ),
          ),
          ElevatedButton(
            child:Text("Create an account",
              style:AppStyles().createAnAccText
            )
          ,onPressed: (){
              Navigator.pushNamed(context, "/signup");
          },
            style: AppStyles().createAnAccButton
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/login");
                },
                child: Row(
                  children: <Widget>[
                    Text("Already have an account?",
                        style:AppStyles().alreadyHaveAccTexts["grey"]
                    ),
                    Text(" Login",
                      style:AppStyles().alreadyHaveAccTexts["yellow"]
                    ),
                  ],
                )
              )
            ],
          )
        ],
        )
      ),
    );
  }
}
