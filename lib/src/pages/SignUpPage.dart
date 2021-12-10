import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/PagesPage.dart';
import 'package:vtogethernew/src/pages/loginButton.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class SignUp extends StatelessWidget {
  String mob;
  String verId;
   SignUp({this.mob,this.verId});
  ApiService myApi = new ApiService();
  ProgressDialog pr;

  var otp1 = TextEditingController();
  var otp2 = TextEditingController();
  var otp3 = TextEditingController();
  var otp4 = TextEditingController();
  var otp5 = TextEditingController();
  var otp6 = TextEditingController();

  bool validation(){
    if(otp1.text=="" || otp2.text=="" || otp3.text=="" || otp4.text=="" || otp5.text=="" || otp6.text==""){
      Fluttertoast.showToast(msg: "Please enter valid OTP");
      return false;
    }
    return true;
  }

  /*otpVerify(context) async{
    if(validation()){
      pr.show();
      var server = await myApi.verifyOtp(otp1.text+otp2.text+otp3.text+otp4.text, mob);
      pr.hide();
      if(server["status"]=="true"){
        Fluttertoast.showToast(msg: server["message"]);
        if(server["data"]["token"] == null) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginButton(mob: mob,)));
        }
        else{
          SharedPreferences pref=await SharedPreferences.getInstance();
          pref.setString("apikey", server["data"]["token"]);
          pref.setBool("loggedin", true);
          pref.setString("userKey", server["data"]["user_key"]);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Pages()));
        }
      }
      else{
        Fluttertoast.showToast(msg: server["message"]);
      }
    }
  }*/
  mobVerify(context) async{
    var server= await myApi.verifyWithMob(mob);
    await pr.hide();
    if(server["status"]=="true"){
      Fluttertoast.showToast(msg: server["message"]);
      if(server["data"]["token"] == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginButton(mob: mob,)));
      }
      else{
        SharedPreferences pref=await SharedPreferences.getInstance();
        pref.setString("apikey", server["data"]["token"]);
        pref.setBool("loggedin", true);
        pref.setString("userKey", server["data"]["user_key"]);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Pages()));
      }
    }
    else{
      Fluttertoast.showToast(msg: server["message"]);
    }
  }
  otpVerify(context) async{
    if(validation()){
      FirebaseAuth auth = FirebaseAuth.instance;
      await pr.show();
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: otp1.text+otp2.text+otp3.text+otp4.text+otp5.text+otp6.text,
      );
      var result = await auth.signInWithCredential(credential);
      await mobVerify(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(icon:Icon(Icons.arrow_back,color: myBlack,),
            splashRadius: 25,
            onPressed: ()=> Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 34.0, right: 34.0, top: 25),
                  child: Text("My code is",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: myBlack,
                        fontSize: 18.0,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 34.0, right: 34.0, top: 20),
                  child: Row(
                    children: [
                      Text(mob,
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: myGrey,
                        fontSize: 18.0,
                      ),),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Edit",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: myBlack,
                            fontSize: 18.0,
                          ),),
                      ),
                    ],
                  ),
                ),
                otpContainer(context), //OTP widget
                GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 34.0, right: 34.0,top: 20),
                      child: Text(
                      "Resend",
                      style: TextStyle(
                        color: baseColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                ),)),
              ],
            ),
            conButton(context),
            SizedBox(height: 20,),
            /*login with*/
          ],
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
            otpVerify(context);
        },
        child: Text(
          "Submit",
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
  Widget otpContainer(context){
    return Container(
      margin: EdgeInsets.only(left: 34.0, right: 34.0),
      height: 50.0,
      child: Row(
        children: [
          Container(
            height: 30,
            width: 25,
            child: TextField(
              controller: otp1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              maxLength: 1,
              autofocus: true,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: myBlack),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: myGrey,width: 2),
                ),
                counterText: "",
              ),
              onChanged: (x) {
                if(x.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 30,
            width: 25,
            child: TextField(
              controller: otp2,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              maxLength: 1,
              autofocus: true,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: myBlack),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: myGrey,width: 2),
                ),
                counterText: "",
              ),
              onChanged: (x) {
                if(x.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
                else{
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 30,
            width: 25,
            child: TextField(
              controller: otp3,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              maxLength: 1,
              autofocus: true,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: myBlack),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: myGrey,width: 2),
                ),
                counterText: "",
              ),
              onChanged: (x) {
                if(x.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
                else{
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 30,
            width: 25,
            child: TextField(
              controller: otp4,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              maxLength: 1,
              autofocus: true,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: myBlack),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: myGrey,width: 2),
                ),
                counterText: "",
              ),
              onChanged: (x) {
                if(x.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
                else{
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 30,
            width: 25,
            child: TextField(
              controller: otp5,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              maxLength: 1,
              autofocus: true,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: myBlack),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: myGrey,width: 2),
                ),
                counterText: "",
              ),
              onChanged: (x) {
                if(x.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
                else{
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 30,
            width: 25,
            child: TextField(
              controller: otp6,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              maxLength: 1,
              autofocus: true,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: myBlack),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: myGrey,width: 2),
                ),
                counterText: "",
              ),
              onChanged: (x) {
                if(x.length == 1) {
                  FocusScope.of(context).unfocus();
                }
                else{
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

