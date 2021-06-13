import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProfileData {
  Future fetchProfile() async {
    var result;

    try {
      var response = await http.get(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/crossroad/profile",
        ),
      );

      result = await checkConsent(response.body);

      return result;
    } catch (e) {
      print("ERROR IN PROFILE DATA $e");
    }
  }

  checkConsent(url) async {
    print("inside url $url");
    if (await canLaunch(url)) {
      print("Can launch url");
      await launch(url, forceWebView: true, enableJavaScript: true);
      final response = await http.get(
        Uri.parse(
          "http://127.0.0.1:5000/fitbit/crossroad/profile",
        ),
      );
      print("CHECK CONSENT REPONSE IS ${response.body}");
      return json.decode(response.body);
    } else {
      // if can't launch url, url is a json object
      print("Could not launch url");
      final result = json.decode(url);
      print("CHECK CONSENT RESULT IS ${result}");
      return;
    }
  }
}
