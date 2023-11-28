import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/index.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/socialManager.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'login_popup_model.dart';
export 'login_popup_model.dart';

// ignore: must_be_immutable
class LoginPopupWidget extends StatefulWidget {
  Function? loginCallbak = () {};
  bool? isSkip = false;
  LoginPopupWidget({super.key, Function? loginCallbak, bool? isSkip}) {
    this.loginCallbak = loginCallbak;
    this.isSkip = isSkip;
  }

  @override
  _LoginPopupWidgetState createState() => _LoginPopupWidgetState();
}

class _LoginPopupWidgetState extends State<LoginPopupWidget> {
  late LoginPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPopupModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 362.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(0.0, -3.0),
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: const Divider(
                color: Color(0xFFDCDFE3),
                thickness: 4.0,
                indent: 150.0,
                endIndent: 150.0,
                height: 4.0,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 32.0),
              child: Text(
                Strings.appManageHealthDec.tr(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: const Color(0xFF212529),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              width: 320.0,
              height: 56.0,
              child: Stack(
                children: [
                  FFButtonWidget(
                    onPressed: () {
                      //context.pushNamed('TermsOfServicePage');
                      SocialManager.getInstance().loginWithGoogle(callback: loginSuccess);
                    },
                    text: Strings.appContinueGoogle.tr(),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: double.infinity,
                      elevation: 0,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).labelLarge,
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).divider,
                        width: 1.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-0.85, 0.0),
                    child: Image.asset(
                      'assets/images/imageicon/img_ic_google.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: SizedBox(
                width: 320.0,
                height: 56.0,
                child: Stack(
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        SocialManager.getInstance().loginWithApple(callback: loginSuccess);
                      },
                      text: Strings.appContinueApple.tr(),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: double.infinity,
                        elevation: 0,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context).labelLarge,
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).divider,
                          width: 1.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-0.85, 0.0),
                      child: Image.asset(
                        'assets/images/imageicon/img_ic_apple.png',
                        width: 24.0,
                        height: 24.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isSkip == true)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  child: GestureDetector(
                    child: Text(Strings.appSkip.tr(), style: FlutterFlowTheme.of(context).labelLarge),
                    onTap: () {
                      Navigator.pop(context);
                      // ignore: unnecessary_statements
                      widget.loginCallbak!(false);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void loginSuccess(bool isSuccess) {
    print("loginSuccess ====== $isSuccess");
    DataManager.getInstance().getMyInfo(isUpdate: true);
    Navigator.pop(context, MaterialPageRoute(builder: (context) => MyPageWidget(key: widget.key)));
    // ignore: unnecessary_statements
    widget.loginCallbak!(isSuccess);
  }
}
