import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService{
  String url ="http://stock19.xyz/vtogether/api/";
  /*sendOtp(mob) async{
    var server=await http.post(
      Uri.parse(url+"api_otp"),
      body: {
        "mob":mob.toString()
      }
    );
    return jsonDecode(server.body);
  }*/

  /*verifyOtp(otp, mob) async{
    var server=await http.post(
      Uri.parse(url+"api_verifyotp"),
      body: {
        "otp": otp,
        'mob': mob,
      }
    );
    return jsonDecode(server.body);
  }*/
  
  verifyWithMob(mob) async{
    var server= await http.post(
      Uri.parse(url+"mobile_verify"),
      body: {
        "mob": mob
      }
    );
    return jsonDecode(server.body);
  }

  userWithMob(name,email,gender,mob,dob,userKey) async{
    var server= await http.post(
      Uri.parse(url+"user_withmob"),
      body: {
        "name": name,
        "email": email,
        "gender": gender,
        "mob": mob,
        "dob": dob.toString(),
        "user_key":userKey.toString(),
      }
    );
    return jsonDecode(server.body);
  }

  userInterest(type,showMe,lookingFor,ageRange,distance) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var server = await http.post(
      Uri.parse(url+"Add_userinterest"),
      headers: {
        "apikey":pref.getString("apikey")
      },
      body: {
        "type": type.toString(),
        "showme": showMe.toString(),
        "looking_for": lookingFor.toString(),
        "age_range": ageRange.toString(),
        "nest_distance": distance.toString(),
      }
    );
    return jsonDecode(server.body);
  }

  //show users in Discover page
  userDetails() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var server = await http.post(
      Uri.parse(url+"other_preference_byloginapi"),
      headers: {
        "apikey": pref.getString("apikey"),
      }
    );
    return jsonDecode(server.body);
  }

  //filter the user showed in discover page
  filterUserDetails(vegan,veg,open,male,female,other,love,friendship,network,ageRanMin,ageRanMax,distance,) async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    var server=await http.post(
      Uri.parse(url+"filter_user_interest"),
      headers: {
        "apikey": pref.getString("apikey"),
      },
      body: {
        "vegan":vegan,
        "vegetarian":veg,
        "open_to_change":open,
        "Male":male,
        "Female":female,
        "other":other,
        "Love":love,
        "Friendship":friendship,
        "Network":network,
        "age_range_minimum":ageRanMin,
        "age_range_maximum":ageRanMax,
        "next_distance":distance,
      }
    );
    return jsonDecode(server.body);
  }

  //right swipe to add like
  addLike(prefId) async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    var server=await http.post(
      Uri.parse(url+"Addlike_preference_api"),
      headers: {
        "apikey": pref.getString("apikey")
      },
      body: {
        "pref_id": prefId.toString(),
      }
    );
    return jsonDecode(server.body);
  }

  //left swipe for nope
  addNope(prefId) async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    var server=await http.post(
        Uri.parse(url+"AddNope_preference_api"),
        headers: {
          "apikey": pref.getString("apikey")
        },
        body: {
          "pref_id": prefId.toString(),
        }
    );
    return jsonDecode(server.body);
  }
  //getting the liked users
  /*getLikedUsers() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var server=await http.post(
      Uri.parse(url+"getall_like_preference"),
      headers: {
        "apikey": pref.getString("apikey")
      }
    );
    return jsonDecode(server.body);
  }*/

  whoLikeMe() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var server=await http.post(
      Uri.parse(url+"who_like_me"),
      headers: {
        "apikey": pref.getString("apikey")
      }
    );
    return jsonDecode(server.body);
  }

  //Update of user data
  userUpdate(name,email,gender,mob,dob,picUrl,otherPicUrl) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var server= await http.post(
        Uri.parse(url+"update_user"),
        headers: {
          "apikey": pref.getString("apikey")
        },
        body: {
          "name": name,
          "email": email,
          "gender": gender,
          "mob": mob,
          "dob": dob.toString(),
          "profile_pic":picUrl.toString(),
          "other_pic": otherPicUrl.toString()
        }
    );
    return jsonDecode(server.body);
  }

  //updating fcm_key
  updateFcmKey(fcmKey) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var server = await http.post(
      Uri.parse(url+"fcmkey_byapi"),
      headers: {
        "apikey": pref.getString("apikey")
      },
      body: {
        "fcm_key": fcmKey,
     }
    );
    return jsonDecode(server.body);
  }

  //edit user details
  addPreference(type,adds,hobbies,habits,bio,job,profs) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var server = await http.post(
        Uri.parse(url+"Add_preference"),
        headers: {
          "apikey": pref.getString("apikey")
        },
        body: {
          "type": type,
          "addr":adds,
          "hobbies": hobbies,
          "habits": habits,
          "u_desc":bio,
          "job":job,
          "profession":profs,
        }
    );
    return jsonDecode(server.body);
  }

  //get all data of a user
  getAllUserData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var server = await http.post(
        Uri.parse(url+"get_user_byapi"),
        headers: {
          "apikey": pref.getString("apikey")
        },
    );
    return jsonDecode(server.body);
  }
  //add subscription details of user
  addSubscription(subType,amount,subKey) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var server = await http.post(
      Uri.parse(url+"Add_payment"),
      headers: {
        "apikey": pref.getString("apikey")
      },
      body: {
        "subscription_type":subType.toString(),
        "v_amount":amount.toString(),
        "subscription_key":subKey.toString(),
      }
    );
    return jsonDecode(server.body);
  }

  //sending notification through firebase
  sendpushnotification(fcmKey,title,body) async{
    var server = await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'token': fcmKey,
          'notification': {
            'title': title,
            'body':body,
          },
        })
    );
    return jsonDecode(server.body);
  }
}