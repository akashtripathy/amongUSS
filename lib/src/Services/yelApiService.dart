import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

class YelpApi{
  getRestaurantNearMe() async {
    var server= await http.get(
      Uri.parse("https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972"),
      headers: {
        "Authorization": FlutterConfig.get('YELP_AUTH_KEY')
      }
    );
    return jsonDecode(server.body);
  }

  getRestaurantByFilter(term,price,distance) async {
    var server= await http.get(
        Uri.parse("https://api.yelp.com/v3/businesses/search?term=$term&latitude=37.786882&longitude=-122.399972&price=$price&radius=$distance"),
        headers: {
          "Authorization": FlutterConfig.get('YELP_AUTH_KEY')
        }
    );
    return jsonDecode(server.body);
  }

  getEvent() async {
    var server= await http.get(
        Uri.parse("https://api.yelp.com/v3/events?latitude=37.786882&longitude=-122.399972"),
        headers: {
          "Authorization": FlutterConfig.get('YELP_AUTH_KEY')
        }
    );
    return jsonDecode(server.body);
  }
}