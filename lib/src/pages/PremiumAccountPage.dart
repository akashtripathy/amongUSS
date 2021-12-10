import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';

class PremiumAccount extends StatefulWidget {
  @override
  _PremiumAccountState createState() => _PremiumAccountState();
}

class _PremiumAccountState extends State<PremiumAccount> {
  int plane= 1;
  int subscription = 1;
  var subType="free";
  var amount=0.0;
  ApiService myApi= new ApiService();
  ProgressDialog pr;

 /* makePayment() async{
    await pr.show();
    final request = BraintreePayPalRequest(amount: amount.toString());
    BraintreePaymentMethodNonce result = await Braintree.requestPaypalNonce(
      'sandbox_ykcqtn4y_4cjxgspdmrpkxk4h',
      request,
    );
    if (result != null) {
      print('Nonce: ${result.nonce}');
      Fluttertoast.showToast(msg: "Payment successful");
      addSubscription(result.nonce);
    } else {
      await pr.hide();
      Fluttertoast.showToast(msg: "Payment Fail");
    }
  }*/
  /*addSubscription(subKey) async{
    var service= await myApi.addSubscription(subType, amount, subKey);
    pr.hide();
    if(service["status"]==true){
      Fluttertoast.showToast(msg: "Enjoy your subscription");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen()));
    }
  }*/

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text("Get Premium Account",style: TextStyle(color: myBlack),),
        leading: IconButton(
            icon:Icon(Icons.arrow_back,color: myBlack,),
            splashRadius: 25,
            onPressed: ()=> Navigator.pop(context)
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _headLine(),
                SizedBox(
                  height: 20.0,
                ),
                _swiper(),
                SizedBox(height: 10.0,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 220.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              subscription =1;
                              amount=0;
                              subType="free";
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                            decoration: BoxDecoration(
                              color: subscription==1?baseColor:Color(0xffEFEFF0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: _column("FREE","15 swipes \n(adjustable)","FAQ","","","","",
                                  subscription==1?baseColor:Color(0xffEFEFF0),
                                  CrossAxisAlignment.center),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              subscription =12;
                              amount=36.52;
                              subType="premium";
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                            decoration: BoxDecoration(
                              color: subscription==12?baseColor:Color(0xffEFEFF0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: _column("PREMIUM",
                                  "Super like",
                                  "Unlimited swipes",
                                  "Rewind swipe",
                                  "Hide ads",
                                  "See who likes you ",
                                  "FAQ",
                                  subscription==12?baseColor:Color(0xffEFEFF0),
                                  CrossAxisAlignment.center
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                conButton(context/*,makePayment*/),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _headLine() {
  return Container(
    margin: EdgeInsets.only(top: 30.0),
    child: Center(
      child: Text(
        "Buy Premium Account",
        style: TextStyle(
          fontSize: 22.0,
          color: myBlack,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
Widget _swiper() {
  return Container(
    height: 220.0,
    child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            children: <Widget>[
              Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icon/cm.png',
                      fit: BoxFit.cover,
                      height: 119.0,
                      width: 119.0,
                    ),
                  )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
      autoplay: false,
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      pagination: new SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: new DotSwiperPaginationBuilder(
              color: Color(0xFFC4C4C4), activeColor: Color(0xFF525252))),
      // control: new SwiperControl(),
    ),
  );
}

Widget conButton(context/*,makePayment*/) {
  return Container(
    height: 52,
    margin: EdgeInsets.symmetric(horizontal: 25.0),
    width: MediaQuery.of(context).size.width * 1,
    child: MaterialButton(
      color: baseColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      onPressed: () {
        /*makePayment();*/
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Credit_Screen()));
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
Widget _column(var type, var feature1,var feature2,var feature3,var feature4,var feature5,var feature6,Color color,var textalign) {
  return Column(
    crossAxisAlignment: textalign,
    children: <Widget>[
      Text(
        type.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700,color: color==baseColor?Colors.white:myBlack,),
      ),
      //SizedBox(height: 5,),
      Divider(thickness: 1,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check,size: 18,color: color==baseColor?Colors.white:myBlack),
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              feature1,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color==baseColor?Colors.white:myBlack,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
      SizedBox(height: 5,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check,size: 18,color: color==baseColor?Colors.white:myBlack),
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              feature2,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color == baseColor ? Colors.white : myBlack,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      SizedBox(height: 5,),
      feature3==""?Container(): Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check,size: 18,color: color==baseColor?Colors.white:myBlack),
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              feature3,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color == baseColor ? Colors.white : myBlack,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      SizedBox(height: 5,),
      feature4==""?Container(): Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check,size: 18,color: color==baseColor?Colors.white:myBlack),
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              feature4,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color==baseColor?Colors.white:myBlack,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      SizedBox(height: 5,),
      feature5==""?Container(): Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check,size: 18,color: color==baseColor?Colors.white:myBlack),
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              feature5,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color==baseColor?Colors.white:myBlack,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      SizedBox(height: 5,),
      feature6==""?Container(): Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check,size: 18,color: color==baseColor?Colors.white:myBlack),
          SizedBox(width: 5,),
          Expanded(
            child: Text(
              feature6,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: color == baseColor ? Colors.white : myBlack,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ],
  );
}
