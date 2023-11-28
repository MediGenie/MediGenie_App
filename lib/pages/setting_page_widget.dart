import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/socialManager.dart';
import 'package:medi_genie/manager/uiManager.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../model/setting_page_model.dart';
export '../model/setting_page_model.dart';

class SettingPageWidget extends StatefulWidget {
  const SettingPageWidget({super.key});

  @override
  _SettingPageWidgetState createState() => _SettingPageWidgetState();
}

class _SettingPageWidgetState extends State<SettingPageWidget> {
  late SettingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingPageModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0x00ECEEF0),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1.0,
            decoration: const BoxDecoration(
              color: Color(0x00FAFAFA),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 4.0),
                      child: Container(
                        width: double.infinity,
                        height: 64.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(-0.85, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: Strings.appTermsService.tr(),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 40.0,
                              elevation: 0,
                              color: const Color(0x00FFFFFF),
                              textStyle: FlutterFlowTheme.of(context).labelMedium,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 20.0, 4.0),
                      child: Container(
                        width: double.infinity,
                        height: 64.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(-0.85, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: Strings.appPrivacyPolicy.tr(),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 40.0,
                              elevation: 0,
                              color: const Color(0x00FFFFFF),
                              textStyle: FlutterFlowTheme.of(context).labelMedium,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (DataManager.getInstance().isLogin)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 20.0, 4.0),
                        child: Container(
                          width: double.infinity,
                          height: 64.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(-1, 0.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                context.pushNamed('AddChildPage');
                              },
                              text: Strings.appAddChild.tr(),
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                elevation: 0,
                                color: const Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context).labelMedium,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (DataManager.getInstance().isLogin)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 4.0, 20.0, 4.0),
                        child: Container(
                          width: double.infinity,
                          height: 64.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(-0.85, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                UIManager.getInstance().alertOneButtonShow(
                                  context,
                                  Strings.appDeleteAccountTitle.tr(),
                                  Strings.appDeleteAccountDec.tr(),
                                  Strings.appConfirm.tr(),
                                  () => null,
                                );
                              },
                              text: Strings.appDeleteAccount.tr(),
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                elevation: 0,
                                color: const Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context).labelMedium,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (DataManager.getInstance().isLogin)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: FFButtonWidget(
                        onPressed: () async {
                          UIManager.getInstance().alertTwoButtonShow(
                            context,
                            Strings.appSignoutTitle.tr(),
                            Strings.appSignoutDec.tr(),
                            Strings.appBack.tr(),
                            Strings.appSignout.tr(),
                            () => null,
                            logoutCallback,
                          );
                        },
                        text: Strings.appSignout.tr(),
                        options: FFButtonOptions(
                          elevation: 0,
                          width: 130.0,
                          height: 40.0,
                          color: const Color(0x00017BFF),
                          textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
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

  void logoutCallback() {
    //initState();
    setState(() {
      SocialManager.getInstance().socialLogout(callback: logoutCallback);
    });
  }
}
