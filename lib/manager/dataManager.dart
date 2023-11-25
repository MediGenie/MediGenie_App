import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/testing_model.dart';
import 'package:medi_genie/model/user_model.dart';
import 'package:medi_genie/pages/diagosis_page_widget.dart';
import 'package:medi_genie/pages/medi_genie_page_widget.dart';
import 'package:path_provider/path_provider.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 3,
    errorMethodCount: 8,
    lineLength: 8096,
    colors: true,
    printEmojis: false,
    printTime: false,
  ),
);

enum DiagnosisEnum {
  HISTORY_TAKING('historytaking', 'QuestionPage'),
  ADD_PHOTO('addphoto', 'AddPhotoPage'),
  HEARING_TEST('hearingtest', 'HearingTestPage'),
  RESULT('results', 'TestResultPage');

  final String value, pageName;

  const DiagnosisEnum(this.value, this.pageName);

  static String getPageName(String value) {
    for (DiagnosisEnum item in DiagnosisEnum.values) {
      if (item.value == value) {
        return item.pageName;
      }
    }
    return '';
  }
}

enum GenderEnum {
  MALE('MALE'),
  FEMALE('FEMALE'),
  OTHER('OTHER');

  final String value;

  const GenderEnum(this.value);
}

enum AgeEnum {
  TEENAGER('TEENAGER'),
  YOUNG_ADULT('YOUNG_ADULT'),
  OLDER_ADULT('OLDER_ADULT'),
  SENIOR('SENIOR');

  final String value;

  const AgeEnum(this.value);
}

enum InterestEnum {
  HEALTH_STATE('HEALTH_STATE'),
  HEALTH_MANAGEMENT('HEALTH_MANAGEMENT'),
  HEALTH_CHECKUP_RECORDS('HEALTH_CHECKUP_RECORDS'),
  HEALTH_INFO_RECOMMENDATIONS('HEALTH_INFO_RECOMMENDATIONS');

  final String value;

  const InterestEnum(this.value);
}

class DataManager {
  static final DataManager _instance = DataManager._internal();
  factory DataManager() => _instance;
  DataManager._internal();

  // UUID - DeviceID
  String? deviceId;

  // 로그인 여부
  bool isLogin = false;
  // 로그인한 유저 정보 데이터
  UserModel? userModel;
  // MediGenie 홈 카드 데이터
  List<MediGeniePageModel> recommandModels = [];
  // Diagnosis 진단 리스트 데이터 string - category name, list - category data
  Map<String, List<DiagosisPageModel>> diagosisModels = {};
  // 진단시 진행되는 시작 메뉴 데이터
  List<String> startMenu = [];

  // 진단시 진행되는 전체 진단 데이터
  Map<String, dynamic> diagnosisTestData = {};

  static DataManager getInstance() {
    return _instance;
  }

  // 홈 카드 데이터 인덱스에 맞는 데이터 가져오기
  MediGeniePageModel getRecommandModel(int index) {
    return recommandModels[index];
  }

  int getRecommandModelLength() {
    return recommandModels.length;
  }

  DiagosisPageModel getDiagosisModel(String department, int index) {
    DiagosisPageModel returnModel = DiagosisPageModel();
    for (DiagosisPageModel model in diagosisModels[department]!) {
      if (model.id == index) {
        returnModel = model;
      }
    }
    return returnModel;
  }

  int getDiagosisModelLength() {
    return diagosisModels.length;
  }

  // 다음 진단 페이지 이름 가져오기
  String getNextDiagnosisPageName(int currentIndex) {
    String pageName = 'MediGeniePage';
    diagnosisTestData.forEach((key, value) {
      if (value[0]['index'] == currentIndex + 1) {
        pageName = DiagnosisEnum.getPageName(key);
      }
    });
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $pageName');
    return pageName;
  }

  // 진단 json 링크 가져오기
  String getDiagnosisJsonUrl(int index) {
    String url = '';
    diagnosisTestData.forEach((key, value) {
      if (value[0]['index'] == index) {
        url = value[0]['url'];
      }
    });
    return url;
  }

