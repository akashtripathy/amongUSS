import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/CheckoutPage.dart';

class Credit_Screen extends StatefulWidget {
  @override
  _Credit_ScreenState createState() => _Credit_ScreenState();
}

class _Credit_ScreenState extends State<Credit_Screen> {
  final cardNumController = TextEditingController();
  final ownerNameController = TextEditingController();
  final monthController = TextEditingController();
  final cvvController = TextEditingController();
  final emailController = TextEditingController();
  FocusNode cvvFocusNode = FocusNode();

  @override
  void dispose() {
    cardNumController.dispose();
    ownerNameController.dispose();
    monthController.dispose();
    cvvController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isFocusedToCvvOneTime = false;

  @override
  void initState() {
    super.initState();
    monthController.addListener(monthAndYearListener);
  }

  monthAndYearListener() {
    if (monthController.text.length == 2) {
      monthController.text = "${monthController.text}/";
      monthController.selection = TextSelection.fromPosition(
          TextPosition(offset: monthController.text.length));
      isFocusedToCvvOneTime = false;
    } else if (monthController.text.length == 5 && !isFocusedToCvvOneTime) {
      cvvFocusNode.requestFocus();
      isFocusedToCvvOneTime = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: myBlack,
              ),
            ),
            Text(
              'Credit Card details',
              style: TextStyle(
                  color: myBlack,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: TextField(
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal),
                controller: cardNumController,
                onTap: () {},
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCCCCCC))),
                    contentPadding: EdgeInsets.only(right: 20),
                    labelText: "Card Number",
                    labelStyle: TextStyle(
                        color: Color(0xff808080),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: TextField(
                controller: ownerNameController,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    color: Color(0xff000000)),
                onTap: () {},
                decoration: InputDecoration(
                    labelText: "Card Owner Name",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCCCCCC))),
                    contentPadding: EdgeInsets.only(right: 20),
                    labelStyle: TextStyle(
                        color: Color(0xff808080),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontSize: 11,
                          color: Color(0xff808080)),
                      controller: monthController,
                      decoration: InputDecoration(
                        labelText: "MM/YY",
                        labelStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            color: Color(0xff808080)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: TextField(
                        focusNode: cvvFocusNode,
                        controller: cvvController,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                          labelText: "CVV",
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.normal,
                              color: Color(0xff808080)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    color: Color(0xff000000)),
                onTap: () {},
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCCCCCC))),
                    contentPadding: EdgeInsets.only(right: 20),
                    labelText: "Email address",
                    labelStyle:
                    TextStyle(color: Color(0xff808080), fontSize: 15)),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MaterialButton(
                minWidth: size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '1',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      ' months',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text(
                      '    \$49.99 \nper month',
                      style: TextStyle(color: baseColor),
                    ),
                  ],
                ),
                onPressed: () {},
                color: Color(0xffEFEFF0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MaterialButton(
                height: 50,
                minWidth: size.width,
                color: baseColor,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen()));
                },
                child: Text(
                  'Buy now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
