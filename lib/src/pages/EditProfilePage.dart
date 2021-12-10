import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'dart:io';
import 'package:vtogethernew/src/Services/MyColor.dart';
import 'package:vtogethernew/src/Services/apiServices.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> selectitems = ['Student', 'Professional'];
  var date = DateTime.now();
  var prefData;
  var userData;
  String selecteditem = "Student";
  List<String> options = ['Male', 'Female'];
  String optionSelected = "Male";
  ApiService myApi = new ApiService();
  ProgressDialog pr;
  List<String> habits=null;
  List<String> hobbies=null;

  var type=TextEditingController();
  var addrs=TextEditingController();
  var bio=TextEditingController();
  var job=TextEditingController();
  var name=TextEditingController();
  var mob=TextEditingController();
  var email=TextEditingController();
  String imgUrl="";
  List<String> otherImgUrl=["","","",""];

  File _image;
  List<String> otherImages=["","","",""];
  final picker = ImagePicker();

  Future uploadFile(img) async {
    await Firebase.initializeApp();
    final _firebaseStorage = FirebaseStorage.instance;
    var snapshot = await _firebaseStorage
        .ref()
        .child('Profile/${Path.basename(img.path)}').putFile(img);
    await snapshot.ref.getDownloadURL().then((fileURL) {
      setState(() {
        imgUrl=fileURL;
      });
    });
  }
  Future uploadOtherImg(List<String> imgs) async{
    await Firebase.initializeApp();
    final _firebaseStorage = FirebaseStorage.instance;
    for(int i=0;i<imgs.length;i++){
      if(imgs[i]!=""){
        var snapshot = await _firebaseStorage
            .ref()
            .child('Other Images/${Path.basename(imgs[i])}').putFile(File(imgs[i]));
        await snapshot.ref.getDownloadURL().then((fileURL) {
          setState(() {
            otherImgUrl[i]=fileURL;
          });
        });
      }
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    setState(() {
      if (croppedFile != null) {
        _image = croppedFile;
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    setState(() {
      if (croppedFile != null) {
        _image = croppedFile;
      } else {
        print('No image selected.');
      }
    });
  }
  Future getMulImageGallery(index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 5),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    setState(() {
      if (pickedFile != null) {
        otherImages[index] = croppedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  getUserInfo() async{
    pr.show();
    var service= await myApi.getAllUserData();
    if(service["status"]==true){
      pr.hide();
      prefData= service["preference"];
      userData= service["userdata"];
      setState(() {
        if(prefData.length>0){
          type.text= prefData["type"];
          addrs.text= prefData["addr"];
          hobbies= prefData["hobbies"].split(",");
          habits= prefData["habits"].split(",");
          bio.text= prefData["u_desc"];
          job.text= prefData["job"];
          selecteditem= prefData["profession"];
        }
        else{
          hobbies=[];
          habits=[];
        }
        optionSelected= userData['gender'];
        name.text=userData["name"];
        email.text=userData["email"];
        mob.text=userData["mob"];
        imgUrl=userData["profile_pic"] != null ? userData["profile_pic"] : '';
        otherImgUrl=userData["other_pic"]!=null ? userData["other_pic"].split(",") : otherImgUrl;
        date= DateTime.parse(userData["dob"]);
      });
    }
  }

  addPreferenceData() async{
    if(validation()){
      pr.show();
      if(_image!=null){
        await uploadFile(_image);
      }
      print("url "+otherImgUrl.join(",").toString());
      if(otherImages[0]!=""||otherImages[1]!=""||otherImages[2]!=""||otherImages[3]!=""){
        print('entered');
        await uploadOtherImg(otherImages);
      }
      var service= await myApi.addPreference(type.text, addrs.text, hobbies.join(","), habits.join(",").toString(), bio.text, job.text, selecteditem.toString());
      var service1=await myApi.userUpdate(
        name.text,
        email.text,
        optionSelected,
        mob.text,
        date,
        imgUrl,
        otherImgUrl.join(","),
      );
      await updateFirebaseUser();
      await getUserInfo();
      pr.hide();
      if(service["status"]==true && service1["status"]==true){
        Fluttertoast.showToast(msg:"data Updated");
      }else{
        Fluttertoast.showToast(msg: service["msg"]);
      }
    }
  }
  Future<void> updateFirebaseUser() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    return users
        .doc(pref.getString("userKey").toString())
        .update({'name': name.text.toString(),
                  'profile_pic':imgUrl.toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserInfo();
    });
  }

  bool validation() {
    if(name.text == ""){
      Fluttertoast.showToast(msg: "Please enter name");
      return  false;
    }
    if(DateFormat.yMd().format(date) == DateFormat.yMd().format(DateTime.now())){
      Fluttertoast.showToast(msg: "Please enter valid DOB");
      return false;
    }
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email.text)) {
      Fluttertoast.showToast(msg: 'Please enter valid email');
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.hide();
    print("Hobbies:"+hobbies.toString());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text("Edit Profile",style: TextStyle(color: myBlack),),
        leading: IconButton(
            icon:Icon(Icons.arrow_back,color: myBlack,),
            splashRadius: 25,
            onPressed: ()=> Navigator.pop(context)
        ),
        actions: [
          IconButton(
            onPressed: (){
              addPreferenceData();
            },
            padding: EdgeInsets.only(right: 20),
            icon: Icon(Icons.save,size: 30,color: baseColor,),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 10,),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color.fromRGBO(232, 232, 232, 1),
                          backgroundImage: _image != null ? FileImage(_image) : imgUrl != ''?NetworkImage(imgUrl) : AssetImage('assets/exwork/blank_image.png') ,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showMod(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(232, 232, 232, 1),
                          radius: 16,
                          child: Icon(
                            Icons.camera_alt,
                            color: myBlack,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Container(
                      height: 200,
                      width: size.width,
                      child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          primary: true,
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Stack(children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                height: 250,
                                width:size.width*0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: myGrey,
                                  image: DecorationImage(
                                    image: otherImages[index]!=""?FileImage(File(otherImages[index])): otherImgUrl[index] != ''?NetworkImage(otherImgUrl[index]) :AssetImage(
                                      "assets/exwork/blank_image.png",
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                ),
                                /*child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child:
                                  Image.network(
                                    "https://images.pexels.com/photos/324557/pexels-photo-324557.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                                    fit: BoxFit.cover,
                                  ),
                                ),*/
                              ),
                              Positioned.fill(
                                  bottom: 0.0,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: CircleAvatar(
                                          child: IconButton(
                                            onPressed: () {
                                              getMulImageGallery(index);
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: myBlack,
                                              size: 18,
                                            ),
                                          ),
                                          radius: 16,
                                          backgroundColor: Color.fromRGBO(232, 232, 232, 1),
                                        ),
                                      )
                                  )),
                            ]);
                          })),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          color: Color(0xffE5E5E5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: myBlack2,
                                fontWeight: FontWeight.normal, fontSize: 15),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        color: Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: name,
                          maxLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Write you name...",
                            border: InputBorder.none,
                            //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          color: Color(0xffE5E5E5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'DOB',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: myBlack2,
                                fontWeight: FontWeight.normal, fontSize: 15),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        color: Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: new InkWell(
                          onTap: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomPicker(
                                  CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (DateTime newDateTime) {
                                      setState(() => date = newDateTime);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10.0,),
                                    DateFormat.yMd().format(date) !=
                                        DateFormat.yMd().format(DateTime.now())
                                        ? Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        DateFormat.yMd().format(date) !=
                                            DateFormat.yMd().format(DateTime.now())
                                            ? DateFormat.yMMMMd().format(date)
                                            : 'DOB',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: DateTime.now().difference(date).inDays >=
                                              6570
                                              ? myBlack2
                                              : myBlack2,
                                        ),
                                      ),
                                    )
                                        :  Text(
                                      'DOB',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: myBlack3,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Container(
                                        height: 1.2,
                                        color: myBlack2,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          color: Color(0xffE5E5E5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Mobile',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: myBlack2,
                                fontWeight: FontWeight.normal, fontSize: 15),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        color: Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: mob,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Write you mobile no....",
                            border: InputBorder.none,
                            //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          color: Color(0xffE5E5E5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'E-mail',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: myBlack2,
                                fontWeight: FontWeight.normal, fontSize: 15),
                          )),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        color: Colors.white,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: email,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Write you email...",
                            border: InputBorder.none,
                            //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          color: Color(0xffE5E5E5),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Bio',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: myBlack,
                                fontFamily: 'Roboto'),
                          )),
                    ],
                  ),

                  Container(
                      color: Color(0xffFFFFFF),
                      // height: 80,
                      //width: 50,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 20, top: 8),
                            child: TextField(
                              controller: bio,
                              maxLines: 5,
                              maxLength: 500,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Write Something about youself....",
                                border: InputBorder.none,
                                //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Job',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack2,
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      color: Colors.white,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: job,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Write you job...",
                          border: InputBorder.none,
                          //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                        ),
                      ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Address',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack2,
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 10),
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: addrs,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Your address...",
                        border: InputBorder.none,
                        //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Type',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack2,
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 10),
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: type,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "e.g. Vegan or Veg...",
                        border: InputBorder.none,
                        //suffixIcon: IconButton(icon: Icon(Icons.edit),)
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Habits',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack2,
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(top:0, left: 10),
                      color: Colors.white,
                      //height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: habits!=null?TextFieldTags(
                          initialTags: habits,
                          tagsStyler: TagsStyler(
                              tagTextStyle: TextStyle(fontWeight: FontWeight.bold),
                              tagDecoration: BoxDecoration(color: baseColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8.0), ),
                              tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
                              tagPadding: const EdgeInsets.all(6.0)
                          ),
                          textFieldStyler: TextFieldStyler(
                            textFieldEnabled: true,
                            hintText: "Enter tags",
                            textFieldBorder: InputBorder.none,
                            helperText: "",
                            contentPadding: EdgeInsets.symmetric(vertical:20),
                          ),

                          onTag: (tag) {
                          },
                          onDelete: (tag) {},
                          validator: (tag){
                            if(tag.length>50){
                              return "hey that's too long";
                            }
                            return null;
                          }
                      ):Container(),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Hobbies',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack2,
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(top:0, left: 10),
                    color: Colors.white,
                    //height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: hobbies!=null?TextFieldTags(
                        initialTags: hobbies,
                        tagsStyler: TagsStyler(
                            tagTextStyle: TextStyle(fontWeight: FontWeight.bold),
                            tagDecoration: BoxDecoration(color: baseColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8.0), ),
                            tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
                            tagPadding: const EdgeInsets.all(6.0)
                        ),
                        textFieldStyler: TextFieldStyler(
                          textFieldEnabled: true,
                          hintText: "Enter tags",
                          textFieldBorder: InputBorder.none,
                          helperText: "",
                          contentPadding: EdgeInsets.symmetric(vertical:20),
                        ),

                        onTag: (tag) {
                        },
                        onDelete: (tag) {},
                        validator: (tag){
                          if(tag.length>50){
                            return "hey that's too long";
                          }
                          return null;
                        }
                    ):Container(),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 15, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Gender',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack2,

                            fontWeight: FontWeight.normal, fontSize: 15),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      style: TextStyle(color: myBlack),
                      isExpanded: true,
                      underline: Container(),
                      hint: Text("Select Your Gender"),
                      value: optionSelected,
                      onChanged: (value) {
                        setState(() {
                          optionSelected = value;
                        });
                      },
                      items: options
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 15, left: 10),
                      color: Color(0xffE5E5E5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'I am',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: myBlack,
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                      style: TextStyle(color: myBlack),
                      value: selecteditem,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (val) {
                        setState(() {
                          selecteditem = val;
                        });
                      },
                      items: selectitems
                          .map((e) => DropdownMenuItem(
                        onTap: () {},
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                    ),
                  )
                ]
                )
            )
        )
      ]
      ),
    );

  }
  showMod(context)
  {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 190,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    getImageGallery();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                    ),
                    child: Text('Camera Roll',style: TextStyle(fontSize: 16,color: myBlack),textAlign: TextAlign.center,),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    getImageCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.only(top: 1),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                    ),
                    child: Text('Take a photo',style: TextStyle(fontSize: 16,color: myBlack),textAlign: TextAlign.center,),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text('Cancel',style: TextStyle(fontSize: 16,color: myBlack2),textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: 216.0,
    padding: const EdgeInsets.only(top: 6.0),
    color: Colors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: myBlack,
        fontSize: 22.0,
      ),
      child: SafeArea(
        top: false,
        child: picker,
      ),
    ),
  );
}
