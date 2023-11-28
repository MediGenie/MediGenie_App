import 'package:flutter/services.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/backend/api_requests/api_manager.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/model/user_model.dart';
import 'package:medi_genie/pages/diagosis_page_widget.dart';
import 'package:medi_genie/pages/medi_genie_page_widget.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:medi_genie/manager/socialManager.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashPageWidget extends StatefulWidget {
  const SplashPageWidget({super.key});

  @override
  _SplashPageWidgetState createState() => _SplashPageWidgetState();
}

class _SplashPageWidgetState extends State<SplashPageWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? _deviceId;
  Future<void> initPlatformState() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      DataManager.getInstance().deviceId = deviceId;
      logger.d(deviceId);
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    final response = await PostGeustLoginCall.call(udid: deviceId);
    if (response.succeeded) {
      var responseJson = await jsonDecode(response.response?.body ?? "")['jwt'];
      var userResponse = await jsonDecode(response.response?.body ?? "")['user'];
      DataManager.getInstance().userModel = UserModel.fromJson(userResponse);
      ApiManager.setToken(responseJson);
      print(responseJson);
      // print(DataManager.getInstance().userModel?.id);
      // print(DataManager.getInstance().userModel?.isFirst);
    }

    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }

  Future<void> homeInfoLoad(bool isSuccess) async {
    DataManager dm = DataManager.getInstance();
    print('homeInfoLoad start');
    try {
      print('homeInfoLoad start -- 2');
      final response = await GetHomeCall.call();
      print('homeInfoLoad start -- 3 => ${response.succeeded}');
      if (response.succeeded) {
        print('homeInfoLoad start -- 4');
        final List<dynamic> recommandsResponse = await jsonDecode(response.response?.body ?? "")['recommends'];
        logger.d(recommandsResponse);
        for (var info in recommandsResponse) {
          dm.recommandModels.add(MediGeniePageModel.fromJson(info));
        }
        var diagnosisResponse = await jsonDecode(response.response?.body ?? "")['diagnoses'];
        logger.d(diagnosisResponse);
        Iterable<String> keys = diagnosisResponse.keys;
        for (String key in keys) {
          List<dynamic> department = [];
          var diagnosisCategoryResponse = jsonDecode(response.response?.body ?? "")['diagnoses'][key];
          for (var diagnosis in diagnosisCategoryResponse) {
            department.add(DiagosisPageModel.fromJson(diagnosis));
            logger.d(diagnosis);
          }
          List<DiagosisPageModel> diagosisPageModels = [];
          diagosisPageModels = department.cast<DiagosisPageModel>();
          dm.diagosisModels[key] = diagosisPageModels;
        }
        await dm.getMyInfo();
        if (DataManager.getInstance().userModel?.isFirst ?? false) {
          context.goNamed(
            'OnboardingPage',
          );
        } else {
          context.goNamed(
            'MediGeniePage',
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> diagnosisJsonDataLoad() async {
    String diagnosisFromJsonFile = await rootBundle.loadString('assets/json/all.json');
    final jsonResponse = jsonDecode(diagnosisFromJsonFile);

    final startMenuJson = jsonResponse['startmenu'];
    for (String title in startMenuJson) {
      DataManager.getInstance().startMenu.add(title);
    }

    var diagnosisDataResponse = jsonResponse['testflow'];
    Iterable keys = diagnosisDataResponse.keys;

    for (String key in keys) {
      DataManager.getInstance().diagnosisTestData[key] = diagnosisDataResponse[key];
    }

    logger.d(jsonResponse);
  }

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      bool isLogin = await SocialManager.getInstance().isSocialLogin();
      print("isLogin->$isLogin");
      if (!isLogin) {
        await initPlatformState();
        await homeInfoLoad(false);
      } else {
        await SocialManager.getInstance().socailLogin(callback: homeInfoLoad);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1E2429),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF222222),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/aiplaza.png',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
