import 'package:dio/dio.dart';

import '../models/list_units.dart';
import '../models/unit.dart';

class Request {
  // static final String url =
  //     'https://my-json-server.typicode.com/mozzus/demo/card/';
  static String commonUrl;

  static final String url = commonUrl + '/api/v1/photos/check';
  static final String urlCertificateDriver =
      commonUrl + '/api/v1/certificates/check';
  static final String urlCertificateCar =
      commonUrl + '/api/v1/carnumbers/check';
  static final String urlGetDriver = commonUrl + '/api/v1/events/driver/';
  static final String urlGetCar = commonUrl + '/api/v1/events/car/';
  static final String urlGet10 = commonUrl + '/api/v1/events?limit=10&offset=0';

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
      // print(photo);
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

  static Future<CardUnit> getCurrentDriverCard(String idOnServer) async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGetDriver + idOnServer);
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<CardUnit> getCurrentCarCard(String idOnServer) async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGetCar + idOnServer);
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<CardUnit> postQRCertificateDriver(
      String certificate, String direction) async {
    try {
      var dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
      Response response = await dio.post(urlCertificateDriver,
          data: {"certificate": certificate, "direction-type": direction});
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  static Future<CardUnit> postQRCertificateCarNumber(
      String certificate, String direction) async {
    try {
      var dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
      Response response = await dio.post(urlCertificateCar,
          data: {"number": certificate, "direction-type": direction});
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
