import 'dart:convert';
import 'package:http/http.dart' as http;

class YelpApi{
  getRestaurantNearMe() async {
    var server= await http.get(
      Uri.parse("https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972"),
      headers: {
        "Authorization":"Bearer r859n5rZrOZrqKyO64k6FEXfe9vZNQrqEcJsRPYtYHMG7ON33hz3lNnUbHEnmsKnrMyVRQiMieiLPfKR8frm3b3UnzMdT7HSeplgA3iNTvV17IAFO1MRUUOrb_alYHYx"
      }
    );
    return jsonDecode(server.body);
  }

  getRestaurantByFilter(term,price,distance) async {
    var server= await http.get(
        Uri.parse("https://api.yelp.com/v3/businesses/search?term=$term&latitude=37.786882&longitude=-122.399972&price=$price&radius=$distance"),
        headers: {
          "Authorization":"Bearer r859n5rZrOZrqKyO64k6FEXfe9vZNQrqEcJsRPYtYHMG7ON33hz3lNnUbHEnmsKnrMyVRQiMieiLPfKR8frm3b3UnzMdT7HSeplgA3iNTvV17IAFO1MRUUOrb_alYHYx"
        }
    );
    return jsonDecode(server.body);
  }

  getEvent() async {
    var server= await http.get(
        Uri.parse("https://api.yelp.com/v3/events?latitude=37.786882&longitude=-122.399972"),
        headers: {
          "Authorization":"Bearer r859n5rZrOZrqKyO64k6FEXfe9vZNQrqEcJsRPYtYHMG7ON33hz3lNnUbHEnmsKnrMyVRQiMieiLPfKR8frm3b3UnzMdT7HSeplgA3iNTvV17IAFO1MRUUOrb_alYHYx"
        }
    );
    return jsonDecode(server.body);
  }
}