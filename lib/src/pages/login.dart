import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  color: Color(0xFFE5E5E5),
                  child: ListView(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: Container(
                                                width: 30,
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: GestureDetector(
                                                child: Text(
                                                  'amongUSS',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                onTap: () {}),
                                          ),
                                          flex: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              new Container(
                                padding: EdgeInsets.only(
                                    left: 24.0, right: 20.0, top: 35),
                                child: Text("What is your email",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    )),
                              ),
                              new Container(
                                margin:
                                EdgeInsets.only(left: 24.0, right: 20.0),
                                height: 50.0,
                                child: new TextFormField(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1F0F02),
                                    fontSize: 16.0,
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                        new BorderSide(color: Colors.grey)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.grey),
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                    contentPadding:
                                    const EdgeInsets.only(top: 10.0),
                                  ),
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.only(
                                    left: 24.0, right: 20.0, top: 25),
                                child: Text("Setup your password",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    )),
                              ),
                              new Container(
                                margin:
                                EdgeInsets.only(left: 24.0, right: 20.0),
                                height: 50.0,
                                child: new TextFormField(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1F0F02),
                                    fontSize: 16.0,
                                  ),
                                  autofocus: false,
                                  obscureText: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                        new BorderSide(color: Colors.grey)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.grey),
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                    contentPadding:
                                    const EdgeInsets.only(top: 10.0),
                                  ),
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.only(
                                    left: 24.0, right: 20.0, top: 25),
                                child: Text("Repeat password",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    )),
                              ),
                              new Container(
                                margin:
                                EdgeInsets.only(left: 24.0, right: 20.0),
                                height: 50.0,
                                child: new TextFormField(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1F0F02),
                                    fontSize: 16.0,
                                  ),
                                  autofocus: false,
                                  obscureText: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                        new BorderSide(color: Colors.grey)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.grey),
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                    contentPadding:
                                    const EdgeInsets.only(top: 10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.2,
                              ),
                              conButton(context),
                              /*login with*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget conButton(context) {
  return Container(
    margin: EdgeInsets.only(left: 20.0, right: 20.0),
    height: 50,
    width: MediaQuery.of(context).size.width * 1,
    child: MaterialButton(
      color: const Color(0xFFa800a8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
      onPressed: () {},
      child: Text(
        "Contiune",
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: 14.0,
        ),
      ),
    ),
  );
}
