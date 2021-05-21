import 'package:banana/util/Styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:banana/util/User.dart';


Future<User_> fetchUser() async {
  var uid = await FirebaseAuth.instance.currentUser.uid;
  var usrInfo = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  return User_(id:uid,username:usrInfo.data()["username"],name:usrInfo.data()["name"],picture:usrInfo.data()["picUrl"]);
}

class ChangeProfile extends StatefulWidget {
  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _formKey = GlobalKey<FormState>();

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop(); },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {Navigator.of(context).pop(); /*delete account*/ Navigator.of(context).popUntil((ModalRoute.withName("/login")));},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure you want to delete your account?"),
      content: Text("This operation can not be returned back. Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future:fetchUser(),builder: (context,user){
      if(user.hasData){
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(700.0),
            child: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: AppColors().mostUsedBlack),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: AppColors().themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(80),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  title:Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 100.0,),
                          Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(user.data.picture)
                                  )
                              )
                          ),
                          Padding(
                            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Theme(
                              child: TextFormField(
                                decoration: AppStyles().nameDecoration,
                                validator: (name){
                                  if(name == null || name.isEmpty){
                                    return 'Please enter a name';
                                  }else if(name.length<6){
                                    return 'Please enter a name longer than 6 characters';
                                  }else{
                                    return null;
                                  }
                                },
                              ),
                              data:Theme.of(context).copyWith(primaryColor: AppColors().innerButtonWhite),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:15.0,right: 15.0,top:7,bottom: 0),
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Theme(
                              child: TextFormField(
                                decoration: AppStyles().emailDecoration,
                                validator: (email){
                                  if(email == null || email.isEmpty){
                                    return 'Please enter an email';
                                  }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*@[a-zA-Z0-9]+\.*[a-zA-Z]*").hasMatch(email)){
                                    return "Enter a valid email";
                                  }else{
                                    return null;
                                  }
                                },
                              ),
                              data:Theme.of(context).copyWith(primaryColor: AppColors().innerButtonWhite),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Set account as private    "),
                              CustomSwitch(
                                activeColor: AppColors().mostUsedBlack,
                                value: false,
                                onChanged: (value) {
                                  print("VALUE : $value");
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Deactivate your account "),
                              CustomSwitch(
                                activeColor: AppColors().mostUsedBlack,
                                value: false,
                                onChanged: (value) {
                                  print("VALUE : $value");
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (){showAlertDialog(context);},
                      child:Text("Delete Account",
                          style:TextStyle(
                              fontSize: 12,
                              color: AppColors().innerButtonWhite
                          )
                      ),
                      style: AppStyles().submitButton
                  ),
                  ElevatedButton(
                    child:Text("      Save      ",
                        style:TextStyle(
                            fontSize: 12,
                            color: AppColors().innerButtonWhite
                        )
                    ),
                    style: AppStyles().submitButton,onPressed: (){
                    if(_formKey.currentState.validate()){
                      print("Form is valid.");

                    }else{
                      print(_formKey.currentState.validate());
                    }
                  },
                  ),
                ],
              )
            ],
          ),
        );
      }return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
