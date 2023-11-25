import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../model/terms_of_service_page_model.dart';
export '../model/terms_of_service_page_model.dart';

class TermsInputPageWidget extends StatefulWidget {
  final PageController pageController;
  const TermsInputPageWidget({
    Key? key,
    required PageController pageController,
  })  : pageController = pageController,
        super(key: key);

  @override
  _TermsInputPageWidgetState createState() => _TermsInputPageWidgetState();
}

class _TermsInputPageWidgetState extends State<TermsInputPageWidget> {
  late TermsOfServicePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final DateTime _termsTime = DateTime.now();
  final DateTime _policyTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsOfServicePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Text(
                    Strings.appTermsAgreeDec.tr(),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).displayMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          lineHeight: 1.25,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 28.0, 0.0, 28.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ToggleIcon(
                        onPressed: () async {
                          setState(() {
                            _model.allCheck = !_model.allCheck!;
                            _model.ageCheck = _model.allCheck;
                            _model.termsCheck = _model.allCheck;
                            _model.policyCheck = _model.allCheck;
                          });
                        },
                        value: _model.allCheck!,
                        onIcon: Icon(
                          Icons.check_box,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24.0,
                        ),
                        offIcon: Icon(
                          Icons.check_box_outline_blank,
                          color: FlutterFlowTheme.of(context).disabledBackground,
                          size: 24.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Strings.appAgreeBelow.tr(),
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ToggleIcon(
                        onPressed: () async {
                          setState(() => _model.ageCheck = !_model.ageCheck!);
                        },
                        value: _model.ageCheck!,
                        onIcon: Icon(
                          Icons.check_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24.0,
                        ),
                        offIcon: Icon(
                          Icons.check_rounded,
                          color: FlutterFlowTheme.of(context).disabledBackground,
                          size: 24.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Strings.app14YearsRe.tr(),
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ToggleIcon(
                        onPressed: () async {
                          setState(() => _model.termsCheck = !_model.termsCheck!);
                        },
                        value: _model.termsCheck!,
                        onIcon: Icon(
                          Icons.check_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24.0,
                        ),
                        offIcon: Icon(
                          Icons.check_rounded,
                          color: FlutterFlowTheme.of(context).disabledBackground,
                          size: 24.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Strings.appTermsServiceRe.tr(),
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ToggleIcon(
                      onPressed: () async {
                        setState(() => _model.policyCheck = !_model.policyCheck!);
                      },
                      value: _model.policyCheck!,
                      onIcon: Icon(
                        Icons.check_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24.0,
                      ),
                      offIcon: Icon(
                        Icons.check_rounded,
                        color: FlutterFlowTheme.of(context).disabledBackground,
                        size: 24.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Strings.appPrivacyPolicyRe.tr(),
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
          child: FFButtonWidget(
            onPressed: !(_model.ageCheck! && _model.termsCheck! && _model.policyCheck!)
                ? null
                : () {
                    DataManager.getInstance().userModel!.userPersnalInfoMedel!.serviceAgreedDate = setTime(_termsTime);
                    DataManager.getInstance().userModel!.userPersnalInfoMedel!.privacyPolicyAgreedDate = setTime(_policyTime);
                  },
            text: Strings.appAgree.tr(),
            options: FFButtonOptions(
              width: double.infinity,
              height: 56.0,
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                    fontFamily: 'Plus Jakarta Sans',
                    color: FlutterFlowTheme.of(context).tertiaryText,
                  ),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
              disabledColor: FlutterFlowTheme.of(context).disabledBackground,
              disabledTextColor: FlutterFlowTheme.of(context).disabledText,
            ),
          ),
        ),
      ],
    );
  }

  DateTime setTime(DateTime time) {
    return time = DateTime.now();
  }
}
