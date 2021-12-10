import 'package:flutter/material.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class PlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            icon: Icon(Icons.arrow_back,color: myBlack,),
            splashRadius: 25,
            onPressed: ()=> Navigator.pop(context)
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            margin: EdgeInsets.all(20),
            width: size.width,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/exwork/place.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: (size.height / 3.6) - 40,
            left: 0,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 20,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                        width: 1),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 25, left: 20),
                            child: Text(
                              'Charlotte',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          // SizedBox(
                          //   width: 180,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset("assets/exwork/vegan.png",height: 30,),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              '4.5',
                              style: TextStyle(
                                  color: myOrange, fontSize: 15),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.star,color: myOrange,size: 20,),
                            Icon(Icons.star,color: myOrange,size: 20),
                            Icon(Icons.star,color: myOrange,size: 20),
                            Icon(Icons.star,color: myOrange,size: 20),
                            Icon(Icons.star_half,color: myOrange,size: 20),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '256 reviews',
                              style: TextStyle(color: Color(0xff2F80ED)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '\$\$ • Italian restaurant\n',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff97A1A7))),
                                TextSpan(
                                    text: '639 S Spring St, Los Angeles\n',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff97A1A7))),
                                TextSpan(
                                    text: 'CA 90014, USA\n',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff97A1A7))),
                                TextSpan(
                                    text: 'Now open',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff2F80ED),
                                    )),
                                TextSpan(
                                    text: ' - 12:00 to 22:00 (today)',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff97A1A7))),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Colors.grey.shade400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 15, right: 15, bottom: 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                  'Lorem ipsum dolor sit amet, consectetur\n',
                                  style: TextStyle(
                                      color: myBlack, fontSize: 13)),
                              TextSpan(
                                  text:
                                  'adipiscing elit, sed do eiusmod tempor incididunt\n',
                                  style: TextStyle(
                                      color: myBlack, fontSize: 13)),
                              TextSpan(
                                  text:
                                  'ut labore et dolore magna aliqua. Ut enim ad minim',
                                  style: TextStyle(
                                      color: myBlack, fontSize: 13)),
                              TextSpan(
                                  text:
                                  ' veniam, quis nostrud exercitation ullamco laboris',
                                  style: TextStyle(
                                      color: myBlack, fontSize: 13)),
                              TextSpan(
                                  text:
                                  ' nisi ut aliquip ex ea commodo consequat.',
                                  style: TextStyle(
                                      color: myBlack, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: myGrey.shade400,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Stack(children: [
                                Image.asset("assets/exwork/location.png")
                              ]),
                              SizedBox(height: 10),
                              Text(
                                "Directions",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Stack(children: [
                                Image.asset("assets/exwork/visit.png")
                              ]),
                              SizedBox(height: 10),
                              Text(
                                "Visit site",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Stack(children: [
                                Image.asset("assets/exwork/phone.png")
                              ]),
                              SizedBox(height: 10),
                              Text(
                                "Phone call",
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 20, right: 20, bottom: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       MaterialButton(
                      //         child:
                      //         Image.asset("assets/exwork/dislike.png"),
                      //         minWidth: size.width / 3,
                      //         onPressed: () {},
                      //         color: Colors.grey.shade300,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8)),
                      //       ),
                      //       SizedBox(
                      //         width: 15,
                      //       ),
                      //       MaterialButton(
                      //         child: Image.asset("assets/exwork/like.png"),
                      //         onPressed: () {},
                      //         minWidth: size.width / 3,
                      //         color: Color(0xff5E9D0E),
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(8)),
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
