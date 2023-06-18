import 'dart:convert';

import 'package:dashboard_wpn/app/karyawan/karyawan_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:http/http.dart' as http;

class KaryawanService {
  static Future<ApiReturnValue> deleteKaryawan({
    required String id,
  }) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/delete_karyawan.php";

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

  static Future<ApiReturnValue> fetchKaryawan() async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/fetch_karyawan.php";

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
          List<KaryawanModel> data = [];

          var dataRaw = json.decode(response.body);

          for (var i = 0; i < dataRaw['data'].length; i++) {
            data.add(KaryawanModel.fromJson(dataRaw['data'][i]));
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

  static Future<ApiReturnValue> createKaryawan(
      {required String name,
      required String division,
      required String position,
      required String status,
      required String nik,
      required String tempatLahir,
      required String startWork,
      required String pendidikan,
      required String agama,
      required String familyStatus,
      required String keterangan,
      required String tanggalLahir}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/create_karyawan.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['name'] = name;
    request.fields['division'] = division;
    request.fields['position'] = position;
    request.fields['status'] = status;
    request.fields['nik'] = nik;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['start_work'] = startWork;
    request.fields['pendidikan'] = pendidikan;
    request.fields['agama'] = agama;
    request.fields['family_status'] = familyStatus;
    request.fields['keterangan'] = keterangan;
    request.fields['tanggal_lahir'] = tanggalLahir;

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

  static Future<ApiReturnValue> updateKaryawan(
      {required String name,
      required String id,
      required String division,
      required String position,
      required String status,
      required String nik,
      required String tempatLahir,
      required String startWork,
      required String pendidikan,
      required String agama,
      required String familyStatus,
      required String keterangan,
      required String tanggalLahir}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/update_karyawan.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['name'] = name;
    request.fields['division'] = division;
    request.fields['position'] = position;
    request.fields['status'] = status;
    request.fields['nik'] = nik;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['start_work'] = startWork;
    request.fields['pendidikan'] = pendidikan;
    request.fields['agama'] = agama;
    request.fields['family_status'] = familyStatus;
    request.fields['keterangan'] = keterangan;
    request.fields['tanggal_lahir'] = tanggalLahir;
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
