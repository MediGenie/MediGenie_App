import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:medi_genie/backend/api_requests/api_manager.dart';
import 'package:medi_genie/components/login_popup_widget.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_widgets.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/testing_model.dart';
import 'package:fl_chart/fl_chart.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '../model/question_page_model.dart';
export '../model/question_page_model.dart';

import '../backend/stream_client.dart';

// ignore: must_be_immutable
class TestResultPageWidget extends StatefulWidget {
  String? index;
  String? result;
  TestResultPageWidget({super.key, this.index, this.result});

  @override
  // ignore: library_private_types_in_public_api
  _TestResultPageWidgetState createState() => _TestResultPageWidgetState();
}

class _TestResultPageWidgetState extends State<TestResultPageWidget> {
  late final QuestionPageModel _model = QuestionPageModel();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  DataManager dm = DataManager.getInstance();
  int testingIndex = 3;
  int qustionIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  int seriousIndex = 2;

  bool _expanded = false;
  String _gptStreamText = '';
  int _gptStreamResultIndex = 0;
  int _diagnosisId = 1;
  bool _isDiagnosisData = false;

  DiagnosisAIResultModel _resultModel = DiagnosisAIResultModel();

  @override
  void initState() {
    super.initState();
    final data = jsonDecode(widget.result!);
    logger.d(widget.result!);
    _resultModel.resultId = data['id'];
    _resultModel.department = data['diagnosis']['department'];
    _gptStreamResultIndex = _resultModel.resultId!;
    _diagnosisId = data['diagnosis']['id'];
    if (data['prescriptions'].length > 0) {
      _resultModel = DiagnosisAIResultModel.formJson(data['prescriptions'].first);
      _isDiagnosisData = true;
    } else {
      _isDiagnosisData = false;
    }
    _handleChat();

    dm.getMyInfo(isUpdate: true);
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          // leading: FlutterFlowIconButton(
          //   borderColor: Colors.transparent,
          //   borderRadius: 30.0,
          //   borderWidth: 1.0,
          //   buttonSize: 60.0,
          //   icon: Icon(
          //     Icon(FFIcons.karrowBack).icon,
          //     color: FlutterFlowTheme.of(context).secondaryText,
          //     size: 30.0,
          //   ),
          //   onPressed: () async {
          //     context.pop();
          //   },
          // ),
          flexibleSpace: appBarMenuContainer(),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        resultImageContainer(context),
                        const SizedBox(
                          height: 12,
                        ),
                        // First Card
                        if (_isDiagnosisData) whatisContainer(context),
                        if (_isDiagnosisData)
                          const SizedBox(
                            height: 12,
                          ),
                        // Second Card
                        if (_isDiagnosisData) medicationsContainer(context),
                        if (_isDiagnosisData)
                          const SizedBox(
                            height: 12,
                          ),
                        // Third Card
                        if (_isDiagnosisData) audiogramContainer(context),
                        if (_isDiagnosisData)
                          const SizedBox(
                            height: 12,
                          ),
                        // Fourth Card
                        //insightContainer(context),
                        if (_isDiagnosisData)
                          const SizedBox(
                            height: 12,
                          ),
                        insightContainerGPT(context),
                        const SizedBox(
                          height: 12,
                        ),
                        // Fifth Card
                        advisedContainer(context),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/imageicon/img_ic_yonsei.png',
                              height: 28,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              Strings.appPowerdYonsei.tr(),
                              style: FlutterFlowTheme.of(context).captionLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (!dm.isLogin) {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
                              builder: (context) => LoginPopupWidget(
                                loginCallbak: loginComplete,
                                isSkip: true,
                              ),
                            );
                            context.goNamed('MediGeniePage');
                          } else {
                            context.goNamed('MediGeniePage');
                          }
                        },
                        text: Strings.appDone.tr(),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: FlutterFlowTheme.of(context).tertiaryText,
                              ),
                          elevation: 0.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        showLoadingIndicator: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack resultImageContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: getSeriousIndex(_resultModel.severityLevel!) == 0
                  ? FlutterFlowTheme.of(context).successBackground
                  : getSeriousIndex(_resultModel.severityLevel!) == 1
                      ? FlutterFlowTheme.of(context).warningBackground
                      : FlutterFlowTheme.of(context).errorBackground,
              borderRadius: BorderRadius.circular(0),
            )),
        Image.asset(
          "assets/images/img_result_${_resultModel.department!.toLowerCase()}.png",
          width: double.infinity,
          height: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _resultModel.name != null ? '${_resultModel.name}' : _resultModel.department!.toUpperCase(),
                style: FlutterFlowTheme.of(context).displayMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container whatisContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/imageicon/img_ic_stethoscope.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  Strings.appWhatItIs.tr(),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
              ],
            ),
            Text(
              '${_resultModel.description}',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).grey900,
                    lineHeight: 1.5,
                  ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/imageicon/img_ic_beacon.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  Strings.appItSerious.tr(),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 12,
                  width: 108,
                  color: getSeriousIndex(_resultModel.severityLevel!) == 0 ? FlutterFlowTheme.of(context).success : FlutterFlowTheme.of(context).disabledBackground,
                ),
                Container(
                  height: 12,
                  width: 108,
                  color: getSeriousIndex(_resultModel.severityLevel!) == 1 ? FlutterFlowTheme.of(context).warning : FlutterFlowTheme.of(context).disabledBackground,
                ),
                Container(
                  height: 12,
                  width: 108,
                  color: getSeriousIndex(_resultModel.severityLevel!) == 2 ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).disabledBackground,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Healthy',
                  style: FlutterFlowTheme.of(context).captionLarge.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
                Text(
                  'Caution',
                  style: FlutterFlowTheme.of(context).captionLarge.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
                Text(
                  'Serious',
                  style: FlutterFlowTheme.of(context).captionLarge.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    '${_resultModel.prescriptions!.serious}',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: FlutterFlowTheme.of(context).grey900,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  int getSeriousIndex(String serious) {
    switch (serious) {
      case 'HEALTHY':
        return 0;
      case 'CAUTION':
        return 1;
      case 'SERIOUS':
        return 2;
      default:
        return 0;
    }
  }

  Container medicationsContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/imageicon/img_ic_patches.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  Strings.appUsualTreatment.tr(),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
              ],
            ),
            Text(
              '${_resultModel.prescriptions!.treatment}}',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).grey900,
                    lineHeight: 1.5,
                  ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/imageicon/img_ic_pills.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  Strings.appMedications.tr(),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${_resultModel.prescriptions!.medications}',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).grey900,
                    lineHeight: 1.5,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/imageicon/img_ic_pill_painreliever.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Pain relievers',
                      style: FlutterFlowTheme.of(context).captionLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/imageicon/img_ic_pills.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Antibiotics',
                      style: FlutterFlowTheme.of(context).captionLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Container audiogramContainer(BuildContext context) {
    List<int> xKeys = UIManager.getInstance().currentDiagnosis!.right.keys.toList().map((e) => int.parse(e)).toList();
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/imageicon/img_ic_graph.png',
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      Strings.appAudiogram.tr(),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: FlutterFlowTheme.of(context).grey900,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      Strings.appLeft.tr(),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: FlutterFlowTheme.of(context).grey900,
                          ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      Strings.appRight.tr(),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: FlutterFlowTheme.of(context).grey900,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text('y:대역폭(Hz) , x:데시벨(db)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: double.infinity, // 너비를 전체 화면으로 설정
              height: 250, // 높이를 400픽셀로 설정
              child: LineChart(
                LineChartData(
                  minY: 0, // Y 축의 최소값 설정
                  maxY: 100, // Y 축의 최대값 설정
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          // X 축 키 값만 반환
                          if (xKeys.contains(value.toInt())) {
                            return Text('${value.toInt()}');
                          }
                          return Text('');
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), // 상단 X 축 라벨 비활성화
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), // 우측 Y 축 라벨 비활성화
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: UIManager.getInstance().currentDiagnosis!.right.entries.map((entry) => FlSpot(double.parse(entry.key), entry.value.toDouble())).toList(),
                      isCurved: true,
                      color: Colors.blue,
                    ),
                    LineChartBarData(
                      spots: UIManager.getInstance().currentDiagnosis!.left.entries.map((entry) => FlSpot(double.parse(entry.key), entry.value.toDouble())).toList(),
                      isCurved: true,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container insightContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/imageicon/img_ic_graph.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  Strings.appResultInsight.tr(),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${_resultModel.mgExplanation}',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Container advisedContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 500),
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              _expanded = !_expanded;
              print(_expanded);
            });
          },
          children: [
            ExpansionPanel(
              isExpanded: _expanded,
              headerBuilder: (context, isExpanded) {
                return Row(
                  children: [
                    Image.asset(
                      'assets/images/imageicon/img_ic_notice.png',
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      Strings.appResultAdvised.tr(),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: FlutterFlowTheme.of(context).grey900,
                          ),
                    ),
                  ],
                );
              },
              body: Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    Strings.appResultAdvisedDec.tr(),
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container questionContainer(List<dynamic> htm, QuestionModel model, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }

  Container questionTitleContainer(BuildContext context) {
    List<dynamic> htm = dm.diagnosisTestData['historytaking'];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${qustionIndex + 1}/${htm.first['order']}',
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Container appBarMenuContainer() {
    int index = 1;
    return Container(
      width: double.infinity,
      //height: kToolbarHeight,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var item in dm.diagnosisTestData.entries)
            if (item.key != 'startmenu')
              startMenuContainer(
                item.key,
                item.value,
                index++,
              ),
        ],
      ),
    );
  }

  Row startMenuContainer(String key, dynamic value, int index) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: index == testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: index == testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).disabledBackground,
              width: 1,
            ),
          ),
          child: Text(
            '$index',
            textAlign: TextAlign.center,
            style: index == testingIndex
                ? FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: FlutterFlowTheme.of(context).tertiaryText,
                    )
                : FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: FlutterFlowTheme.of(context).disabledText,
                    ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          child: Text(index == testingIndex ? '${value[0]['title']}' : '', style: FlutterFlowTheme.of(context).labelMedium),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  Container insightContainerGPT(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/imageicon/img_ic_graph.png',
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  Strings.appResultInsight.tr(),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).grey900,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _gptStreamText,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 40,
            ),
            // StreamBuilder(
            //   stream: streamController.stream,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text(snapshot.data.toString());
            //     }
            //     return Text('_gptStreamText');
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleChat() async {
    try {
      print("handleChat");
      try {
        final stream = sendMessageStream("test");
        await for (final textChunk in stream) {
          setState(() {
            _gptStreamText += textChunk;
          });
        }
        print(_gptStreamText);
      } catch (exception) {
        print(exception.toString());
      }
    } catch (error) {
      logger.d(error);
    }
  }

  // Send Message to ChatGPT and receives the streamed response in chunk
  Stream<String> sendMessageStream(String text) async* {
    print("sendMessageStream");
    setState(() {
      _gptStreamText = '';
    });
    final request = http.Request("POST", Uri.parse("https://api.medigenie.ai/api/diagnosis/$_diagnosisId/ai"));
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] = "Bearer ${ApiManager.accessToken}";
    request.headers["Accept-Language"] = "${ApiManager.locale!.languageCode}_${ApiManager.locale!.countryCode}";
    request.body = jsonEncode({
      if (dm.isLogin) "uuid": "${dm.deviceId}",
      "diagnosisResultId": _gptStreamResultIndex,
    });
    final response = await StreamClient.instance.send(request);
    final statusCode = response.statusCode;
    final byteStream = response.stream;

    if (!(statusCode >= 200 && statusCode < 300)) {
      var error = "";
      await for (final byte in byteStream) {
        final decoded = utf8.decode(byte).trim();
        final map = jsonDecode(decoded) as Map;
        final errorMessage = map["error"]["message"] as String;
        error += errorMessage;
      }
      throw Exception("($statusCode) ${error.isEmpty ? "Bad Response" : error}");
    }

    inspect(response);
    await for (final byte in byteStream) {
      var decoded = utf8.decode(byte);
      yield decoded;
    }
  }

  void loginComplete(bool isSuccess) {
    if (isSuccess) {
      if (dm.userModel!.userPersnalInfoMedel!.gender == null) {
        context.pushNamed('TermsOfServicePage');
      }
    } else {}

    setState(() {});
  }
}