  // 진단 json 데이터 서버에서 가져오기 - 폴더와 파일 이름에 locale 적용
  Future<bool> dignosisDataLoading(BuildContext context, String url,
      String department, String subject) async {
    bool isLoaded = false;
    String contextLocal = context.deviceLocale.toString();
    String locale = contextLocal.substring(3, 5);
    //String _localeLang = _context.locale.languageCode;

    logger.d('deviceLocale: $locale');
    //logger.d('localeLang: $_localeLang');
    startMenu.clear();
    diagnosisTestData.clear();
    String ageGruop, uri = '';
    if (department == 'child') {
      ageGruop = getChildDateToAgeGruop(
          getMemberBirth(UIManager.getInstance().currentDiagnosis!.memberId!));
    } else {
      ageGruop = getDateToAgeGruop(
          getMemberBirth(UIManager.getInstance().currentDiagnosis!.memberId!));
    }
    uri = '$url$locale/${subject}_${ageGruop}_$locale.json';
    logger.d('diagnosis json url: $uri');

    try {
      Dio dio = Dio();
      String fileName = uri.substring(uri.lastIndexOf('/') + 1);
      String savePath = await getFilePath(fileName);
      await dio.download(
        uri,
        savePath,
        onReceiveProgress: (rec, total) {
          isLoaded = true;
          String diagnosisFromJsonFile = File(savePath).readAsStringSync();
          final jsonResponse = jsonDecode(diagnosisFromJsonFile);

          final startMenuJson = jsonResponse['startmenu'];
          for (String title in startMenuJson) {
            startMenu.add(title);
          }

          var diagnosisDataResponse = jsonResponse['testflow'];
          Iterable keys = diagnosisDataResponse.keys;

          for (String key in keys) {
            diagnosisTestData[key] = diagnosisDataResponse[key];
          }

          print(jsonResponse);
        },
      );
    } catch (e) {}

    return isLoaded;
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  MedigenieAIResultServerModel setTempData() {
    MedigenieAIResultServerModel data = MedigenieAIResultServerModel();

    data.diagnosisId = UIManager.getInstance().currentDiagnosis!.diagnosisId;
    data.earPos = UIManager.getInstance().currentDiagnosis!.earPos;
    data.historyTakingData =
        UIManager.getInstance().currentDiagnosis!.historyTakingData;
    data.setAverage(right: 30, left: 30);
    data.setRight(frequncy: 500, volume: 30);
    data.setRight(frequncy: 1000, volume: 30);
    data.setRight(frequncy: 2000, volume: 30);
    data.setRight(frequncy: 4000, volume: 30);
    data.setLeft(frequncy: 500, volume: 30);
    data.setLeft(frequncy: 1000, volume: 30);
    data.setLeft(frequncy: 2000, volume: 30);
    data.setLeft(frequncy: 4000, volume: 30);
    // List<String> images = [
    //   '"https://medigenie-images.s3.ap-northeast-2.amazonaws.com/21_testtesttest_testtesttest%40guest.com/IMG_7483_534670065c.png"'
    // ];
    data.images = UIManager.getInstance().currentDiagnosis!.images;
    data.memberId = UIManager.getInstance().currentDiagnosis!.memberId;

    return data;
  }

  String getHTDataToString({required Map<int, Map<String, String>> data}) {
    List<Map<String, String>> listData = [];
    data.forEach((key, value) {
      listData.add(value);
    });
    String historyTakingSave = json.encode(listData);

    logger.d(historyTakingSave);
    return historyTakingSave;
  }

  String getDiagnosisIdToSubject(int id) {
    String subject = '';
    diagosisModels.forEach(
      (key, value) {
        for (var element in value) {
            if (element.id == id) {
              subject = element.subject!;
            }
          }
      },
    );
    return subject;
  }

  Future<UserModel> getMyInfo({bool isUpdate = false}) async {
    if (userModel == null || isUpdate) {
      final response = await GetMeCall.call();
      logger.d(response.response?.body);
      if (response.succeeded) {
        final responseJson = await jsonDecode(response.response?.body ?? "");
        userModel = UserModel.fromJson(responseJson);
        return userModel!;
      } else {
        return UserModel();
      }
    }
    return userModel!;
  }

  int getDateToAge(String date) {
    int age = 0;
    if (date.isNotEmpty) {
      int year = int.parse(date.substring(0, 4));
      int month = int.parse(date.substring(5, 7));
      int day = int.parse(date.substring(8, 10));
      DateTime now = DateTime.now();
      int nowYear = now.year;
      int nowMonth = now.month;
      int nowDay = now.day;
      age = nowYear - year;
      if (nowMonth < month) {
        age--;
      } else if (nowMonth == month) {
        if (nowDay < day) {
          age--;
        }
      }
      if (age <= 0) {
        int monthAge = nowMonth - month;
        if (nowDay < day) {
          monthAge--;
        }
        age = -monthAge;
      }
    }
    return age;
  }

  String getDateToAgeGruop(String date) {
    String ageGroup = 'teenager';
    int age = getDateToAge(date);
    if (age < 18) {
      ageGroup = 'teenager';
    } else if (age < 69) {
      ageGroup = 'adult';
    } else {
      ageGroup = 'senior';
    }
    return ageGroup;
  }

  String getChildDateToAgeGruop(String date) {
    String ageGroup = 'child';
    int age = getDateToAge(date);
    if (age < 1 && age >= -3) {
      ageGroup = 'newborn';
    } else if (age < 1 && age > -12) {
      ageGroup = 'infant';
    } else if (age < 6) {
      ageGroup = 'preschooler';
    } else if (age < 15) {
      ageGroup = 'child';
    } else {
      ageGroup = 'child';
    }
    return ageGroup;
  }

  String getMemberBirth(int memberId) {
    String birth = '';
    if (userModel != null && memberId != 0) {
      for (var element in userModel!.userFamilyMemberModels!) {
        if (element.id == memberId) {
          birth = element.birthDate!;
        }
      }
    } else {
      birth = userModel!.userPersnalInfoMedel!.birthDate!.toString();
    }
    return birth;
  }

  String getIndexToGender(int genderIndex) {
    String gender = '';

    gender = genderIndex == 1
        ? "MALE"
        : genderIndex == 2
            ? 'FEMALE'
            : 'GENDER_NONE';

    return gender;
  }
}
