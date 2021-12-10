import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _currentDistance = 0.5;
  RangeValues _currentRange = const RangeValues(13, 100);

  List<bool> allSwitches = [true,false,false,true,false,false,true,false,false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var minAge = _currentRange.start.round().toString();
    var maxAge =_currentRange.end.round().toString();
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
                child: Text('Show me'),
              ),
              Container(
                  padding: EdgeInsets.only(top: 8, left: 20, bottom: 8),
                  color: Color(0xffFFFFFF),
                  height: 40,
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
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 8),
                color: Color(0xffFFFFFF),
                height: 30,
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
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Open to Change',
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
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Text('Show me'),
              ),
              Container(
                  padding: EdgeInsets.only(top: 8, left: 20, bottom: 8),
                  color: Color(0xffFFFFFF),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Male',
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
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myBlack3,
                          value: allSwitches[3],
                          onToggle: (value) {
                            setState(() {
                              allSwitches[3] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 8),
                color: Color(0xffFFFFFF),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Female',
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
                        borderRadius: 10.0,
                        toggleColor: Color(0xffFFFFFF),
                        activeColor: baseColor,
                        inactiveColor: myBlack3,
                        value: allSwitches[4],
                        onToggle: (value) {
                          setState(() {
                            allSwitches[4] = value;
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
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Other',
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
                        borderRadius: 10.0,
                        toggleColor: Color(0xffFFFFFF),
                        activeColor: baseColor,
                        inactiveColor: myBlack3,
                        value: allSwitches[5],
                        onToggle: (value) {
                          setState(() {
                            allSwitches[5] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Text('Show me'),
              ),
              Container(
                  padding: EdgeInsets.only(top: 8, left: 20, bottom: 8),
                  color: Color(0xffFFFFFF),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Love',
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
                          borderRadius: 10.0,
                          toggleColor: Color(0xffFFFFFF),
                          activeColor: baseColor,
                          inactiveColor: myBlack3,
                          value: allSwitches[6],
                          onToggle: (value) {
                            setState(() {
                              allSwitches[6] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 8),
                color: Color(0xffFFFFFF),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Friendship',
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
                        borderRadius: 10.0,
                        toggleColor: Color(0xffFFFFFF),
                        activeColor: baseColor,
                        inactiveColor: myBlack3,
                        value: allSwitches[7],
                        onToggle: (value) {
                          setState(() {
                            allSwitches[7] = value;
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
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Network',
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
                        borderRadius: 10.0,
                        toggleColor: Color(0xffFFFFFF),
                        activeColor: baseColor,
                        inactiveColor: myBlack3,
                        value: allSwitches[8],
                        onToggle: (value) {
                          setState(() {
                            allSwitches[8] = value;
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
                    Text('Age Range'),
                    Text(
                      '${_currentRange.start.round().toString()} - ${_currentRange.end.round().toString()}',
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
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Maximum distance'),
                    Text(
                      '${_currentDistance.round().toString()} miles',
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
                    value: _currentDistance,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _currentDistance = value;
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
                    List<String> filters=[allSwitches[0].toString(),allSwitches[1].toString(),allSwitches[2].toString(),
                      allSwitches[3].toString(),allSwitches[4].toString(),allSwitches[5].toString(),
                      allSwitches[6].toString(),allSwitches[7].toString(),allSwitches[8].toString(),
                      minAge,maxAge,_currentDistance.round().toString()
                    ];
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
