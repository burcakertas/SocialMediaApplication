import 'package:banana/util/Styles.dart';
import 'package:flutter/material.dart';
import 'package:banana/util/Colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final List<String> textFieldsValue = [];
  bool _isToggled = true;
  var _toggleIcon = Icon(Icons.remove_red_eye, color: Colors.grey);

  _togglePassword() {
    setState(() {
      if (_isToggled == false) {
        _toggleIcon = Icon(Icons.remove_red_eye, color: Colors.grey);
        _isToggled = true;
      } else {
        _toggleIcon = Icon(Icons.remove_red_eye, color: Colors.blue);
        _isToggled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: AppColors().mostUsedBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
            child: Container(
              color: AppColors().mostUsedBlack,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        iconTheme: IconThemeData(
          color: AppColors().mostUsedBlack,
        ),
        title: Text("Sign Up",
          style: TextStyle(
            color: AppColors().mostUsedBlack,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors().innerButtonWhite,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                SizedBox(height: 50,),
                Center(
                    child:Image(
                      image:AssetImage(
                          "assets/banana_welcome.png"
                      ),
                      width: 90,
                      height: 90,
                    )
                ),
                SizedBox(height: 25,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
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
                                textFieldsValue.add(name);
                                return null;
                              }
                            },
                          ),
                          data:Theme.of(context).copyWith(primaryColor: AppColors().authenticationInput),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0,right: 15.0,top:7,bottom: 0),
                        child: Theme(
                          child: TextFormField(
                            decoration: AppStyles().usernameDecoration,
                            validator: (name){
                              if(name == null || name.isEmpty){
                                return 'Please enter a username';
                              }else if(name.length<6){
                                return 'Please enter a username longer than 6 characters';
                              }else{
                                textFieldsValue.add(name);
                                return null;
                              }
                            },
                          ),
                          data:Theme.of(context).copyWith(primaryColor: AppColors().authenticationInput),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:15.0,right: 15.0,top:7,bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Theme(
                          child: TextFormField(
                            decoration: AppStyles().emailDecoration,
                            validator: (contact){
                              if(contact == null || contact.isEmpty){
                                return 'Please enter an email';
                              }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(contact)){
                                return "Enter a valid email";
                              }else{
                                textFieldsValue.add(contact);
                                return null;
                              }
                            },
                          ),
                          data:Theme.of(context).copyWith(primaryColor: AppColors().authenticationInput),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:15.0,right: 15.0,top:7,bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Theme(
                          child: TextFormField(
                            onChanged: (input){
                            },
                            obscureText: _isToggled,
                            decoration: InputDecoration(
                              //prefixIcon: Icon(Icons.contact_phone_rounded ),
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
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                suffix: InkWell(
                                  onTap: (){
                                    _togglePassword();
                                  },
                                  child: _toggleIcon,
                                ),
                                hintStyle: TextStyle(
                                    color:AppColors().authenticationInput
                                )
                            ),
                            validator: (contact){
                              if(contact == null || contact.isEmpty){
                                return 'Please enter a password';
                              }else if (!RegExp(r"^[a-zA-Z0-9]{4,}").hasMatch(contact)){
                                return "Weak";
                              }else if (!RegExp(r"^[a-zA-Z0-9]{8,}").hasMatch(contact)){
                                return "Middle";
                              }else{
                                textFieldsValue.add(contact);
                                return null;
                              }
                            },
                          ),
                          data:Theme.of(context).copyWith(primaryColor: AppColors().authenticationInput),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
              SizedBox(height: 25,),
                ElevatedButton(
                  child:Text("Sign Up",
                      style:TextStyle(
                          fontSize: 12,
                          color: AppColors().innerButtonWhite
                      )
                  )
                  ,onPressed: (){
                    if(_formKey.currentState.validate()){
                      print("Form is valid.");
                      print(textFieldsValue);
                      final response=http.post(
                        Uri.http('localhost:3000', '/users'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'name': textFieldsValue[0],
                          'email':textFieldsValue[2],
                          'username':textFieldsValue[1],
                          'password':textFieldsValue[3]
                        }),
                      );
                      response.then((value) => (){
                        if(value.statusCode!=200){
                          print("Error");
                          textFieldsValue.removeRange(0, textFieldsValue.length);
                        }
                      });
                    }else{
                      print(_formKey.currentState.validate());
                    }
                },
                  style: AppStyles().submitButton
                ),
          ],
        ),
      ),
    );
  }
}
