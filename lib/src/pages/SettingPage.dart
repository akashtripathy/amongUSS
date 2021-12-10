import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/CheckoutPage.dart';
import 'package:vtogethernew/src/pages/LoginScreenPage.dart';

class SettingScreen extends StatelessWidget {
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
        title: Text("Settings",style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 35.0),
        child: Column(
          children: <Widget>[
            _conButton(context, "Payment Details"),
            SizedBox(
              height: 15.0,
            ),
            _conButton(context, "Contact Us"),
            SizedBox(
              height: 15.0,
            ),
            _conButton(context, "FAQ"),
            SizedBox(
              height: 15.0,
            ),
            _conButton(context, "View Rules"),
            SizedBox(
              height: 15.0,
            ),
            _conButton(context, "Logout"),
            SizedBox(
              height: 15.0,
            ),
            _conButton(context, "Delete Account"),
          ],
        ),
      ),
    );
  }
  signOut() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;
    await pr.show();
    await auth.signOut();
    await pr.hide();
    pref.clear();
    runApp(MaterialApp(home: LoginScreen(),));
  }
  action(String btnText,BuildContext context) async {
    if (btnText == "Payment Details") {
      print(btnText);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen()));
    }
    else if (btnText == "Contact Us") {
      print(btnText);
      final Uri params = Uri(
          scheme: 'mailto',
          path: 'amongussarb@gmail.com',
          queryParameters: {
            'subject': 'Default Subject',
            'body': 'Default body'
          }
      );
      String url = params.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    }
    else if (btnText == "FAQ") {
      print(btnText);
    }
    else if (btnText == "View rules") {
      print(btnText);
    } 
    else if (btnText == "Logout") {
     await signOut();
    } 
    else if (btnText == "Remove account") {
      print(btnText);
    }
  }

  Widget _conButton(context, String btnText) {
    return Container(
      height: 52.0,
      width: MediaQuery.of(context).size.width * 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: MaterialButton(
          color: baseColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
          onPressed: () => action(btnText,context),
          child: Text(
            btnText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

}

