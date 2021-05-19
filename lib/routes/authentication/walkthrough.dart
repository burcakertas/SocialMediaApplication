import 'package:banana/routes/authentication/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:banana/util/Colors.dart';
import 'package:banana/util/Styles.dart';

class TestScreen extends StatelessWidget {

  final List<OnbordingData> list = [
    OnbordingData(
      image: AssetImage("assets/banana_welcome.png"),
      imageWidth: 80,
      imageHeight: 80,
      titleText:Text("Welcome to Banana",
        style: AppStyles().walkthroughTitle,
      ),
      descText: Text("Banana is a social media app developed in order to satisfy the needs of enthusiastic social media addicts.",textAlign: TextAlign.center),
    ),
    OnbordingData(
      image: AssetImage("assets/feed.png"),
      imageWidth: 200,
      imageHeight: 200,
      titleText:Text("Feed Page",
        style: AppStyles().walkthroughTitle,
      ),
      descText: Text("You can follow what is happening around constantly in your Feed Page.",textAlign: TextAlign.center),
    ),
    OnbordingData(
      image: AssetImage("assets/A-Complete-Guide-to-Social-Media-Customer-Service.png"),
      imageWidth: 300,
      imageHeight: 200,
      titleText:Text("Multifunctional Search Engine",
          textAlign: TextAlign.center,
          style: AppStyles().walkthroughTitle,
      ),
      descText: Text("By using search engine, you can discover new profiles and topics.",textAlign: TextAlign.center),
    ),
    OnbordingData(
      image: AssetImage("assets/follow.png"),
      imageWidth: 200,
      imageHeight: 150,
      titleText:Text("Follow profiles and topics",
          textAlign: TextAlign.center,
          style: AppStyles().walkthroughTitle,
      ),
      descText: Text("You can create some posts, follow profiles and interact with people.",textAlign: TextAlign.center),
    ),
    OnbordingData(
      image: AssetImage("assets/social-media-2706072-2260980.webp"),
      imageWidth: 200,
      imageHeight: 200,
      titleText:Text("Interact with posts",
          textAlign: TextAlign.center,
          style: AppStyles().walkthroughTitle,
      ),
      descText: Text("It is possible to interact with almost any post users share."),
    ),
    OnbordingData(
      image: AssetImage("assets/people-surrounded-by-social-media-icons-concept-illustration_52683-23432.jpg"),
      imageWidth: 200,
      imageHeight: 150,
      titleText:Text("Messages",
          textAlign: TextAlign.center,
          style: AppStyles().walkthroughTitle,
      ),
      descText: Text("Communicating with individuals have never been this easy."),
    ),
    OnbordingData(
      image: AssetImage("assets/features.jpg"),
      imageWidth: 200,
      imageHeight: 175,
      titleText:Text("Many more features",
          textAlign: TextAlign.center,
          style: AppStyles().walkthroughTitle,
      ),
      descText: Text("Join and discover our application.",textAlign: TextAlign.center),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      onbordingDataList: list,
      colors: [
        //list of colors for per pages
        Colors.white,
        Colors.red,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => Welcome(),
      ),
      nextButton: Text(
        "NEXT",
        style: TextStyle(
          color: AppColors().themeColor,
        ),
      ),
      lastButton: Text(
        "GOT IT",
        style: TextStyle(
          color:  AppColors().themeColor,
        ),
      ),
      skipButton: Text(
        "SKIP",
        style: TextStyle(
          color: AppColors().themeColor,
        ),
      ),
      selectedDotColor: AppColors().selectedDotColor,
      unSelectdDotColor: AppColors().unselectedDotColor,
    );
  }
}