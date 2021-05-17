import 'package:dio/dio.dart';

import '../models/list_units.dart';
import '../models/unit.dart';

class Request {
  static String commonUrl;

  static String baseUrl;
  static String urlCertificateDriver;
  static String urlCertificateCar;
  static String urlGetDriver;
  static String urlGetCar;
  static String urlGet10;

  static void setCommonUrl(String url) {
    baseUrl = url + '/api/v1/photos/check';
    urlCertificateCar = url + '/api/v1/carnumbers/check';
    urlGetDriver = url + '/api/v1/events/driver/';
    urlGetCar = url + '/api/v1/events/car/';
    urlGet10 = url + '/api/v1/events?limit=10&offset=0';
  }

  static Future<CardUnit> postCardInformation(String type, String direction,
      [String photo]) async {
    try {
      var dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
      Response response = await dio.post(baseUrl, data: {
        "photo": photo,
        "object-type": type,
        "direction-type": direction
      });
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  static Future<ListUnits> get10cards() async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGet10);
      return ListUnits.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<CardUnit> getCurrentDriverCard(String idOnServer) async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGetDriver + idOnServer);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  static Future<CardUnit> getCurrentCarCard(String idOnServer) async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGetCar + idOnServer);
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
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
