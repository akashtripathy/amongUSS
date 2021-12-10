import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/LikedUserDetailsPage.dart';
import 'package:vtogethernew/src/pages/PlaceSwipeScreenPage.dart';

class ChatScreen extends StatefulWidget {
  String profilepic;
  String name;
  String docid;
  ChatScreen({@required this.profilepic,@required this.name,@required this.docid});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _controller = TextEditingController();
  PopupMenuItem popUpSelected;
  String userid="";
  ScrollController _scrollController = new ScrollController();
  ApiService myApi = new ApiService();

  Future<String> get() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      userid= pref.getString("userKey");
    });
  }

  getFCMToken() async{
    String fcmToken=await FirebaseMessaging.instance.getToken();
    myApi.updateFcmKey(fcmToken);
    //print("message:$fcmToken");
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published! ${message.notification.body}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new ${message.notification.body}');
    });
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 60,
          width: size.width,
          margin: EdgeInsets.only(left: 5, top: 20),
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: myBlack3,
                    ),
                    splashRadius: 25,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: ClipOval(
                            child: Image.network(
                              widget.profilepic,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                onSelected: (_value) {
                  setState(() {
                    popUpSelected = _value;
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                itemBuilder: (_) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      child: Text('Report User'), value: 'user'),
                  PopupMenuItem<String>(
                      child: Text('Block User'), value: 'blockUser'),
                ],
              )
            ],
          ),
        ),
        preferredSize: Size.fromHeight(60),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: userid!=""?Chats(widget.docid,userid,size,_scrollController):Container(),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 10,right: 2),
        margin: EdgeInsets.only(bottom: 3),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlacesSwipeScreen()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: baseColor,
                child: Icon(Icons.location_on_outlined,color: Colors.white,),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: CircleAvatar(
                        backgroundColor: baseColor,
                        radius: 20,
                        child: GestureDetector(
                          onTap: () {
                            var mgs=_controller.text.replaceAll( " ", "");
                            var messageText=_controller.text.trim();
                            _controller.clear();
                            if(mgs!=""){
                              CollectionReference message = FirebaseFirestore.instance.collection('chatSession');
                              DocumentReference docRef = message.doc(widget.docid);
                              return docRef.collection("messages").add({
                                "message": messageText,
                                "sentby":userid,
                                "senttime":DateTime.now()
                              }).then((value){
                                docRef.update({
                                  "lastmsg":_controller.text.trim(),
                                  "lastmsgtime":DateTime.now()
                                });
                                //_controller.clear();
                                _scrollController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    hintText: 'Message',
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    hintStyle: TextStyle(fontSize: 15),
                    labelStyle: (TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4)),
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4)),
                        borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  String docid;
  String userid;
  ScrollController _scrollController;
  var size;
  Chats(this.docid,this.userid,this.size,this._scrollController);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chatSession").doc(docid).collection("messages").orderBy("senttime",descending: true).snapshots(),
        builder: (context, snapshop) {
          if(!snapshop.hasData)
            {
              return Center(
                child: Text("No Data Found"),
              );
            }
          else{
            final List<DocumentSnapshot> documents = snapshop.data.docs;
              return ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: documents.length,
                reverse: true,
                itemBuilder: (context, i) {
                  Timestamp time=documents[i]["senttime"];
                  var tm=DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
                  if(documents[i]["sentby"] == userid)
                    {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 20,bottom:20),
                            constraints: BoxConstraints(
                              maxWidth: size.width*0.8,
                              minWidth: 20
                            ),
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 4,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      documents[i]["message"],
                                      style: TextStyle(color: Colors.white,fontSize: 14),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(DateFormat('hh:mm a').format(tm),style: TextStyle(color: Colors.grey,fontSize: 11),maxLines: 1,)
                                  ],
                                )),
                          ),
                        ],
                      );
                    }
                  else{
                    return  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20,left: 10,bottom: 20),
                          constraints: BoxConstraints(
                            maxWidth: size.width*0.8,
                            minWidth: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 4,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(documents[i]["message"],),
                                  SizedBox(height: 5,),
                                  Text(DateFormat('hh:mm a').format(tm),style: TextStyle(color: Colors.grey,fontSize: 11),maxLines: 1),
                                ],
                              )),
                        ),
                      ],
                    );
                  }
                },
              );
          }
        }
    );
  }
}
