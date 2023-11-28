import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_util.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/inappBrowserManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/diagosis_page_model.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
export '../model/diagosis_page_model.dart';

class DiagosisPageWidget extends StatefulWidget {
  const DiagosisPageWidget({super.key});

  @override
  _DiagosisPageWidgetState createState() => _DiagosisPageWidgetState();
}

class _DiagosisPageWidgetState extends State<DiagosisPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DataManager dm = DataManager.getInstance();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => DiagosisPageModel());
  }

  @override
  void dispose() {
    //_model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0x00ECEEF0),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Text(
            Strings.appDiagnosis.tr(),
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 0.0),
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
                        GestureDetector(
                          onTap: () async {
                            UIManager.getInstance().alertOneButtonShow(
                              context,
                              Strings.appComingTitle.tr(),
                              Strings.appComingDec.tr(),
                              Strings.appOkey.tr(),
                              () => null,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 180.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).accent1,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/img_chatbot.png',
                                ).image,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                    child: Text(
                                      Strings.appAskAi.tr(),
                                      style: FlutterFlowTheme.of(context).headlineLarge,
                                    ),
                                  ),
                                  Text(
                                    Strings.appFindSymptoms.tr(),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        for (int i = 0; i < setDis().length; i++) setDis()[i],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> setDis() {
    List<Widget> listWidget = [];
    dm.diagosisModels.forEach(
      (category, value) {
        List<DiagosisPageModel> list = value;
        listWidget.add(setDiagnosisGruop(context, category, list));
      },
    );

    return listWidget;
  }

  Column setDiagnosisGruop(BuildContext context, String category, List<DiagosisPageModel> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/imageicon/img_ic_diagnosis_$category.png',
              width: 22.0,
              height: 22.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              ('app_$category').tr(),
              style: FlutterFlowTheme.of(context).headlineMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        GridView(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (DiagosisPageModel model in list) setDiagnosisCard(context, model.id!, model.subject!, category),
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
      ],
    );
  }

  Container setDiagnosisCard(BuildContext context, int id, String subject, String category) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.queue_music,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  Text(
                    ('app_$subject').tr(),
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ],
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                await onClickDiagnosisStart(
                  context,
                  category,
                  subject,
                  id,
                );
              },
              text: '',
              options: FFButtonOptions(
                elevation: 0.0,
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                textStyle: FlutterFlowTheme.of(context).labelMedium,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              showLoadingIndicator: false,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onClickDiagnosisStart(BuildContext context, String category, String subject, int index) async {
    if (dm.getDiagosisModel(category, index).jsonLink!.contains('monetbrain')) {
      InAppBrowserManager.getInstance().openBrowser(url: dm.getDiagosisModel(category, index).jsonLink!);
    } else if (dm.getDiagosisModel(category, index).jsonLink!.contains('comingsoon')) {
      UIManager.getInstance().alertOneButtonShow(
        context,
        Strings.appComingTitle.tr(),
        Strings.appComingDec.tr(),
        Strings.appOkey.tr(),
        () => null,
      );
    } else {
      UIManager.getInstance().clearCurrentDiagnosis();
      // 진단 전체 데이터 저장
      UIManager.getInstance().currentDiagnosis!.diagnosisId = dm.getDiagosisModel(category, index).id;
      logger.d(dm.getDiagosisModel(category, index).jsonLink!);
      await dm.dignosisDataLoading(
        context,
        dm.getDiagosisModel(category, index).jsonLink!,
        category,
        subject,
      );
      await context.pushNamed('DiagnosisTestPage', queryParameters: {
        'heroRecommandIndex': '$index',
        'selectDiagnosisIndex': '${dm.getDiagosisModel(category, index).id}',
        'selectDiagnosisCategory': '${dm.getDiagosisModel(category, index).diagnosisCategory}',
        'selectDiagnosisSubject': '${dm.getDiagosisModel(category, index).subject}',
      });
    }
  }
}
