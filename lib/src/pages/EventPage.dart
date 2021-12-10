import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:vtogethernew/src/Services/yelApiService.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  YelpApi myApi=new YelpApi();
  ProgressDialog pr;
  List<dynamic> events=[];

  getEvents() async{
    await pr.show();
    var service=await myApi.getEvent();
    await pr.hide();
    setState(() {
      events=service["events"];
    });
  }
  getplaces()
  {
    List<Widget> data=[];
    for(int i=0;i<events.length;i++)
    {
      String address="";
      for(var add in events[i]["location"]["display_address"])
      {
        address=address+add+",";
      }
      data.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: (){
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  events[i]["image_url"] == ""?
                  Image.asset("assets/icon/plc_h.png"):
                  Container(
                    height: 100,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(events[i]["image_url"]),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    events[i]["name"],
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getEvents();
    });
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
                          "Events",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                    /*Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: ()async{
                          *//*filters=await Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantFilter()));
                          if(filters != null)
                          {
                            nearByRestaurantbyfilter(filters);
                          }*//*
                        },
                        child: Container(
                          child: Image.asset("assets/icon/settings.png"),
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
              events!=null && events.length>0?Expanded(
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
