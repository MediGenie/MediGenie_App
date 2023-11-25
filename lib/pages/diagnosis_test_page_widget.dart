import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medi_genie/components/userselect_component.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_theme.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_util.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_widgets.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';

// ignore: must_be_immutable
class DiagnosisTestPageWidget extends StatefulWidget {
  String? heroRecommandIndex;
  String? selectDiagnosisIndex;
  String? selectDiagnosisCategory;
  String? selectDiagnosisSubject;
  DiagnosisTestPageWidget(
      {Key? key,
      String? heroRecommandIndex,
      String? selectDiagnosisIndex,
      String? selectDiagnosisCategory,
      String? selectDiagnosisSubject})
      : super(key: key) {
    this.heroRecommandIndex = heroRecommandIndex;
    this.selectDiagnosisIndex = selectDiagnosisIndex;
    this.selectDiagnosisCategory = selectDiagnosisCategory;
    this.selectDiagnosisSubject = selectDiagnosisSubject;
  }

  @override
  State<DiagnosisTestPageWidget> createState() => _DiagnosisTestPageWidgetState();
}

class _DiagnosisTestPageWidgetState extends State<DiagnosisTestPageWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    logger.d(widget.selectDiagnosisIndex);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    DataManager dm = DataManager.getInstance();
    int heroRecommandIndex = int.parse(widget.heroRecommandIndex!);
    int selectDiagnosisIndex = int.parse(widget.selectDiagnosisIndex!);
    double mh = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0x00ECEEF0),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -kToolbarHeight),
              child: Container(
                child: Hero(
                  tag: heroRecommandIndex,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/img_card_${dm.getDiagosisModel('${widget.selectDiagnosisCategory}', selectDiagnosisIndex).diagnosisCategory}.png',
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              //alignment: Alignment.bottomCenter,
              margin: EdgeInsets.fromLTRB(0, (mh - (mh * 0.6) - kToolbarHeight), 0, 0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      Strings.appHowItWork.tr(),
                      textAlign: TextAlign.left,
                      style: FlutterFlowTheme.of(context).displaySmall,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    startMenuSetting(context),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        if (dm.userModel!.userFamilyMemberModels!.isNotEmpty) {
                          await showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
                              builder: (context) => UserSelectComponenetWidget());
                        }
                        // 문진 json 데이터 로딩
                        await dm.dignosisDataLoading(
                          context,
                          dm.getDiagosisModel(widget.selectDiagnosisCategory!, int.parse(widget.selectDiagnosisIndex!)).jsonLink!,
                          widget.selectDiagnosisCategory!,
                          widget.selectDiagnosisSubject!,
                        );
                        await context.pushNamed(
                          dm.getNextDiagnosisPageName(0),
                          queryParameters: {
                            'orderIndex': '1',
                          },
                        );
                      },
                      text: Strings.appStart.tr(),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container startMenuSetting(BuildContext context) {
    int count = 1;
    return Container(
      child: Column(children: [
        for (String title in DataManager.getInstance().startMenu) testingFlow(context, count++, title),
      ]),
    );
  }

  Container testingFlow(BuildContext context, int index, String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).accent1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$index',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelMedium,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
