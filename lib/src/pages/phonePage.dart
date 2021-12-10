import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/SignUpPage.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  var mob = TextEditingController();
  ApiService myapi=new ApiService();
  ProgressDialog pr;

  bool validate() {
    if(mob.text.length < 10 ){
      Fluttertoast.showToast(msg: "Enter 10 digit number");
      return false;
    }
    return true;
  }

  /*sendotp() async{
    if(validate()) {
        await pr.show();
        var server=await myapi.sendOtp(mob.text);
        if(server["status"] == true) {
            await pr.hide();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(mob: mob.text)));
            Fluttertoast.showToast(msg: 'otp: ${server["otp"]}',);
          }
        else{
          await pr.hide();
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      }
  }*/

  sendotp() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    if(validate()) {
      pr.show();
      await auth.verifyPhoneNumber(
        phoneNumber: '+91'+mob.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          else{
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        },
        codeSent: (String verificationId, int resendToken) {
          pr.hide();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp(mob: mob.text,verId: verificationId)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: myBlack,),
          splashRadius: 25,
          onPressed: ()=> Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 35),
            child: Text("What is your phone number?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: myBlack,
                  fontSize: 18.0,
                )),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 24.0, right: 20.0, top: 5),
            child: Text(
              'Verify your phone by entering the code received via SMS.......',
              style: TextStyle(color: myBlack, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24.0, right: 20.0,top: 20.0),
            height: 50.0,
            child: TextField(
              controller: mob,
              maxLength: 10,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F0F02),
                fontSize: 16.0,
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: "",
                labelText: "Phone Number",
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelStyle:
                TextStyle(fontSize: 16, color: Colors.black54),
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
          sendotp();
        },
        child: Text(
          "Send code",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }

}

