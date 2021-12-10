import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtogethernew/src/pages/phonePage.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var text  = "By signing up for amongUSS, you agree to our Terms of Service. "
      "Learn how we process your data in our Privacy Policy and Cookies Policy.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .5,
                child: centerLogo(context),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: (25.0)),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text,  textAlign: TextAlign.center, style: TextStyle(),),
                      ),
                      withPhone(context),
                      SizedBox(
                        height: 20,
                      ),
                      withFacebook(context),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget centerLogo(context) {
  return Center(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(shape: BoxShape.circle, boxShadow: [
            ]),
            child:  Container(
              width: 140.0,
              height: 140.0,
              decoration: new BoxDecoration(
                //shape: BoxShape.circle,
                color: Colors.transparent,
                image: new DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: new AssetImage("assets/img/logo.png",),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          new Text(
            "amongUSS",
            textScaleFactor: 1.5,
            style: TextStyle(color: Color.fromRGBO(42, 55, 99, 1.0), fontSize: 18.0,),
          )
        ],
      ));
}

Widget withFacebook(context) {
  return Container(
    height: 52.0,
    width: MediaQuery.of(context).size.width * 1,
    child: MaterialButton(
      color: myBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      onPressed: () {},
      child: Text(
        "Sign In With Facebook",
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
  );
}
Widget withPhone(context) {
  return Container(
      height: 52.0,
      width: MediaQuery.of(context).size.width * 1,
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Phone()));
        },
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                myPink,
                myBlue2,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            constraints:
            const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            // min sizes for Material buttons
            alignment: Alignment.center,
            child: const Text(
              'Sign In with Phone Number',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
  );
}
