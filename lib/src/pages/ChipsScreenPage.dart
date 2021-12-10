import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/PagesPage.dart';

class ChipsScreen extends StatefulWidget {
  @override
  _ChipsScreenState createState() => _ChipsScreenState();
}

class _ChipsScreenState extends State<ChipsScreen> {
  List<bool> isSelected = [false,false,false,false,false,false];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        leading: IconButton(
          splashRadius: 25,
          icon: const Icon(
            Icons.arrow_back,
            color: myBlack3,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: 26.0,
                      top: 10,
                      bottom: 15.0),
                  child: Text("Lorem ipsum dolor sit?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: myBlack,
                        fontSize: 18.0,
                      )),
                ),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width -55,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSelected[0] = !isSelected[0];
                              });
                            },
                            child: Container(
                              width: size.width/2 -33,
                              child: cusChips(isSelected[0] ? baseColor : Color(0xFFD6D6D6), "Vegan"),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSelected[1] = !isSelected[1];
                              });
                            },
                            child: Container(
                              width: size.width/2-33,
                              child: cusChips(isSelected[1] ? baseColor : Color(0xFFD6D6D6), "Vegetarian"),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSelected[2] = !isSelected[2];
                              });
                            },
                            child: Container(
                              width: size.width/2-33,
                              child: cusChips(isSelected[2] ? baseColor : Color(0xFFD6D6D6),"Meet"),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSelected[3] = !isSelected[3];
                              });
                            },
                            child: Container(
                              width: size.width/2-33,
                              child: cusChips(isSelected[3] ? baseColor : Color(0xFFD6D6D6),"PlaceHolder"),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSelected[4] = !isSelected[4];
                              });
                            },
                            child: Container(
                              width: size.width/2-33,
                              child: cusChips(isSelected[4] ? baseColor : Color(0xFFD6D6D6),"Placeholder"),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSelected[5] = !isSelected[5];
                              });
                            },
                            child: Container(
                              width: size.width/2-33,
                              child: cusChips(isSelected[5] ? baseColor : Color(0xFFD6D6D6),"Placeholder"),
                            ),
                          ),

                        ],
                      ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  conButton(context),
                  SizedBox(height: 12,),
                  skipButton(context),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      "Privacy.Terms Of Use",
                      style: TextStyle(color: myGrey),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget cusChips(Color color, String text) {
  return Container(
    height: 45.0,
    child: Center(child: Text(text,style: TextStyle(color: color==baseColor?Colors.white:myBlack2),)),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: Color(0xFFD6D6D6)),
      borderRadius: BorderRadius.circular(6),
    ),
  );
}

Widget conButton(context) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width -55,
    child: MaterialButton(
      color: baseColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Pages()));
      },
      child: Text(
        "Contiune",
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 14.0,
        ),
      ),
    ),
  );
}
Widget skipButton(context) {
  return InkWell(
    onTap: () {
    },
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width -55,
      child: new MaterialButton(
        child: new Text(
          "Skip onboarding",
          style: TextStyle(color: myBlack),
        ),
        onPressed: null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27.0),
            side: BorderSide(
              color: const Color(0xFFD1D1D1),
            )),
      ),
    ),
  );
}

