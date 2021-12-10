import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/ChatListPage.dart';
class LikedUserDetails extends StatefulWidget {
  var userData;
  LikedUserDetails({this.userData});
  @override
  _LikedUserDetailsState createState() => _LikedUserDetailsState(userData);
}

class _LikedUserDetailsState extends State<LikedUserDetails> {
  var userData;
  _LikedUserDetailsState(this.userData);
  ApiService myApi=new ApiService();
  ProgressDialog pr;
  var hobbies;
  var habits;
  var otherPics;

  likeAdd(prefId) async{
    await pr.show();
    var service=await myApi.addLike(prefId);
    await pr.hide();
    if(service["status"]==true){
      Fluttertoast.showToast(msg: service["msg"]);
      Navigator.pop(context);
    }
  }
  nopeAdd(prefId) async{
    await pr.show();
    var service=await myApi.addNope(prefId);
    await pr.hide();
    if(service["status"]==true){
      Fluttertoast.showToast(msg: service["msg"]);
      Navigator.pop(context);
    }
  }
  Future<void> chatSession() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    CollectionReference chat=FirebaseFirestore.instance.collection("chatSession");
    return chat.add({
      "lastmsg":"hello....how are you?",
      "lastmsgtime":DateTime.now(),
      "user":[userData["user_key"],pref.getString("userKey")],
    }).then((value){
      chat.doc(value.id).collection("messages").add({
        "message": "hello....how are you?",
        "sentby": pref.getString("userKey"),
        "senttime": DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    pr=ProgressDialog(context,type: ProgressDialogType.Download,isDismissible: false,showLogs: false);
    final size= MediaQuery.of(context).size;
    hobbies = userData["hobbies"].split(",");
    habits = userData["habits"].split(",");
    otherPics= userData["other_pic"]==null?"":userData["other_pic"].split(",");
    if(otherPics!=""){
      otherPics.removeWhere((value) => value == "");
    }
    getAge(dateString)
    {
      var today = DateTime.now();
      var birthDate =DateTime.parse(dateString);
      var age = today.year - birthDate.year;
      var m = today.month - birthDate.month;
      if (m < 0 || (m == 0 && today.day < birthDate.day)) {
      age--;
      }
      return age;
    }
    return Scaffold(
      body:userData!=null? SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height*0.5,
                    child: otherPics.length>0?Swiper(
                      autoplay: false,
                      itemCount: otherPics.length,
                      scrollDirection: Axis.horizontal,
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new DotSwiperPaginationBuilder(
                              color: baseColor.withOpacity(0.2), activeColor: baseColor)
                      ),
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: otherPics[index]!=""?NetworkImage(otherPics[index]):AssetImage("assets/exwork/blank_image.png"),
                                  fit: BoxFit.cover
                              )
                          ),
                        );
                      },
                    ):Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: userData["profile_pic"]!=null?NetworkImage(userData["profile_pic"]):AssetImage("assets/exwork/blank_image.png"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text("${userData["name"]}, ${getAge(userData["dob"])}",
                                  style: TextStyle(color: myBlack2,fontSize:20 ),maxLines: 2,overflow: TextOverflow.ellipsis,)
                            ),
                            Image.asset("assets/icon/leaf.png",height: 25,),
                            Icon(Icons.sports_baseball_rounded,size: 25,),
                            Icon(Icons.headset_mic_rounded,size: 25,),
                            Icon(Icons.laptop_chromebook,size: 25,),
                          ],
                        ),
                        SizedBox(height: 5),
                        userData["addr"]!=null?Row(
                          children: [
                            Icon(Icons.location_on,size: 15,color: myBlack3,),
                            Text(userData["addr"],style: TextStyle(fontSize: 14,color: myBlack3),),
                          ],
                        ):Container(),
                        SizedBox(height: 2),
                        userData["job"]!=null?Row(
                          children: [
                            Icon(Icons.work,size: 15,color: myBlack3,),
                            Text(userData["job"],style: TextStyle(fontSize: 14,color: myBlack3),),
                          ],
                        ):Container(),
                        Divider(height: 30,),
                        Container(
                          width: size.width,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 10,
                            runSpacing: 5,
                            children: [
                              userData["type"]==""?Container():Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset("assets/exwork/vegan.png",
                                        height: 25, width: 25),
                                    SizedBox(width: 5),
                                    Text(userData["type"])
                                  ],
                                ),
                              ),
                              if(hobbies!="")
                                for(var item in hobbies)
                                  hobbie(item)
                            ],
                          ),
                        ),
                        Divider(height: 30,),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 10,
                          runSpacing: 5,
                          children: <Widget>[
                            if(habits!="")
                              for(var item in habits)
                                habit(item)
                          ],
                        ),
                        Divider(height: 30,),
                        Container(
                          child: Text(userData["u_desc"]),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ):Text("Wait..."),
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 15,left: 10,right: 10,top: 5),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      nopeAdd(userData["id"]);
                    });
                  },
                   child: btmBox("dislike.png", baseColor.withOpacity(0.2))),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      likeAdd(userData["id"]);
                      chatSession();
                    });
                  },
                  child: btmBox("like.png", baseColor)
              ),
            ),
          ],
        ),
      ),
    );
  }
  habit(item){
    return userData["habits"]==""?Container(): Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: myGrey.shade300,
          borderRadius: BorderRadius.circular(5)),
      child: Text(item,style: TextStyle(fontSize: 14),),
    );
  }
  hobbie(item){
    return userData["hobbies"]==""?Container():Container(
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
    child: Image.asset("assets/exwork/"+img,height: 40,color: col==baseColor?Color(0xFFE7F1DB):baseColor,),
  );
}