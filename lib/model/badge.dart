import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Badge {
  // fitambaran'ny badge sy ny member ho verification hoe misy ve ilay badge sa tsia
  final String number;
  String? firstname;
  String? lastname;
  String? name;
  String? image;
  String? churchName;

  // Constructor
  Badge(
      {required this.number,
      this.firstname,
      this.lastname,
      this.name,
      this.image,
      this.churchName});

  // from Json factory
  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      number: json['number'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      churchName: json['churchName'] as String,
    );
  }

  static Future<dynamic> fetchBadge(String badgeNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String host = prefs.getString('host') ?? '192.168.43.152:8000';
    try {
      var response = await Dio().get('http://$host/v2api/badges/$badgeNumber');
      if (response.statusCode == 200) {
        Badge badge = Badge.fromJson(response.data);
        if (badge.image != null && badge.image != "") {
          badge.image = 'http://$host/uploads/${badge.image}';
        }
        return badge;
      }
    } on DioError catch (error) {
      if (error.response == null) {
        return ("NETWORK_ERROR");
      } else if (error.response?.statusCode == 404) {
        print(error.response?.data["status"]);
        print("SORRY, BADGE NOT FOUND");
        return ("NOT_FOUND");
      } else {
        print(error);
        return ("OTHER_CONNNECTION_ERROR");
      }
      // throw (error);
    } catch (e) {
      throw e;
      // print(e);
    }
    return null;
  }
}
