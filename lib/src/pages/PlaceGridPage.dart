import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/yelApiService.dart';
import 'package:vtogethernew/src/pages/CafeDetailsPage.dart';
import 'package:vtogethernew/src/pages/EventPage.dart';
import 'package:vtogethernew/src/pages/RestaurantFilter.dart';

class PlaceGrid extends StatefulWidget {
  var resturants;
  var nearByRestaurant;
  PlaceGrid({this.resturants,this.nearByRestaurant});
  @override
  _PlaceGridState createState() => _PlaceGridState(resturants);
}

class _PlaceGridState extends State<PlaceGrid> {
  var resturants;
  _PlaceGridState(this.resturants);
  YelpApi myApi=new YelpApi();
  ProgressDialog pr;
  List<String> filters=[];

  nearByRestaurantbyfilter(filter) async {
    await pr.show();
    var service=await myApi.getRestaurantByFilter(filter[0],filter[1],filter[2]);
    await pr.hide();
    setState(() {
      resturants=service["businesses"];
    });
  }

  getplaces()
  {
    List<Widget> data=[];
    for(int i=0;i<resturants.length;i++)
      {
        String address="";
        for(var add in resturants[i]["location"]["display_address"])
          {
            address=address+add+",";
          }
        data.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CafeDetails(data: resturants[i],)),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    resturants[i]["image_url"] == ""?
                    Image.asset("assets/icon/plc_h.png"):
                    Container(
                      height: 100,
                      width: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(resturants[i]["image_url"]),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      resturants[i]["name"],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*SchedulerBinding.instance.addPostFrameCallback((_) {
      nearByRestaurant();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Places",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Events()));
                            },
                            child: Container(
                              child: Icon(Icons.event,size: 30,color: myGrey2,),
                            ),
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            onTap: ()async{
                              filters=await Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantFilter()));
                              print(filters);
                              if(filters != null)
                                {
                                  nearByRestaurantbyfilter(filters);
                                }
                            },
                            child: Container(
                              child: Image.asset("assets/icon/settings.png"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              resturants!=null && resturants.length>0?Expanded(
                child: Container(
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children:getplaces()
                  ),
                ),
              ):Container(
                child: Text("No Restaurant found"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
