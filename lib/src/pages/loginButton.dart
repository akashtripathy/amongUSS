import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/MobileVerification.dart';

class LoginButton extends StatefulWidget {
  String mob;
  LoginButton({this.mob});
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  var date = DateTime.now();
  String isSelected = "Male";
  ApiService myApi = new ApiService();
  ProgressDialog pr;
  var userKey;
  var userName = TextEditingController();
  var userEmail=TextEditingController();

  bool validation() {
    if(userName.text == ""){
      Fluttertoast.showToast(msg: "Please enter name");
      return  false;
    }
    if(DateFormat.yMd().format(date) == DateFormat.yMd().format(DateTime.now())){
      Fluttertoast.showToast(msg: "Please enter valid DOB");
      return false;
    }
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(userEmail.text)) {
      Fluttertoast.showToast(msg: 'Please enter valid email');
      return false;
    }
    return true;
  }
  
  userInfo() async{
    FocusScope.of(context).unfocus();
    if(validation()){
      await pr.show();
      await addUser();
      var server= await myApi.userWithMob(userName.text, userEmail.text, isSelected, widget.mob, date,userKey);
      if(server["status"]==true) {
        await pr.hide();
        SharedPreferences pref=await SharedPreferences.getInstance();
        pref.setString("apikey", server["apikey"]);
        pref.setBool("loggedin", true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MobileVerification()));
        Fluttertoast.showToast(msg: server['msg']);
      }
      else{
        await pr.hide();
        Fluttertoast.showToast(msg: server['msg']);
      }
    }
  }

  Future<void> addUser(){
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    DocumentReference docRef = users.doc();
    return users.add({
      "name":userName.text.toString(),
      "profile_pic":"https://pbs.twimg.com/profile_images/974736784906248192/gPZwCbdS.jpg",
      "userid": docRef.id,
    }).then((value) async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("userKey", value.id);
      userKey=value.id;
    }).catchError((error)=>print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.hide();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: myBlack3,),
        splashRadius: 25,
        onPressed: (){
          Navigator.pop(context);
        },
        ),
        title: Text('amongUSS',style: TextStyle(fontSize: 20,color: myBlack3),),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 40),
                  child: Text("What gender are you?",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: myBlack,
                        fontSize: 18.0,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                  height: 50,
                  decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(26.0))),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = "Male";
                          });
                        },
                        child: Container(
                          height: 60,
                          width: size.width/3-13.34,
                          decoration: BoxDecoration(
                            color: isSelected == "Male" ? baseColor : Colors.white,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft: Radius.circular(30)),
                            border: Border.all(color: myGrey)
                          ),
                          child: Center(child: Text('Male',style: TextStyle(fontSize: 18, color: isSelected == "Male" ? Colors.white : Colors.black),textAlign: TextAlign.center,)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = "Female";
                          });
                        },
                        child: Container(
                          height: 60,
                          width: size.width/3-13.34,
                          decoration: BoxDecoration(
                              color: isSelected == "Female" ? baseColor : Colors.white,
                              border: Border.all(color: myGrey)
                          ),
                          child: Center(child: Text('Female',style: TextStyle(fontSize: 18, color: isSelected == "Female" ? Colors.white : Colors.black),textAlign: TextAlign.center,)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = "Other";
                          });
                        },
                        child: Container(
                          height: 60,
                          width: size.width/3-13.34,
                          decoration: BoxDecoration(
                              color: isSelected == "Other" ? baseColor : Colors.white,
                              borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomRight: Radius.circular(30)),
                              border: Border.all(color: myGrey)
                          ),
                          child: Center(child: Text('Other',style: TextStyle(fontSize: 18, color: isSelected == "Other" ? Colors.white : Colors.black),textAlign: TextAlign.center,)),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 15),
                  child: Text("What is your name?",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: myBlack,
                        fontSize: 18.0,
                      )),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 24.0, right: 20.0),
                  height: 50.0,
                  child: new TextField(
                    controller: userName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: myBlack2,
                      fontSize: 16.0,
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: myGrey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: myGrey),
                      ),
                      labelStyle:
                      TextStyle(fontSize: 16, color: myBlack3),
                      contentPadding: const EdgeInsets.only(top: 10.0),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 20),
                  child: Text("What is your date of birth?",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: myBlack,
                        fontSize: 18.0,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24.0, right: 20.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: myGrey))
                  ),
                  child: new InkWell(
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return _buildBottomPicker(
                            CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime newDateTime) {
                                setState(() => date = newDateTime);
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10.0,),
                              DateFormat.yMd().format(date) !=
                                  DateFormat.yMd().format(DateTime.now())
                                  ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  DateFormat.yMd().format(date) !=
                                      DateFormat.yMd().format(DateTime.now())
                                      ? DateFormat.yMMMMd().format(date)
                                      : 'DOB',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: DateTime.now().difference(date).inDays >=
                                        6570
                                        ? myBlack2
                                        : myBlack2,
                                  ),
                                ),
                              )
                                  :  Text(
                                'DOB',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: myBlack3,
                                  fontSize: 16.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Container(
                                  height: 1.2,
                                  color: myBlack2,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 25),
                  child: Text("What is your email?",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: myBlack,
                        fontSize: 18.0,
                      )),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 24.0, right: 20.0),
                  height: 50.0,
                  child: new TextField(
                    controller: userEmail,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: myBlack2,
                      fontSize: 16.0,
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: myGrey)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: myGrey),
                      ),
                      labelStyle:
                      TextStyle(fontSize: 16, color: myBlack3),
                      contentPadding: const EdgeInsets.only(top: 10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                conButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget conButton(context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      height: 50,
      width: MediaQuery.of(context).size.width * 1,
      child: MaterialButton(
        color: baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        onPressed: () {
          userInfo();
        },
        child: Text(
          "Continue",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}


Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: 216.0,
    padding: const EdgeInsets.only(top: 6.0),
    color: Colors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: myBlack,
        fontSize: 22.0,
      ),
      child: SafeArea(
        top: false,
        child: picker,
      ),
    ),
  );
}



