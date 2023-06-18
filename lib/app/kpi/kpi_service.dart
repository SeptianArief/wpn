import 'dart:convert';

import 'package:dashboard_wpn/app/kpi/kpi_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:http/http.dart' as http;

class KPIService {
  static Future<ApiReturnValue> deleteKPI({
    required String id,
  }) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/delete_kpi.php";

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

  static Future<ApiReturnValue> fetchKPI() async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/fetch_kpi.php";

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
          List<KPI> data = [];

          var dataRaw = json.decode(response.body);

          for (var i = 0; i < dataRaw['data'].length; i++) {
            data.add(KPI.fromJson(dataRaw['data'][i]));
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

  static Future<ApiReturnValue> createKPI(
      {required String id,
      required String name,
      required String reqruitmentTime,
      required String evaluationTime,
      required String pelatihanTime,
      required String produktivitas,
      required String kepuasan,
      required String kpiDate,
      required String idpReady,
      required String idpStart}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/create_kpi.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['name'] = name;
    request.fields['id_karyawan'] = id;
    request.fields['requitment_time'] = reqruitmentTime;
    request.fields['evaluation_time'] = evaluationTime;
    request.fields['pelatihan_time'] = pelatihanTime;
    request.fields['kenaikan_produktivitas'] = produktivitas;
    request.fields['kepuasan'] = kepuasan;
    request.fields['kpi_date'] = kpiDate;
    request.fields['idp_ready'] = idpReady;
    request.fields['idp_start'] = idpStart;

    print('masukk');

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

  static Future<ApiReturnValue> updateKPI(
      {required String id,
      required String idFinal,
      required String name,
      required String reqruitmentTime,
      required String evaluationTime,
      required String pelatihanTime,
      required String produktivitas,
      required String kepuasan,
      required String kpiDate,
      required String idpReady,
      required String idpStart}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/update_kpi.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['name'] = name;
    request.fields['id_karyawan'] = id;
    request.fields['requitment_time'] = reqruitmentTime;
    request.fields['evaluation_time'] = evaluationTime;
    request.fields['pelatihan_time'] = pelatihanTime;
    request.fields['kenaikan_produktivitas'] = produktivitas;
    request.fields['kepuasan'] = kepuasan;
    request.fields['kpi_date'] = kpiDate;
    request.fields['idp_ready'] = idpReady;
    request.fields['idp_start'] = idpStart;
    request.fields['id'] = idFinal;

    print('masukk');

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
