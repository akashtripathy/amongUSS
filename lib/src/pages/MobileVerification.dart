import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/WalkThroughPage.dart';

class MobileVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color:Colors.white,
        height: size.height*0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              width: 130.0,
              height: 130.0,
              child: Image.asset(
                'assets/img/logo.png',
                height: 180.0,
                width: 180.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0),
              child: Text(
                'Welcome to amongUSS',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new InkWell(
              onTap: () {},
              child: new Container(
                padding: EdgeInsets.only(
                    left: 32.0, right: 32.0, top: 15),
                child: Text(
                  'Sign up for Premium account for xxxyyy link.'
                      'Remember, please post as many photos as you like. Positive vibes only. '
                      '(No violence, discrimination, or profanity allowed.) '
                      'Enjoy meeting forward-minded and caring people like yourself.'
                  ,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            conButton(context),
            SizedBox(
              height: 20.0,
            )
            /*login with*/
          ],
        ),
      ),
    );
  }
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> WalkThrough()));
      },
      child: Text(
        "Continue",
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
