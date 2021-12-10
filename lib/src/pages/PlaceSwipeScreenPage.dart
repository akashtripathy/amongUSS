import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'dart:ui';
import 'package:vtogethernew/src/pages/PlaceScreen.dart';

class PlacesSwipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Places and Events',
            style: TextStyle(
              color: myBlack,
              fontSize: 22,
            ),
          ),
          leading: IconButton(
              splashRadius: 25,
              icon: Icon(Icons.arrow_back,color: myBlack,),
              onPressed: ()=> Navigator.pop(context)
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
              children: [
            Container(
              margin: EdgeInsets.all(20),
              height: size.height-120,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/exwork/place.png"),
                    fit: BoxFit.fitHeight
                  )),
              child: BackdropFilter(
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: size.width,
                  height: size.height*65/100,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: myGrey.shade300, blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                          width: 1),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, left: 20, right: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Restaurants and events swipe ',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Image.asset(
                              "assets/exwork/circularImage.png"),
                          Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                        'Lorem ipsum dolor sit amet, consectetur\n',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff97A1A7))),
                                    TextSpan(
                                        text:
                                        '        adipiscing elit, sed do eiusmod.',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff97A1A7))),
                                  ]))),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: size.width,
                            color: baseColor,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PlaceScreen()),
                              );
                            },
                            child: Text(
                              'Continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18,color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(25)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Dont show this again',
                            style: TextStyle(color: Color(0xff97A1A7)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            ]
          ),
        )
    );
  }
}
