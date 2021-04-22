import 'package:dio/dio.dart';

import 'models/list_units.dart';
import 'models/unit.dart';

class Request {
  // static final String url =
  //     'https://my-json-server.typicode.com/mozzus/demo/card/';

  static final String url = 'http://21f6d3a05767.ngrok.io/api/v1/photos/check';
  static final String urlGet10 =
      'http://21f6d3a05767.ngrok.io/api/v1/events?limit=10&offset=0';

  static Future<CardUnit> postCardInformation(String type, String direction,
      [String photo]) async {
    try {
      var dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
      // dio.options.headers['Content-Type'] = "application/json";
      // dio.options.headers['accept'] = "application/json";
      Response response = await dio.post(url, data: {
        "photo": photo,
        "object-type": type,
        "direction-type": direction
      });
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  static Future<ListUnits> get10cards() async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGet10);
      print(response.data);
      return ListUnits.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<CardUnit> getCurrentCard(String idOnServer) async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGet10 + idOnServer);
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }
}
