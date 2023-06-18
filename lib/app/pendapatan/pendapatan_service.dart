import 'dart:convert';

import 'package:dashboard_wpn/app/pendapatan/pendapatan_model.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_model.dart';
import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:http/http.dart' as http;

class PendapatanService {
  static Future<ApiReturnValue> deletePendapatan({
    required String id,
  }) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/delete_penjualan.php";

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

  static Future<ApiReturnValue> fetchPendapatan() async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/fetch_pendapatan.php";

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
          List<Penjualan> data = [];

          var dataRaw = json.decode(response.body);

          for (var i = 0; i < dataRaw['data'].length; i++) {
            data.add(Penjualan.fromJson(dataRaw['data'][i]));
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

  static Future<ApiReturnValue> createPengeluaran(
      {required String total,
      required String notes,
      required String tanggal,
      required String pembeli,
      required String jumlah}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/create_penjualan.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['total'] = total;
    request.fields['notes'] = notes;
    request.fields['tanggal'] = tanggal;
    request.fields['pembeli'] = pembeli;
    request.fields['jumlah'] = jumlah;

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

  static Future<ApiReturnValue> updatePengeluaran(
      {required String id,
      required String total,
      required String notes,
      required String tanggal,
      required String pembeli,
      required String jumlah}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/update_penjualan.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['total'] = total;
    request.fields['notes'] = notes;
    request.fields['tanggal'] = tanggal;
    request.fields['pembeli'] = pembeli;
    request.fields['jumlah'] = jumlah;
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
