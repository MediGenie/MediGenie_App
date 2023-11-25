import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/model/testing_model.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';
const _kPrivateApiUrl = 'https://api.aiplaza.kr/api';

class PostGeustLoginCall {
  static Future<ApiCallResponse> call({
    String? udid,
  }) {
    final body = '''
              {
                "uuid": "$udid"
              }''';
    return ApiManager.instance.makeApiCall(
      callName: 'postGeustLogin',
      apiUrl: '$_kPrivateApiUrl/guests/new',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PutGeustUpdateCall {
  static Future<ApiCallResponse> call({
    List<String>? interests,
  }) {
    final body = '''
              {
                "interests": $interests
              }''';
    print(body);
    return ApiManager.instance.makeApiCall(
      callName: 'postGeustUpdate',
      apiUrl: '$_kPrivateApiUrl/guests/me',
      callType: ApiCallType.PUT,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetGoogleLoginCall {
  static Future<ApiCallResponse> call({
    String? token,
  }) {
    return ApiManager.urlRequest(
      ApiCallType.GET,
      '$_kPrivateApiUrl/auth/google/callback',
      {},
      {'access_token': token},
      false,
      false,
    );
  }
}

class GetAppleLoginCall {
  static Future<ApiCallResponse> call({dynamic code, dynamic email}) {
    final body = '''
{
  "access_token": "$code",
  "email": "$email"
}''';
    logger.d(body);
    return ApiManager.instance.makeApiCall(
      callName: 'postGeustLogin',
      apiUrl: '$_kPrivateApiUrl/apple/callback',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PostGuestMergeCall {
  static Future<ApiCallResponse> call({dynamic code, dynamic uuid}) {
    final body = '''
{
  "access_token": "$code",
  "email": "$uuid"
}''';
    logger.d(body);
    return ApiManager.instance.makeApiCall(
      callName: 'postGeustLogin',
      apiUrl: '$_kPrivateApiUrl/guests/merge',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetHomeCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getHome',
      apiUrl: '$_kPrivateApiUrl/home',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetMeCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getMe',
      apiUrl: '$_kPrivateApiUrl/users/me',
      callType: ApiCallType.GET,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PutUserCall {
  static Future<ApiCallResponse> call(Map<String, dynamic> userInfo) {
    final body = '''{
      "gender": "${userInfo['gender']}",
      "serviceAgreedDate": "${userInfo['serviceAgreedDate']}",
      "privacyPolicyAgreedDate": "${userInfo['privacyPolicyAgreedDate']}",
      "birthDate": "${userInfo['birthDate']}"
    }''';
    logger.d(body);
    return ApiManager.instance.makeApiCall(
      callName: 'putUserInfo',
      apiUrl: '$_kPrivateApiUrl/users/${DataManager.getInstance().userModel!.id}',
      callType: ApiCallType.PUT,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PostImageUploadCall {
  static Future<dynamic> call(dynamic body) async {
    var dio = Dio();
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.headers['authorization'] = 'Bearer ${ApiManager.accessToken ?? ''}';
      dio.options.maxRedirects.isFinite;
      var response = await dio.post(
        '$_kPrivateApiUrl/images/upload',
        data: body,
      );
      print('성공적으로 업로드했습니다');
      logger.d(response.data);
      List<String> imageUrls = [];
      response.data.forEach((element) {
        imageUrls.add('"${element['url']}"');
      });
      return imageUrls;
    } catch (e) {
      print('업로드 실패');
      print(e);
    }
  }
}

class PostDiagnosisResultCall {
  static Future<ApiCallResponse> call(MedigenieAIResultServerModel info) {
    final String body;
    if (DataManager.getInstance().isLogin) {
      body = '''{
      "diagnosisId": "${info.diagnosisId}",
      "data": ${info.historyTakingData},
      "images": ${info.images.isEmpty ? '""' : info.images},
      "earPos": "${info.earPos}",
      "average": ${info.convertAverage()},
      "right": ${info.convertRight()},
      "left": ${info.convertLeft()},
      "memberId": ${info.memberId}
    }''';
    } else {
      body = '''{
      "uuid": "${DataManager.getInstance().deviceId}",
      "diagnosisId": "${info.diagnosisId}",
      "data": ${info.historyTakingData},
      "images": ${info.images.isEmpty ? '""' : info.images},
      "earPos": "${info.earPos}",
      "average": ${info.convertAverage()},
      "right": ${info.convertRight()},
      "left": ${info.convertLeft()},
      "memberId": ${info.memberId}
    }''';
    }

    //print(body);
    logger.d(body);
    return ApiManager.instance.makeApiCall(
      callName: 'putUserInfo',
      apiUrl: '$_kPrivateApiUrl/diagnosis/${info.diagnosisId}',
      callType: ApiCallType.POST,
      headers: {
        'content-type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PostResultGPTCall {
  static Future<ApiCallResponse> call({
    int? resultId,
    int? diagnosisId,
  }) {
    final body = '''
              {
                "diagnosisResultId": $resultId
              }''';
    return ApiManager.instance.makeApiCall(
      callName: 'postGPTResultLogin',
      apiUrl: '$_kPrivateApiUrl/diagnosis/$diagnosisId/ai',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class PostChildAddCall {
  static Future<ApiCallResponse> call({
    String? type,
    String? name,
    String? birthDate,
    String? gender,
  }) {
    final body = '''
    {
      "type": "$type",
      "name": "$name",
      "birthDate": "$birthDate",
      "gender": "$gender"
    }''';
    logger.d(body);
    return ApiManager.instance.makeApiCall(
      callName: 'postChildAddLogin',
      apiUrl: '$_kPrivateApiUrl/family/members/add',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

String _classToJson<T>() {
  return T.toString().split("'")[1];
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() => 'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
