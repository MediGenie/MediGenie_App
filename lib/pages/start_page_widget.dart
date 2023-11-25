import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../model/start_page_model.dart';
export '../model/start_page_model.dart';

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({Key? key}) : super(key: key);

  @override
  _StartPageWidgetState createState() => _StartPageWidgetState();
}

class _StartPageWidgetState extends State<StartPageWidget> {
  late StartPageModel _model;

  List<ConsultContainer> consultInfo = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> selectInterests = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.appConsultDec.tr(),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Container(
                          width: 100.0,
                          height: 8.0,
                          decoration: const BoxDecoration(
                            color: Color(0x00FAFAFA),
                          ),
                        ),
                        Text(
                          Strings.appChooseThan.tr(),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: 500.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 28.0, 20.0, 20.0),
                  child: GridInfo(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: GetConsultNext()
                          ? () async {
                              final response = await PutGeustUpdateCall.call(interests: selectInterests);
                              print(response.response!.body);
                              context.goNamed('MediGeniePage');
                            }
                          : null,
                      text: Strings.appGetStarted,
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                        borderRadius: BorderRadius.circular(20.0),
                        disabledColor: FlutterFlowTheme.of(context).disabledBackground,
                        disabledTextColor: FlutterFlowTheme.of(context).disabledText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void Refresh(int title) {
    setState(
      () {
        for (var element in InterestEnum.values) {
            if (element.index == title) {
              selectInterests.contains('"${element.value}"')
                  ? selectInterests.remove('"${element.value}"')
                  : selectInterests.add('"${element.value}"');
            }
          }
        print(selectInterests);
      },
    );
  }

  // ignore: non_constant_identifier_names
  bool GetConsultNext() {
    for (int i = 0; i < consultInfo.length; i++) {
      if (consultInfo[i].isPressed == true) {
        return true;
      }
    }
    return false;
  }

  // ignore: non_constant_identifier_names
  GridView GridInfo(BuildContext context) {
    consultInfo.addAll([
      ConsultContainer(index: 0, onPressed: Refresh, title: Strings.appHealthState.tr(), icon: 'stethoscope'),
      ConsultContainer(index: 1, onPressed: Refresh, title: Strings.appHealthManagement.tr(), icon: 'management'),
      ConsultContainer(index: 2, onPressed: Refresh, title: Strings.appHealthCheckup.tr(), icon: 'x-ray'),
      ConsultContainer(index: 3, onPressed: Refresh, title: Strings.appHealthInfo.tr(), icon: 'dna'),
    ]);
    return GridView(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.0,
      ),
      primary: false,
      scrollDirection: Axis.vertical,
      children: [
        consultInfo[0],
        consultInfo[1],
        consultInfo[2],
        consultInfo[3],
      ],
    );
  }
}

// ignore: must_be_immutable
class ConsultContainer extends StatefulWidget {
  final int index;
  final String title, icon;
  final onPressed;
  bool isPressed = false;

  ConsultContainer({
    Key? key,
    required this.index,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ConsultContainer> createState() => _ConsultContainerState();
}

class _ConsultContainerState extends State<ConsultContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isPressed = !widget.isPressed;
          widget.onPressed(widget.index);
        });
      },
      child: Container(
        width: 154.0,
        height: 154.0,
        decoration: BoxDecoration(
          color: const Color(0x00FAFAFA),
          borderRadius: BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: widget.isPressed ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).disabledBackground,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/imageicon/img_ic_${widget.icon}.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
