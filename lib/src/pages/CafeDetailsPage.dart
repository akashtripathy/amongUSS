import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtogethernew/src/Services/MyColor.dart';

class CafeDetails extends StatefulWidget {
  var data;
  CafeDetails({this.data});
  @override
  _CafeDetailsState createState() => _CafeDetailsState(data);
}

class _CafeDetailsState extends State<CafeDetails> {
  var data;
  _CafeDetailsState(this.data,);
  String address="";
  String category="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var add in data["location"]["display_address"])
    {
      address+=add+",";
    }
    for(var cat in data["categories"])
    {
      category+=cat["title"]+",";
    }
    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(data["name"],style: TextStyle(color: myBlack),),
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: myBlack,),onPressed: ()=> Navigator.pop(context), splashRadius: 20,),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _cafeImage(data["image_url"]=="" ? "assets/icon/cafe.jpg" : data["image_url"]),
                _aboutCafe(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cafeImage(String path) {
    return Container(
      height: 188,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(path),
          fit: BoxFit.cover,
        )
      ),
    );
  }

  Widget _aboutCafe() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Container(
          height: 20.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    data["location"]["city"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Image.asset(
                    "assets/icon/leaf.png",
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 20.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  data["rating"].toString(),
                  style: TextStyle(
                    color: myOrange,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return index < int.parse("4")
                      ? Icon(Icons.star, size: 18.0, color: myOrange)
                      : Icon(Icons.star_border,
                      size: 18.0, color: myOrange);
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  data["review_count"].toString()+" reviews",
                  style: TextStyle(
                    color: Color(0xFF2F80ED),
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          //height: 20.0,
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  child: Text(
                    " •  "+category,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 40.0),
                child: Text(
                  address, //todo
                  style: TextStyle(
                    color: myGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  data["is_closed"]==false?"Now Open":"Now Closed",
                  style: TextStyle(
                    color: Color(0xFF2F80ED),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
              ),
              /*Text(
                " 12:00 to 22:00 (today)",
                style: TextStyle(
                  color: myGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
              ),*/
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        /*Divider(
          height: 1.0,
          color: myGrey,
        ),
        Container(
          child: Center(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Text(
                "Test Description", //todo
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),*/
        Divider(
          height: 1.0,
          color: myGrey,
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: ()async{
                    const url = 'http://www.google.com/maps/place/';
                    if(data["coordinates"]["latitude"]!=""||data["coordinates"]["longitude"]!="") {
                      await launch(url + '${data["coordinates"]["latitude"]},${data["coordinates"]["longitude"]}');
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icon/marker.png"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Directions",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: ()async{
                    if(data["url"]!="") {
                      await launch(data["url"]);
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icon/visit.png"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Visit site",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async{
                    if(data["phone"]!="") {
                      await launch("tel:${data["phone"]}");
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icon/tel_phone.png"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Phone call",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
} //  end of the class
