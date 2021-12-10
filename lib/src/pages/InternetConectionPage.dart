import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/pages/LoginScreenPage.dart';
import 'package:vtogethernew/src/pages/PagesPage.dart';
class ConnectionCheck extends StatefulWidget {
  @override
  _ConnectionCheckState createState() => _ConnectionCheckState();
}

class _ConnectionCheckState extends State<ConnectionCheck> {
  final Connectivity _connectivity = Connectivity();
  var subscription;
  var connection=false;
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
          connection=true;
        });
        break;
      case ConnectivityResult.none:
        setState(() => Fluttertoast.showToast(msg: "Please connect to internet"));
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
  @override
  void initState() {
    super.initState();
    isConnected();
    subscription = _connectivity.onConnectivityChanged.listen(updateConnection);
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_rounded,size: 100,color: Colors.red,),
              Text("No Internet !",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: myBlack),),
              SizedBox(height: 5,),
              Text("Check your internet connection\n and try again",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: myGrey2),textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Container(
                width: 100,
                height: 35,
                child: MaterialButton(
                  color: baseColor,
                  child: new Text('Retry',
                      style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      if(connection==true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => x));
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
