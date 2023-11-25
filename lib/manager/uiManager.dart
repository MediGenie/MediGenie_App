import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_theme.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_util.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/model/testing_model.dart';
import 'package:medi_genie/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UIManager {
  static final UIManager _instance = UIManager._internal();
  factory UIManager() => _instance;
  UIManager._internal();

  MedigenieAIResultServerModel? currentDiagnosis;

  static UIManager getInstance() {
    return _instance;
  }

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  void alertOneButtonShow(
    BuildContext context,
    String title,
    String desc,
    String buttonText,
    Function() onPressed,
  ) {
    Alert(
      alertAnimation: fadeAlertAnimation,
      context: context,
      style: FlutterFlowTheme.of(context).alertStyle,
      type: AlertType.none,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          width: 252,
          height: 52,
          radius: BorderRadius.circular(12.0),
          onPressed: () => {
            onPressed(),
            Alert(context: context).dismiss(),
          },
          color: FlutterFlowTheme.of(context).primary,
          child: Text(
            buttonText,
            style: FlutterFlowTheme.of(context).typography.labelLarge.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: FlutterFlowTheme.of(context).tertiaryText,
                ),
          ),
        ),
      ],
    ).show();
  }

  void alertTwoButtonShow(
    BuildContext context,
    String title,
    String desc,
    String oneButtonText,
    String twoButtonText,
    Function() onOnePressed,
    Function onTwoPressed,
  ) {
    Alert(
      alertAnimation: fadeAlertAnimation,
      context: context,
      style: FlutterFlowTheme.of(context).alertStyle,
      type: AlertType.none,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          width: 120,
          height: 52,
          radius: BorderRadius.circular(12.0),
          onPressed: () => {
            onOnePressed(),
            Alert(context: context).dismiss(),
          },
          color: FlutterFlowTheme.of(context).accent1,
          child: Text(
            oneButtonText,
            style: FlutterFlowTheme.of(context).typography.labelLarge.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: FlutterFlowTheme.of(context).primary,
                ),
          ),
        ),
        DialogButton(
          width: 120,
          height: 52,
          radius: BorderRadius.circular(12.0),
          onPressed: () => {
            onTwoPressed(),
            Alert(context: context).dismiss(),
          },
          color: FlutterFlowTheme.of(context).primary,
          child: Text(
            twoButtonText,
            style: FlutterFlowTheme.of(context).typography.labelLarge.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: FlutterFlowTheme.of(context).tertiaryText,
                ),
          ),
        ),
      ],
    ).show();
  }

  void diagnosisLeaveAlert(
    BuildContext context,
  ) {
    alertTwoButtonShow(
      context,
      Strings.appTestStopTitle.tr(),
      Strings.appTestStopDec.tr(),
      Strings.appContinue.tr(),
      Strings.appLeave.tr(),
      () {},
      () {
        context.goNamed('MediGeniePage');
      },
    );
  }

  String getDiagnosisIcon(String subject) {
    String icon = 'diagnosis.png';
    switch (subject) {
      case 'earAll':
        icon = 'diagnosis.png';
        break;
      case 'eardrum':
        icon = 'eardrum.png';
        break;
      case 'hearing':
        icon = 'hearing.png';
        break;
      case 'skinAll':
        icon = 'diagnosis.png';
        break;
      case 'skinPhoto':
        icon = 'diagnosis.png';
        break;
      case 'WeBrain':
        icon = 'webrain.png';
        break;
      case 'CogMap':
        icon = 'cogmap.png';
        break;
    }

    return icon;
  }

  String getPrescriptionToSeverityLevel(List<UserPrescriptions> level) {
    String severityLevel = 'healthy';
    if (level.isNotEmpty) severityLevel = level.first.severityLevel!.toLowerCase();
    return severityLevel;
  }

  String getDateToYearMonthDay(String date) {
    String yearMonthDay = '';
    if (date.isNotEmpty) yearMonthDay = date.substring(0, 10);
    return yearMonthDay;
  }

  // 저장되어 있는 현재 진단 결과 초기화
  void clearCurrentDiagnosis() {
    currentDiagnosis = MedigenieAIResultServerModel();
  }

  void setQuestionData(String data) {}
}
