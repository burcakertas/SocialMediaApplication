import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';

class AppStyles{
  //Walkthrough Pages
  final walkthroughTitle = GoogleFonts.openSans(
      textStyle: TextStyle(
          color:AppColors().themeColor,
          fontSize: 30.0,
          fontWeight: FontWeight.bold
      )
  );


  //Welcome Page
  final welcomeLargeText = GoogleFonts.openSans(
      fontStyle: FontStyle.normal,
      textStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold
      )
  );
  final createAnAccText = TextStyle(
      fontSize: 12,
      color: AppColors().innerButtonWhite
  );
  final createAnAccButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors().themeColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          )
      )
  );
  final alreadyHaveAccTexts = {
    'grey':GoogleFonts.openSans(
        textStyle:TextStyle(
            color: AppColors().batmanGrey
        ),
        fontWeight: FontWeight.bold
    ),
    'yellow':GoogleFonts.openSans(
        textStyle:TextStyle(
            color: AppColors().themeColor
        ),
        fontWeight: FontWeight.bold
    ),
  };


  //SignUp Page
  final nameDecoration = InputDecoration(
    //prefixIcon: Icon(Icons.contact_phone_rounded ),
      suffixIcon: Icon(Icons.badge),
      fillColor: AppColors().batmanGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color:AppColors().batmanGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColors().themeColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      labelStyle: TextStyle(
        color: AppColors().mostUsedBlack,
      ),
      labelText: 'Name',
      hintText: 'Enter your name',
      hintStyle: TextStyle(
          color:AppColors().authenticationInput
      )
  );

  final usernameDecoration = InputDecoration(
    //prefixIcon: Icon(Icons.contact_phone_rounded ),
      suffixIcon: Icon(Icons.badge),
      fillColor: AppColors().batmanGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color:AppColors().batmanGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColors().themeColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      labelStyle: TextStyle(
        color: AppColors().mostUsedBlack,
      ),
      labelText: 'Username',
      hintText: 'Enter your username',
      hintStyle: TextStyle(
          color:AppColors().authenticationInput
      )
  );


  final emailDecoration = InputDecoration(
      suffixIcon: Icon(Icons.contact_mail_rounded),
      fillColor: AppColors().batmanGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color:AppColors().batmanGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColors().themeColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      labelStyle: TextStyle(
        color: AppColors().mostUsedBlack,
      ),
      labelText: 'Email',
      hintText: 'abc@gmail.com',
      hintStyle: TextStyle(
          color: AppColors().authenticationInput
      )
  );

  //Login Styles
  final  loginEmailDecoration = InputDecoration(
      suffixIcon: Icon(Icons.connect_without_contact_rounded),
      fillColor: AppColors().batmanGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color:AppColors().batmanGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColors().themeColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      labelStyle: TextStyle(
        color: AppColors().mostUsedBlack,
      ),
      labelText: 'Email or username',
      hintText: 'Ex:abc@gmail.com or @funzin',
      hintStyle: TextStyle(
          color:AppColors().authenticationInput
      )
  );

  //Submit Button Style for both Login and Signup
  final submitButton = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors().themeColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          )
      )
  );

  //Change Profile
  final birthDate = InputDecoration(
      suffixIcon: Icon(Icons.date_range),
      fillColor: AppColors().batmanGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color:AppColors().batmanGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColors().themeColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      labelStyle: TextStyle(
        color: AppColors().mostUsedBlack,
      ),
      labelText: 'Birth Date',
      hintText: 'Ex:01.01.2000',
      hintStyle: TextStyle(
          color: AppColors().authenticationInput
      )
  );

  final bioDecoration = InputDecoration(
      suffixIcon: Icon(Icons.info),
      fillColor: AppColors().batmanGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color:AppColors().batmanGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(color: AppColors().themeColor, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      labelStyle: TextStyle(
        color: AppColors().mostUsedBlack,
      ),
      labelText: 'Bio',
      hintText: 'Ex:I am a techy guy with british accent.',
      hintStyle: TextStyle(
          color: AppColors().authenticationInput
      )
  );
}