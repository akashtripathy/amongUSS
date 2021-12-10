import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';
import 'package:vtogethernew/src/Services/yelApiService.dart';
import 'package:vtogethernew/src/pages/DiscoverProfilePage.dart';
import 'package:vtogethernew/src/pages/PlaceGridPage.dart';
import 'package:vtogethernew/src/pages/ChatListPage.dart';
import 'package:vtogethernew/src/pages/ProfilePage.dart';

class Pages extends StatefulWidget {

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final Connectivity _connectivity = Connectivity();
  ApiService myApi = new ApiService();
  YelpApi yelpApi = new YelpApi();
  ProgressDialog pr;
  List<dynamic> restaurants=[];
  int _currentIndex = 1;
  DateTime currentBackPressTime;
  var subscription;
  var prefData;
  var userData;

  getUserInfo() async{
    var service = await myApi.getAllUserData();
    if(service["status"]==true){
      prefData = service["preference"];
      userData= service["userdata"];
    }
    setState(() {});
  }

  nearByRestaurant() async {
    //await pr.show();
    var service=await yelpApi.getRestaurantNearMe();
    //await pr.hide();
    setState(() {
      restaurants=service["businesses"];
    });
  }

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
          Fluttertoast.showToast(msg: "Connecting...");
        });
        break;
      case ConnectivityResult.none:
        setState(() => Fluttertoast.showToast(msg: "No Internet Connection!"));
        break;
      default:
        setState(() =>print(result.toString()));
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    nearByRestaurant();
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
    final List<Widget> tabs = [
      PlaceGrid(resturants: restaurants,nearByRestaurant: nearByRestaurant),
      DiscoverProfile(),
      ChartList(),
      Profile(prefData: prefData,userData: userData, getUserInfo: getUserInfo),
    ];
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.hide();
    onTabTapped(index) {
      setState(() {
        _currentIndex=index;
      });
    }
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
//        type: BottomNavigationBarType.fixed,
        backgroundColor: myGrey.shade100,
        currentIndex: _currentIndex,
        unselectedIconTheme: IconThemeData(color: myGrey.shade400),
        unselectedLabelStyle: TextStyle(color: myGrey.shade100),
        selectedItemColor: baseColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/exwork/home.png",height: 30,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/exwork/discover.png",height: 30,),
              label: 'Discover'
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/exwork/message.png",height: 30,),
              label: 'Messages'
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/exwork/profile.png",height: 30,),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
  Future<bool> onWillPop() async{
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Tap again to exit");
      return false;
    }
    setState(() {
      SystemNavigator.pop();
    });
    return true;
  }
}
