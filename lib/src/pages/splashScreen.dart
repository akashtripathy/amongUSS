import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/pages/InternetConectionPage.dart';
import 'package:vtogethernew/src/pages/LoginScreenPage.dart';
import 'package:vtogethernew/src/pages/PagesPage.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final Connectivity _connectivity = Connectivity();
  var subscription;
  Widget x= LoginScreen();

  void isConnected() async{
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return updateConnection(result);
  }
  updateConnection(ConnectivityResult result) async{
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() {
          checkPage();
        });
        break;
      case ConnectivityResult.none:
        setState(() => x=ConnectionCheck());
        break;
      default:
        setState(() =>print(result.toString()));
        break;
    }
  }

  checkPage() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    if(pref.containsKey("loggedin") && pref.getBool("loggedin"))
    {
      x=Pages();
    }
  }
  Future<Timer> gotoNext() async {
    return Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => x)),
    );
  }
  @override
  void initState() {
    super.initState();
    isConnected();
    subscription = _connectivity.onConnectivityChanged.listen(updateConnection);
    gotoNext();
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/img/logo.png', height: 180.0,width: 180.0,),
                ],
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
