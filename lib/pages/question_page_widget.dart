import 'package:medi_genie/backend/api_requests/api_calls.dart';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_widgets.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/testing_model.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../model/question_page_model.dart';
export '../model/question_page_model.dart';

// ignore: must_be_immutable
class QuestionPageWidget extends StatefulWidget {
  String? orderIndex;
  QuestionPageWidget({
    super.key,
    String? orderIndex,
  }) {
    this.orderIndex = orderIndex;
  }

  @override
  _QuestionPageWidgetState createState() => _QuestionPageWidgetState();
}

class _QuestionPageWidgetState extends State<QuestionPageWidget> {
  late QuestionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  DataManager dm = DataManager.getInstance();
  int _testingIndex = 1;
  int qustionIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  List<dynamic> htm = [];
  HistoryTakingTestingModel htModel = HistoryTakingTestingModel();

  final Map<int, Map<String, String>> _selectedQuestionData = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuestionPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    htm = dm.diagnosisTestData['historytaking'];
    htModel = HistoryTakingTestingModel.formJson(htm.first);
    _testingIndex = htModel.index!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              const Icon(FFIcons.karrowBack).icon,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30.0,
            ),
            onPressed: () async {
              if (pageController.page == 0) {
                context.pop();
              } else {
                pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
              }
            },
          ),
          flexibleSpace: appBarMenuContainer(),
          centerTitle: false,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: IconButton(
                onPressed: () => {
                  UIManager.getInstance().diagnosisLeaveAlert(
                    context,
                  ),
                },
                icon: Icon(
                  const Icon(FFIcons.kclose).icon,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                questionTitleContainer(context),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (count) => setState(() {
                        qustionIndex = count;
                      }),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (QuestionModel model in htModel.questions!) questionContainer(htm, model, context),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (qustionIndex + 1 == htModel.order) {
                              if (dm.diagnosisTestData.length == _testingIndex + 1) {
                                UIManager.getInstance().currentDiagnosis!.historyTakingData = dm.getHTDataToString(data: _selectedQuestionData);
                                PostDiagnosisResultCall.call(DataManager.getInstance().setTempData()).then(
                                  (value) => {
                                    if (value.statusCode == 200)
                                      {
                                        context.pushNamed(
                                          dm.getNextDiagnosisPageName(_testingIndex),
                                          queryParameters: {
                                            'index': '$_testingIndex',
                                            'result': value.response!.body,
                                          },
                                        ),
                                      }
                                  },
                                );
                              } else {
                                UIManager.getInstance().currentDiagnosis!.historyTakingData = dm.getHTDataToString(data: _selectedQuestionData);
                                context.pushNamed(
                                  dm.getNextDiagnosisPageName(_testingIndex),
                                  queryParameters: {
                                    'index': '$_testingIndex',
                                  },
                                );
                              }
                            } else {
                              await pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          text: 'Continue',
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
                          showLoadingIndicator: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox questionContainer(List<dynamic> htm, QuestionModel model, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              if (model.isReduplication!) checkBoxGruopComponent(context, htm),
              if (!model.isReduplication!) radioGruopComponent(context, htm),
            ],
          ),
        ],
      ),
    );
  }

  // 여러개 선택 가능한 라디오 버튼
  CustomCheckBoxGroup<dynamic> checkBoxGruopComponent(BuildContext context, List<dynamic> htm) {
    List<String> count = [];
    int cnt = 0;
    // ignore: unused_local_variable
    for (var element in htModel.questions![qustionIndex].answers!) {
      count.add(cnt.toString());
      cnt += 1;
    }
    CustomCheckBoxGroup<String> radioButtonQuestionList = CustomCheckBoxGroup<String>(
      autoWidth: true,
      isDefaultRelease: true,
      buttonTextStyle: ButtonTextStyle(
        selectedColor: FlutterFlowTheme.of(context).primaryText,
        unSelectedColor: FlutterFlowTheme.of(context).primaryText,
        textStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'Plus Jakarta Sans',
              color: FlutterFlowTheme.of(context).primaryText,
            ),
      ),
      height: 74,
      width: MediaQuery.of(context).size.width,
      enableShape: true,
      shapeRadius: 16,
      radius: 16,
      horizontal: true,
      buttonLables: htModel.questions![qustionIndex].answers!,
      buttonValuesList: count,
      checkBoxButtonValues: (values) {
        Set<String> selectedAnswers = {};
        String selectedAnswer = '';
        for (var element in values) {
          selectedAnswers.add(htModel.questions![qustionIndex].answers![int.parse(element)]);
          selectedAnswer += '${htModel.questions![qustionIndex].answers![int.parse(element)]},';
          _selectedQuestionData[qustionIndex] = {
            'question': '${htModel.questions![qustionIndex].question!},',
            'answer': selectedAnswer,
          };
        }

        print(_selectedQuestionData);
      },
      selectedBorderColor: FlutterFlowTheme.of(context).primary,
      unSelectedBorderColor: FlutterFlowTheme.of(context).disabledBackground,
      selectedColor: FlutterFlowTheme.of(context).secondaryBackground,
      unSelectedColor: FlutterFlowTheme.of(context).secondaryBackground,
      defaultSelected: const ['0'],
    );

    return radioButtonQuestionList;
  }

  // 하나만 선택 가능한 라디오 버튼
  CustomRadioButton<dynamic> radioGruopComponent(BuildContext context, List<dynamic> htm) {
    final key = GlobalKey<CustomRadioButtonState>();
    List<String> count = [];
    int cnt = 0;
    // ignore: unused_local_variable
    for (var element in htModel.questions![qustionIndex].answers!) {
      count.add(cnt.toString());
      cnt += 1;
    }
    return CustomRadioButton(
      key: key,
      enableButtonWrap: true,
      wrapAlignment: WrapAlignment.center,
      elevation: 0,
      absoluteZeroSpacing: true,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      spacing: 0,
      buttonTextStyle: ButtonTextStyle(
        selectedColor: FlutterFlowTheme.of(context).primaryText,
        unSelectedColor: FlutterFlowTheme.of(context).primaryText,
        textStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'Plus Jakarta Sans',
              color: FlutterFlowTheme.of(context).primaryText,
            ),
      ),
      height: 75,
      width: MediaQuery.of(context).size.width,
      enableShape: true,
      shapeRadius: 16,
      radius: 16,
      horizontal: true,
      buttonValues: count,
      buttonLables: htModel.questions![qustionIndex].answers!,
      radioButtonValue: (value) {
        print('$value');
        _selectedQuestionData[qustionIndex] = {
          'question': htModel.questions![qustionIndex].question!,
          'answer': htModel.questions![qustionIndex].answers![int.parse(value)],
        };
        print(_selectedQuestionData);
      },
      selectedBorderColor: FlutterFlowTheme.of(context).primary,
      unSelectedBorderColor: FlutterFlowTheme.of(context).disabledBackground,
      selectedColor: FlutterFlowTheme.of(context).secondaryBackground,
      unSelectedColor: FlutterFlowTheme.of(context).secondaryBackground,
      defaultSelected: '0',
    );
  }

  Container questionTitleContainer(BuildContext context) {
    List<dynamic> htm = dm.diagnosisTestData['historytaking'];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
          AutoSizeText(
            '${htModel.questions![qustionIndex].question}',
            textAlign: TextAlign.start,
            maxLines: 3,
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          if (htModel.questions![qustionIndex].subtitle != '')
            const SizedBox(
              height: 8,
            ),
          if (htModel.questions![qustionIndex].subtitle != '')
            AutoSizeText(
              '${htModel.questions![qustionIndex].subtitle}',
              maxLines: 2,
              style: FlutterFlowTheme.of(context).labelMedium,
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
            color: index == _testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: index == _testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).disabledBackground,
              width: 1,
            ),
          ),
          child: Text(
            '$index',
            textAlign: TextAlign.center,
            style: index == _testingIndex
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
          child: Text(index == _testingIndex ? '${value[0]['title']}' : '', style: FlutterFlowTheme.of(context).labelMedium),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
