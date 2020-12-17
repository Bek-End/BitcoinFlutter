import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{
  final String url;
  static const String public_key = "MDVkNzRiY2I4OWZjNGY4YTllMjYyMmRhOGQxMTVhYmE";
  Networking(this.url);

  Future<dynamic> getData() async {
    http.Response response = await http.get(url,headers: {'x-ba-key': public_key});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)['last'];
    } else {
      print(response.statusCode);
    }
  }
}