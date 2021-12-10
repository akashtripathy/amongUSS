import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/EditProfilePage.dart';
import 'package:vtogethernew/src/pages/PremiumAccountPage.dart';
import 'package:vtogethernew/src/pages/SettingPage.dart';

class Profile extends StatefulWidget {
  var prefData;
  var userData;
  var getUserInfo;
  Profile({this.prefData,this.userData,this.getUserInfo});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProgressDialog pr;
  var hobbies;
  var habits;

  @override
  void initState() {
    super.initState();
    if(widget.prefData.length>0)
      {
        setState(() {
          hobbies= widget.prefData["hobbies"].split(",");
          habits= widget.prefData["habits"].split(",");
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromRGBO(232, 232, 232, 1),
                        backgroundImage: widget.userData["profile_pic"]==null||widget.userData["profile_pic"]=="" ?AssetImage("assets/exwork/blank_image.png"):NetworkImage(widget.userData["profile_pic"]),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.userData["name"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                widget.prefData.length>0?Text(
                  widget.prefData["job"]==null?"":widget.prefData["job"],
                  style: TextStyle(fontSize: 18, color: myGrey),
                ):Container(),
                SizedBox(
                  height: 10,
                ),
                widget.prefData.length>0?Column(
                  children: [
                    Divider(
                      color: myGrey.shade400,
                    ),
                    Container(
                      //width: size.width,
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 10,
                        runSpacing: 5,
                        children: [
                          widget.prefData["type"]==""?Container():Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/exwork/vegan.png",
                                    height: 25, width: 25),
                                SizedBox(width: 5),
                                Text(widget.prefData["type"])
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
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Text(widget.prefData["u_desc"]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child:Wrap(
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
                ):SizedBox(height: 100,),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async{
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                        widget.getUserInfo();
                      },
                      child: Column(
                        children: [
                          Stack(children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey.shade200,
                              child: Image.asset("assets/icon/edit.png",height: 70,),
                            ),

                          ]),
                          SizedBox(height: 10),
                          Text(
                            "Edit Profile",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PremiumAccount()));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: baseColor,
                            child: Image.asset("assets/icon/diamond.png",height: 45),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Get Premium \nAccount",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()));
                      },
                      child: Column(
                        children: [
                          Stack(children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey.shade200,
                              child: Image.asset("assets/icon/pro_settings.png",height: 45),
                            ),

                          ]),
                          SizedBox(height: 10),
                          Text(
                            "Settings",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
    );
  }
  habit(item){
    return widget.prefData["habits"]==""?Container(): Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: BorderRadius.circular(5)),
      child: Text(item,style: TextStyle(fontSize: 14),),
    );
  }
  hobbie(item){
    return widget.prefData["hobbies"]==""?Container():Container(
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