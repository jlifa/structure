import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


const test = 'https://tawrid.store/api/v1';
const live = 'https://portal.tawrid.net/api/v1';
String url = getUrl();
var token = '';

String getUrl(){
  if (kDebugMode){
    return live;
  }
  return live;
}


Future<Map<String, dynamic>?> callApiGet(String path) async {

  final headers = {
    "Accept": "application/json",
    "content-type":"application/json",
    'Authorization': 'Bearer $token',
    'token': '$token'
  };
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var response = await http.get(Uri.parse('$url/$path'), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
         // Logger().d(response.body,'$url/$path');
        }
        return {'data': response.body, 'ok': true};
      }
      else if (response.statusCode == 400) {
        print(response.statusCode);

        Logger().d(response.body);
        return {'data': response.body, 'ok': false};
      }
      else {
        Logger().e(response.body);
        print(response.statusCode);
        return {'data': response.body, 'ok': false};
      }
    }
  } on SocketException catch (_) {

    // SmartDialog.show(
    //   clickMaskDismiss: false,
    //   backDismiss: false,
    //   builder: (context) => InternetDialog(title: '',tryAgain: (){
    //       SmartDialog.dismiss();
    //       callApiGet(path);
    // }),);
  }
  try {

  } catch (e) {
    if (e is SocketException) {
      SmartDialog.showToast('check_internet'.tr);
      return {'data': null, 'ok': false};
    } else {
      SmartDialog.showToast('went_wrong'.tr);
      print(e.toString());
      return {'data': null, 'ok': false};
    }
  }
  return null;
}

Future<Map<String, dynamic>?> callApiPost(
    Map<String, dynamic> body,
    String path,
    {String? myUrl}
    ) async {
  final headers = {
    "Accept": "application/json",
    "content-type":"application/json",
    'Authorization': 'Bearer $token',
    'token': '$token',
    'SERIAL-NUMBER': '',

  };
  try {
    var response = await http.post(Uri.parse(myUrl??'$url/$path'), body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      Logger().d(response.body);
      return {'data': response.body, 'ok': true};
    }
    else {
      Logger().e(response.body);
      print(response.statusCode);
      return {'data': response.body, 'ok': false};
    }
  } catch (e) {
    if (e is SocketException) {
      SmartDialog.showToast('check_internet'.tr);
    } else {
      SmartDialog.showToast('went_wrong'.tr);
      print(e.toString());
    }
    return {'data': null, 'ok': false};
  }
}

Future<Map<String, dynamic>?> callApiDelete(
    String path,
    ) async {
  final headers = {
    "Accept": "application/json",
    "content-type":"application/json",
    'Authorization': 'Bearer $token'
  };
  try {
    var response = await http.delete(Uri.parse('$url/$path'), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(response.body);
      print(response.statusCode);
      print(response.body);
      return {'data': response.body, 'ok': true};
    } else {
      // print(response.body);
      print(response.statusCode);
      return {'data': response.body, 'ok': false};
    }
  } catch (e) {
    if (e is SocketException) {
      SmartDialog.showToast('check_internet'.tr);
    } else {
      SmartDialog.showToast('went_wrong'.tr);
      print(e.toString());
    }
    return {'data': null, 'ok': false};
  }
}

void setLoading(RxBool isLoading) {
  isLoading(!isLoading.value);
}