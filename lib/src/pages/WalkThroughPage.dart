import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/pages/PagesPage.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  RangeValues _currentRange = const RangeValues(0, 100);
  double _currentDistance = 0.5;
  String isSelected= "Vegan";
  List<bool> showMe=[true,false,false];
  List<String> showMeVal=["Male ","",""];
  List<bool> lookingFor=[true,false,false];
  List<String> lookingForVal=["Love ","",""];
  ApiService myApi = new ApiService();
  ProgressDialog pr;



  userInterest() async{
    await pr.show();
    var server = await myApi.userInterest(isSelected,
        showMeVal[0]+showMeVal[1]+showMeVal[2],
        lookingForVal[0]+lookingForVal[1]+lookingForVal[2],
        _currentRange.start.round().toString()+"-"+_currentRange.end.round().toString(),
        _currentDistance.round().toString()
    );
    print(server);
    if(server["status"]==true){
      await pr.hide();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Pages()));
      Fluttertoast.showToast(msg: server['msg']);
    }
    else{
      await pr.hide();
      Fluttertoast.showToast(msg: server['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    final size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon:Icon(Icons.arrow_back,color: myBlack3,),
            splashRadius: 25,
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: 26.0,
                    right: 20.0,
                    top: 10,
                    bottom: 10.0),
                child: Text("I am",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: myBlack,
                      fontSize: 18.0,
                    )),
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width -50,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSelected = "Vegan";
                            });
                          },
                          child: Container(
                            width: size.width/3 -20,
                            child: cusChips(isSelected=="Vegan" ? baseColor : Color(0xFFD6D6D6), "Vegan"),
                          ),
                        ),
                        SizedBox(width: 3,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSelected = "Vegetarian";
                            });
                          },
                          child: Container(
                            width: size.width/3-20,
                            child: cusChips(isSelected=="Vegetarian" ? baseColor : Color(0xFFD6D6D6), "Vegetarian"),
                          ),
                        ),
                        SizedBox(width: 3,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSelected = "Other";
                            });
                          },
                          child: Container(
                            width: size.width/3-20,
                            child: cusChips(isSelected=="Other" ? baseColor : Color(0xFFD6D6D6),"Open for Change"),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 26.0, right: 20.0, top: 20),
                child: Text("Show me",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: myBlack,
                      fontSize: 18.0,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 26,),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Male',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: myGrey2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myGrey,
                          value: showMe[0],
                          onToggle: (value) {
                            setState(() {
                              showMe[0] = value;
                              if(showMe[0]==false){
                                showMeVal[0]="";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 26),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Female',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: myGrey2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myGrey,
                          value: showMe[1],
                          onToggle: (value) {
                            setState(() {
                              showMe[1] = value;
                              if(showMe[1]==true){
                                showMeVal[1]="Female ";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10,left: 26),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Other',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: myGrey2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myGrey,
                          value: showMe[2],
                          onToggle: (value) {
                            setState(() {
                              showMe[2] = value;
                              if(showMe[2]==true){
                                showMeVal[2]="Other";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 26.0, right: 20.0, top: 20),
                child: Text("I am looking for",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: myBlack,
                      fontSize: 18.0,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 26,),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Love',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: myGrey2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myGrey,
                          value: lookingFor[0],
                          onToggle: (value) {
                            setState(() {
                              lookingFor[0] = value;
                              if(lookingFor[0]==false){
                                lookingForVal[0]="";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 26),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Friendship',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: myGrey2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myGrey,
                          value: lookingFor[1],
                          onToggle: (value) {
                            setState(() {
                              lookingFor[1] = value;
                              if(lookingFor[1]==true){
                                lookingForVal[1]="Friendship ";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10,left: 26),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Network',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: myGrey2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myGrey,
                          value: lookingFor[2],
                          onToggle: (value) {
                            setState(() {
                              lookingFor[2] = value;
                              if(lookingFor[1]==true){
                                lookingForVal[1]="Network";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 26.0, right: 20.0, top: 20),
                child: Text("Age Range",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: myBlack,
                      fontSize: 18.0,
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_currentRange.start.round().toString()} - ${_currentRange.end.round().toString()}',
                      style: TextStyle(color: baseColor, fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: RangeSlider(
                  inactiveColor: baseColor.withOpacity(0.3),
                  activeColor: baseColor,
                  values: _currentRange,
                  min: 0,
                  max: 100,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRange = values;
                    });
                  },
                ),
              ),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.only(
                  left: 26.0, right: 20.0,),
                child: Text("Maximum distance",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: myBlack,
                      fontSize: 18.0,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_currentDistance.round().toString()} miles',
                      style: TextStyle(color: baseColor, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, bottom: 8,right: 20.0 ),
                  width: MediaQuery.of(context).size.width,
                  child: Slider(
                    inactiveColor: baseColor.withOpacity(0.3),
                    activeColor: baseColor,
                    value: _currentDistance,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _currentDistance = value;
                      });
                    },
                  )
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    conButton(context),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Privacy.Terms Of Use",
                        style: TextStyle(color: myGrey),
                      ),
                    ),
                    SizedBox(height: 15,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cusChips(Color color, String text) {
    return Container(
      height: 45.0,
      child: Center(child: Text(text,style: TextStyle(color: color==baseColor?Colors.white:myBlack2),textAlign: TextAlign.center,)),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Color(0xFFD6D6D6)),
        borderRadius: BorderRadius.circular(6),
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
          userInterest();
        },
        child: Text(
          "Continue",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }
}



