import 'dart:convert';

import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<ApiReturnValue> login({
    required String username,
    required String password,
  }) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/login.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['username'] = username;
    request.fields['password'] = password;

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

  static Future<ApiReturnValue> deleteUser({
    required String id,
  }) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/delete_user.php";

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

  static Future<ApiReturnValue> fetchUser() async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/fetch_user.php";

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
          List<UserModel> data = [];

          var dataRaw = json.decode(response.body);

          for (var i = 0; i < dataRaw['data'].length; i++) {
            data.add(UserModel.fromJson(dataRaw['data'][i]));
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

  static Future<ApiReturnValue> registyer(
      {required String username,
      required String password,
      String isActive = '0',
      required String name}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/register.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['username'] = username;
    request.fields['password'] = password;
    request.fields['name'] = name;
    request.fields['is_active'] = isActive;

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

  static Future<ApiReturnValue> udpateUser(
      {required String username,
      required String password,
      required String id,
      String isActive = '0',
      required String name}) async {
    ApiReturnValue apiReturnValue;

    String url = "${baseUrl}API/update_user.php";

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.fields['username'] = username;
    request.fields['id'] = id;

    if (password.isNotEmpty) {
      request.fields['password'] = password;
    }
    request.fields['name'] = name;
    request.fields['is_active'] = isActive;

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
