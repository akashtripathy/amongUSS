import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/ChatScreenPage.dart';
import 'package:vtogethernew/src/pages/LikedUserDetailsPage.dart';
import 'package:vtogethernew/src/pages/UserChatTilePage.dart';

class ChartList extends StatefulWidget {

  @override
  _ChartListState createState() => _ChartListState();
}

class _ChartListState extends State<ChartList> {
  String userid="";
  ApiService myApi= new ApiService();
  List<dynamic> whoLike=[];
  Future<void> get() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      userid= pref.getString("userKey");
    });
  }
  whoLikeMe() async{
    var service = await myApi.whoLikeMe();
    if(service["status"]==true){
      setState(() {
        whoLike=service["data"];
        whoLike.removeWhere((value) => value == "");
        print(whoLike.length);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    get();
    whoLikeMe();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Messages',
              style: TextStyle(
                color: myBlack,
                fontSize: 22,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 10,top: 5),
                  child: Text("New Likes",style: TextStyle(color: baseColor,fontWeight: FontWeight.bold,fontSize: 17),textAlign: TextAlign.start,)
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 100,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child:whoLike.length>0? ListView.builder(
                      itemCount: whoLike.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return whoLike[i]==""?Container():GestureDetector(
                          onTap: (){
                            //print(whoLike[i]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LikedUserDetails(userData: whoLike[i])));
                          },
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.center,
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: baseColor,
                                          style: BorderStyle.solid,
                                          width: 3)),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: whoLike[i]["profile_pic"]!=null?NetworkImage(whoLike[i]["profile_pic"]):AssetImage("assets/exwork/picture3.png")),
                                    ),
                                  )
                              ),
                              SizedBox(height: 5),
                              Text(whoLike[i]["name"],maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                            ],
                          ),
                        );
                      }):Container(width:MediaQuery.of(context).size.width,alignment: Alignment.center,child: Text("No New Likes"),)
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                  child: Text("Chats",style: TextStyle(color: baseColor,fontWeight: FontWeight.bold,fontSize: 17),textAlign: TextAlign.start,)
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: messages.length,
              //     itemBuilder: (context, i) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 12),
              //         child: Column(
              //           children: [
              //             InkWell(
              //               child: UserChatTile(
              //                 lastSeen: Text("${messages[i].lastTime.toString()} mins"),
              //                 lastMessage: Text(
              //                   messages[i].lastMessage,
              //                   style: TextStyle(color: myBlack, fontSize: 15,),
              //                   maxLines: 1,
              //                   overflow: TextOverflow.ellipsis,
              //                 ),
              //                 userImage: AssetImage(messages[i].profileImg),
              //                 userName: Text(
              //                   messages[i].name,
              //                   style: TextStyle(
              //                       color: Color(0xff7E817E), fontSize: 13),
              //                 ),
              //                 unseenMessgae: messages[i].unseenMessage,
              //               ),
              //               onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => ChatScreen()),
              //                 );
              //               },
              //             ),
              //             Divider(
              //               color: myGrey.shade400,
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Expanded(
                child: userid!=""?StreamBuilder(
                    stream:FirebaseFirestore.instance
                        .collection("chatSession").where("user",arrayContains: userid).snapshots(),
                  builder: (context,snapshop){
                      if(!snapshop.hasData)
                        {
                          return Center(
                            child: Text("No User Available"),
                          );
                        }
                      else{
                        final List<DocumentSnapshot> documents = snapshop.data.docs;
                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, i) {
                            return Chatheadwidget(document: documents[i],userid: userid,);
                          },
                        );
                      }
                  },
                ):Container(),
              )
            ],
          ),
        )
    );
  }
}


class Chatheadwidget extends StatelessWidget {
  var document;
  var userid;
  Chatheadwidget({@required this.document,@required this.userid});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("user").doc(document["user"][0]==userid?document["user"][1]:document["user"][0]).snapshots(),
      builder: (context, snapshop) {
        if(!snapshop.hasData)
          {
            /*return Text("Not Found");*/
            return loadingChat();
          }
        else{
          var data = snapshop.data;
          Timestamp time=document["lastmsgtime"];
          var tm=DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12),
            child: Column(
              children: [
                InkWell(
                  child: UserChatTile(
                    lastSeen: Text(DateFormat('hh:mm a').format(tm),style: TextStyle(fontSize: 13),),
                    lastMessage: Text(
                      document["lastmsg"],
                      style: TextStyle(
                        color: myBlack, fontSize: 15,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    userImage: NetworkImage(
                        data["profile_pic"]),
                    userName: Text(
                      data["name"],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(profilepic:data["profile_pic"] ,name: data["name"],docid: document.id,)),
                    );
                  },
                ),
                Divider(
                  color: myGrey.shade400,
                ),
              ],
            ),
          );
        }

      }
    );
  }
}

loadingChat(){
 return ListTile(
     contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
     leading: Container(
       height: 50,
       width: 50,
       decoration: BoxDecoration(
         color: Colors.grey.shade200,
           shape: BoxShape.circle,
       ),
     ),
     title: Container(height: 14,color: Colors.grey.shade200,),
     subtitle: Container(height: 8,color: Colors.grey.shade200,),
 );
}
