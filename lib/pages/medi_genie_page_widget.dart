// import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_util.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/inappBrowserManager.dart';
import 'package:medi_genie/manager/uiManager.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
export '../model/medi_genie_page_model.dart';

class MediGeniePageWidget extends StatefulWidget {
  const MediGeniePageWidget({super.key});

  @override
  _MediGeniePageWidgetState createState() => _MediGeniePageWidgetState();
}

class _MediGeniePageWidgetState extends State<MediGeniePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  var _selectPage = 0;

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => MediGeniePageModel());
  }

  @override
  void dispose() {
    //_model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    DataManager dm = DataManager.getInstance();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0x00ECEEF0),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: const AlignmentDirectional(-1.0, 0.0),
            child: Text(
              'MediGenie',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            Strings.appTodayFeeling.tr(),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).displayLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  child: Container(
                    width: double.infinity,
                    height: 46.0,
                    decoration: const BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  print('Button pressed ...');
                                  // AudioPlayer audioPlayer = AudioPlayer();
                                  // audioPlayer.setSource(AssetSource('audios/2000Hz_R.mp3'));
                                  // audioPlayer.play(AssetSource('audios/2000Hz_R.mp3'));
                                },
                                text: '🧑‍ ${Strings.appAll.tr()}',
                                options: FFButtonOptions(
                                  elevation: 0.0,
                                  width: 86.0,
                                  height: 46.0,
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                      ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: '👂 ${Strings.appEarNoseThroat.tr()}',
                                  options: FFButtonOptions(
                                    elevation: 0.0,
                                    width: 164.0,
                                    height: 46.0,
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).labelMedium,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 391.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                              ),
                              height: double.infinity,
                              child: Swiper(
                                loop: false,
                                index: _selectPage,
                                onTap: (index) async {
                                  _selectPage = index;
                                  //await DataManager.getInstance().dignosisDataLoading(dm.),
                                  UIManager.getInstance().clearCurrentDiagnosis();
                                  // 진단 전체 데이터 저장
                                  UIManager.getInstance().currentDiagnosis!.diagnosisId = dm.getRecommandModel(index).diagnosis!.id;
                                  // json 진단 데이터 불러오기
                                  await dm.dignosisDataLoading(
                                    context,
                                    dm.getRecommandModel(index).diagnosis!.jsonLink!,
                                    dm.getRecommandModel(index).diagnosis!.diagnosisCategory!,
                                    dm.getRecommandModel(index).diagnosis!.subject!,
                                  );
                                  // monet brain 사이트 일때 브라우저로 이동
                                  if (dm.getRecommandModel(index).diagnosis!.jsonLink!.contains('monetbrain')) {
                                    InAppBrowserManager.getInstance().openBrowser(url: dm.getRecommandModel(index).diagnosis!.jsonLink!);
                                    // comingsoon 일때 준비중 알림
                                  } else if (dm.getRecommandModel(index).diagnosis!.jsonLink!.contains('comingsoon')) {
                                    UIManager.getInstance().alertOneButtonShow(
                                      context,
                                      Strings.appComingTitle.tr(),
                                      Strings.appComingDec.tr(),
                                      'Okey',
                                      () => null,
                                    );
                                    // json 파일 불러와서 진단 페이지로 이동
                                  } else {
                                    await context.pushNamed('DiagnosisTestPage', queryParameters: {
                                      'heroRecommandIndex': '$index',
                                      'selectDiagnosisIndex': '${dm.getRecommandModel(index).diagnosis!.id}',
                                      'selectDiagnosisCategory': '${dm.getRecommandModel(index).diagnosis!.diagnosisCategory}',
                                      'selectDiagnosisSubject': '${dm.getRecommandModel(index).diagnosis!.subject}',
                                    });
                                  }
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Hero(
                                          tag: index,
                                          child: Image.asset(
                                            'assets/images/img_card_${dm.getRecommandModel(index).diagnosis?.diagnosisCategory}.png',
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SizedBox(
                                            width: 230,
                                            height: double.infinity,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 230,
                                                  child: Text(
                                                    '${dm.getRecommandModel(index).title}'.tr(),
                                                    textAlign: TextAlign.left,
                                                    style: FlutterFlowTheme.of(context).displaySmall,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                SizedBox(
                                                  width: 230,
                                                  child: Text(
                                                    '${dm.getRecommandModel(index).diagnosis?.diagnosisDuration} ${Strings.appMinute.tr()}',
                                                    textAlign: TextAlign.left,
                                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 230,
                                          height: double.infinity,
                                          margin: const EdgeInsetsDirectional.fromSTEB(20.0, 250.0, 20.0, 0.0),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: DataManager.getInstance().getRecommandModelLength(),
                                viewportFraction: 0.75,
                                scale: 0.75,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void onClickDiagnosis(int index) {
    print(index);
  }
}
