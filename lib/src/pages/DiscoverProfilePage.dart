import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/FilterScreenPage.dart';

class DiscoverProfile extends StatefulWidget {
  @override
  _DiscoverProfileState createState() => _DiscoverProfileState();
}

class _DiscoverProfileState extends State<DiscoverProfile> {
  ApiService myApi = new ApiService();
  int UserCount=0;
  List<dynamic> users=[];
  ProgressDialog pr;
  String likeDislike;
  bool swipe=false;
  CardController controller= CardController();
  int arrcout=0;
  List<String> filters=[];
  var hobbies;
  var habits;

  userData() async {
    await pr.show();
    var service=await myApi.userDetails();
    if(service["status"]==true){
      await pr.hide();
      setState(() {
        users= service["data"];
        arrcout=users.length;
      });
    }else{
      await pr.hide();
      Fluttertoast.showToast(msg: "Something wet wrong");
    }
  }
   userDataFilter(vegan, veg, open, male, female, other, love, friendship, network, ageRanMin, ageRanMax, distance) async{
    await pr.show();
    var service= await myApi.filterUserDetails(vegan, veg, open, male, female, other, love, friendship, network, ageRanMin, ageRanMax, distance);
    if(service["status"]==true){
      await pr.hide();
      setState(() {
        users= service["data"];
        arrcout=users.length;
        if(users.length==0){
          Fluttertoast.showToast(msg:service["msg"]);
        }
      });
    }else{
      await pr.hide();
      Fluttertoast.showToast(msg: "Something wet wrong");
    }
  }
  rightSwipeLike(prefId) async{
    await pr.show();
    var service=await myApi.addLike(prefId);
    await pr.hide();
    if(service["status"]==true){
      Fluttertoast.showToast(msg: service["msg"]);
    }
  }
  leftSwipeNope(prefId) async{
    await pr.show();
    var service=await myApi.addNope(prefId);
    await pr.hide();
    if(service["status"]==true){
      Fluttertoast.showToast(msg: service["msg"]);
    }
  }
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userData();
    });
  }
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    final size = MediaQuery.of(context).size;
    if(users.length>0) {
      hobbies = users[0]["hobbies"].split(",");
      habits = users[0]["habits"].split(",");
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Discover",
          style: TextStyle(color: myBlack),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Image.asset("assets/icon/settings.png"),
            onPressed: () async{
             filters= await Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
             print(filters);
             if(filters!=null){
               userDataFilter(filters[0], filters[1], filters[2], filters[3], filters[4], filters[5], filters[6], filters[7], filters[8], filters[9], filters[10], filters[11]);
             }
            },
          ),
        ],
      ),
      body: Container(
        //margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
        child: UserCount < arrcout?Stack(
          children: <Widget>[
            cards(), //for user images in stack
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: size.width-80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(131, 131, 131, 1),
                        spreadRadius: 2,
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            swipe=!swipe;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(users[0]["name"],style: TextStyle(color: myBlack2,fontSize:20 ),maxLines: 2,overflow: TextOverflow.ellipsis,)
                                  ),
                                  Image.asset("assets/icon/leaf.png",height: 25,),
                                  Icon(Icons.sports_baseball_rounded,size: 25,),
                                  Icon(Icons.headset_mic_rounded,size: 25,),
                                  Icon(Icons.laptop_chromebook,size: 25,),
                                ],
                              ),
                              SizedBox(height: 3,),
                              Row(
                                children: [
                                  Icon(Icons.location_on,size: 15,color: myBlack3,),
                                  Text(users[0]["addr"],style: TextStyle(fontSize: 14,color: myBlack3),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      swipe?
                        Container(
                          child: Column(
                            children: [
                              Divider(color: myGrey.shade400,),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 10,
                                  runSpacing: 5,
                                  children: [
                                    users[0]["type"]==""?Container():Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset("assets/exwork/vegan.png",
                                              height: 25, width: 25),
                                          SizedBox(width: 5),
                                          Text(users[0]["type"])
                                        ],
                                      ),
                                    ),
                                    if(hobbies!="")
                                      for(var item in hobbies)
                                        hobbie(item)
                                  ],
                                ),
                              ),
                              Divider(
                                color: myGrey.shade400,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  users[0]["u_desc"],
                                  style: TextStyle(color: myBlack, fontSize: 14.0),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: size.width-100,
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 10,
                                  runSpacing: 5,
                                  children: <Widget>[
                                    if(habits!="")
                                      for(var item in habits)
                                        habit(item)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                          : Container(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      likeDislike="nope";
                                      leftSwipeNope(users[0]["id"]);
                                      var l= users.removeAt(0);
                                      UserCount++;
                                      print("nope $l");
                                    });
                                  },
                                  child: btmBox("dislike.png", baseColor.withOpacity(0.2))),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      likeDislike="like";
                                      rightSwipeLike(users[0]["id"]);
                                      var l= users.removeAt(0);
                                      UserCount++;
                                      print("like $l");
                                    });
                                  },
                                  child: btmBox("like.png", baseColor)
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ):Center(child: Text("No more user",style: TextStyle(fontSize: 16),)),
      ),
    );
  }
  Widget cards(){
    return  Container(
        child:TinderSwapCard(
          swipeUp: true,
          swipeDown: false,
          orientation: AmassOrientation.BOTTOM,
          totalNum: users.length,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.height * 0.7,
          cardBuilder: (context, index) =>Card(
            child: Image(image: users[index]["profile_pic"]!=null? NetworkImage('${users[index]["profile_pic"]}'):AssetImage("assets/exwork/Akash-Jagga.jpg"),fit: BoxFit.cover,),
          ),
          cardController: controller ,
          swipeUpdateCallback:
              (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            /*if (details.delta.dy < 0) {
                        print("dislike");
                      } else if (align.x > 0) {
                        print("like");
                      }*/
          },
          swipeCompleteCallback:
              (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card
            setState(() {
              if(orientation==CardSwipeOrientation.LEFT){
                leftSwipeNope(users[0]["id"]);
                var l=users.removeAt(0);
                UserCount++;
                print("Nope $l");
              }else if(orientation==CardSwipeOrientation.RIGHT){
                rightSwipeLike(users[0]["id"]);
                var l=users.removeAt(0);
                UserCount++;
                print("Like $l");
              }
              else if(orientation==CardSwipeOrientation.UP){
                var l=users.removeAt(0);
                UserCount++;
                print("Super like $l");
              }
            });
          },
        ),
    );
  }
  habit(item){
    return users[0]["habits"]==""?Container(): Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: myGrey.shade300,
          borderRadius: BorderRadius.circular(5)),
      child: Text(item,style: TextStyle(fontSize: 14),),
    );
  }
  hobbie(item){
    return users[0]["hobbies"]==""?Container():Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wb_incandescent_sharp,color: myGrey2,size: 25,),
          SizedBox(width: 5),
          Text(item,style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
Widget btmBox(var img,var col){
  return Container(
    decoration:BoxDecoration(
      color: col,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Image.asset("assets/exwork/"+img,height: 40,color: col==baseColor?Color(0xFFE7F1DB):baseColor),
  );
}
