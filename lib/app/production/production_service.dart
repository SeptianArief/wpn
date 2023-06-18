import 'dart:convert';

import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:http/http.dart' as http;

class ProductionService {
  static Future<ApiReturnValue> deleteProduksi({
    required String id,
  }) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/delete_production.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['id'] = id;

    try {
      final streamSend = await request.send();
      final response = await http.Response.fromStream(streamSend);

      print('--------------response--------------');
      print(response.body);
      print('------------------------------------------');

      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.successRequest, data: null);
        } else {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.failedRequest, data: null);
        }
      } else {
        apiReturnValue =
            ApiReturnValue(data: null, status: RequestStatus.failedRequest);
      }
    } catch (e) {
      print(e);
      apiReturnValue =
          ApiReturnValue(data: null, status: RequestStatus.serverError);
    }

    return apiReturnValue;
  }

  static Future<ApiReturnValue> fetchProduction() async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/fetch_production.php";

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(url),
    );

    try {
      final streamSend = await request.send();
      final response = await http.Response.fromStream(streamSend);

      print('--------------response--------------');
      print(response.body);
      print('------------------------------------------');

      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          List<Production> data = [];

          var dataRaw = json.decode(response.body);

          for (var i = 0; i < dataRaw['data'].length; i++) {
            data.add(Production.fromJson(dataRaw['data'][i]));
          }

          apiReturnValue =
              ApiReturnValue(status: RequestStatus.successRequest, data: data);
        } else {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.failedRequest, data: null);
        }
      } else {
        apiReturnValue =
            ApiReturnValue(data: null, status: RequestStatus.failedRequest);
      }
    } catch (e) {
      print(e);
      apiReturnValue =
          ApiReturnValue(data: null, status: RequestStatus.serverError);
    }

    return apiReturnValue;
  }

  static Future<ApiReturnValue> createProduction(
      {required String tanggal,
      required String totalProduksi,
      required String totalGagal,
      required String totalLahan}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/create_production_data.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['tanggal'] = tanggal;
    request.fields['total_produksi'] = totalProduksi;
    request.fields['total_gagal'] = totalGagal;
    request.fields['total_lahan'] = totalLahan;

    try {
      final streamSend = await request.send();
      final response = await http.Response.fromStream(streamSend);

      print('--------------response--------------');
      print(response.body);
      print('------------------------------------------');

      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.successRequest, data: null);
        } else {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.failedRequest, data: null);
        }
      } else {
        apiReturnValue =
            ApiReturnValue(data: null, status: RequestStatus.failedRequest);
      }
    } catch (e) {
      print(e);
      apiReturnValue =
          ApiReturnValue(data: null, status: RequestStatus.serverError);
    }

    return apiReturnValue;
  }

  static Future<ApiReturnValue> updateProduction(
      {required String id,
      required String tanggal,
      required String totalProduksi,
      required String totalGagal,
      required String totalLahan}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/update_production.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['tanggal'] = tanggal;
    request.fields['total_produksi'] = totalProduksi;
    request.fields['total_gagal'] = totalGagal;
    request.fields['total_lahan'] = totalLahan;
    request.fields['id'] = id;

    try {
      final streamSend = await request.send();
      final response = await http.Response.fromStream(streamSend);

      print('--------------response--------------');
      print(response.body);
      print('------------------------------------------');

      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.successRequest, data: null);
        } else {
          apiReturnValue =
              ApiReturnValue(status: RequestStatus.failedRequest, data: null);
        }
      } else {
        apiReturnValue =
            ApiReturnValue(data: null, status: RequestStatus.failedRequest);
      }
    } catch (e) {
      print(e);
      apiReturnValue =
          ApiReturnValue(data: null, status: RequestStatus.serverError);
    }

    return apiReturnValue;
  }
}
