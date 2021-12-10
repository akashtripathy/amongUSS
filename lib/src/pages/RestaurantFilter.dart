import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class RestaurantFilter extends StatefulWidget {
  const RestaurantFilter({Key key}) : super(key: key);

  @override
  _RestaurantFilterState createState() => _RestaurantFilterState();
}

class _RestaurantFilterState extends State<RestaurantFilter> {
  double currentDistance = 0.5;
  double currentPrice = 1.05;
  String curPrice="\$";
  List<bool> allSwitches = [true, false, false];
  List<String> resType=["Vegan","",""];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Text(
                      'Filters',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( top: 25,right: 5),
                    child: IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Text('Restaurants'),
              ),
              Container(
                  padding: EdgeInsets.only(top: 8, left: 20, bottom: 8),
                  color: Color(0xffFFFFFF),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vegan',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FlutterSwitch(
                          height: 20.0,
                          width: 35.0,
                          padding: 2,
                          toggleSize: 15.0,
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myBlack3,
                          value: allSwitches[0],
                          onToggle: (value) {
                            setState(() {
                              allSwitches[0] = value;
                              if(value==false){
                                resType[0]="";
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 8),
                color: Color(0xffFFFFFF),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vegetarian',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FlutterSwitch(
                        height: 20.0,
                        width: 35.0,
                        padding: 2,
                        toggleSize: 15.0,
                        toggleColor: Color(0xffFFFFFF),
                        borderRadius: 10.0,
                        activeColor: baseColor,
                        inactiveColor: myBlack3,
                        value: allSwitches[1],
                        onToggle: (value) {
                          setState(() {
                            allSwitches[1] = value;
                            if(value==true){
                              resType[1]="Vegetarian,";
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 8),
                color: Color(0xffFFFFFF),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Veg Options',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FlutterSwitch(
                        height: 20.0,
                        width: 35.0,
                        padding: 2,
                        toggleSize: 15.0,
                        toggleColor: Color(0xffFFFFFF),
                        borderRadius: 10.0,
                        activeColor: baseColor,
                        inactiveColor: myBlack3,
                        value: allSwitches[2],
                        onToggle: (value) {
                          setState(() {
                            allSwitches[2] = value;
                            if(value==true){
                              resType[2]="Veg";
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price Range'),
                    Text(
                      curPrice,
                      style: TextStyle(color: baseColor, fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30, bottom: 8, top: 10),
                color: Color(0xffFFFFFF),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Slider(
                  inactiveColor: baseColor.withOpacity(0.3),
                  activeColor: baseColor,
                  value: currentPrice,
                  min: 0,
                  max: 4,
                  onChanged: (value) {
                    setState(() {
                      currentPrice = value;
                      if(currentPrice.round()==1){
                        curPrice="\$";
                      }
                      else if(currentPrice.round()==2){
                        curPrice="\$\$";
                      }
                      else if(currentPrice.round()==3){
                        curPrice="\$\$\$";
                      }
                      else if(currentPrice.round()==4){
                        curPrice="\$\$\$\$";
                      }
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Distance'),
                    Text(
                      '${currentDistance.round().toString()} miles',
                      style: TextStyle(color: baseColor, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 30, bottom: 8, top: 10),
                  color: Color(0xffFFFFFF),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Slider(
                    inactiveColor: baseColor.withOpacity(0.3),
                    activeColor: baseColor,
                    value: currentDistance,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        currentDistance = value;
                      });
                    },
                  )),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  height: 50,
                  minWidth: size.width,
                  color: baseColor,
                  onPressed: () {
                    List<String> filters=[resType.join(","),currentPrice.round().toString(),currentDistance.round().toString()];
                    Navigator.pop(context,filters);
                  },
                  child: Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
