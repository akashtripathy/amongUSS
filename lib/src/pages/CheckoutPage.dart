import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/PagesPage.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text("Checkout",style: TextStyle(color: myBlack),),
        leading: IconButton(icon:Icon(Icons.arrow_back,color: myBlack,), 
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Pages()));
            }
        ),
      ),
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: Container(
          color: Color(0xFFE5E5E5),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              new Container(
                width: 120.0,
                height: 120.0,
                child: Image.asset(
                  'assets/img/logo.png',
                  height: 180.0,
                  width: 180.0,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                child: Text(
                  'Thank you for your purchase!',
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
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, top: 15),
                  child: Text(
                    'Enjoy your premium account.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7C7C7C),
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              conButton(context),
              SizedBox(
                height: 30.0,
              )

              /*login with*/
            ],
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pages()));
        },
        child: Text(
          "Discover with amongUSS Premium",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
} // end of class
