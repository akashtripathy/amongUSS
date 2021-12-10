import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventDetails extends StatefulWidget {
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Vege Event",style: TextStyle(color: Colors.black),),
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: ()=> Navigator.pop(context),splashRadius: 20,),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _eventImage("assets/icon/event.png"),
                _aboutEvent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _eventImage(String path) {
    return Container(
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        height: 200.0,
        width: MediaQuery.of(context).size.width * 1,
      ),
    );
  }

  Widget _aboutEvent() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Vege event",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Event",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.0),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Text(
                  "639 S Spring St, Los Angeles CA 90014, USA",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0),
          child: Row(
            children: <Widget>[
              Text(
                "12:00 to 22:00 (22.06.2019)",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
        Container(
          child: Center(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                    " Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
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
              Expanded(
                child: InkWell(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );*/
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
            ],
          ),
        )
      ],
    );
  }
} //  end of the class
