import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/pages/age_input_page_widget.dart';
import 'package:medi_genie/pages/gender_input_page_widget.dart';
import 'package:medi_genie/pages/terms_input_page_widget.dart';
import 'package:medi_genie/provider/input_userinfo.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
export '../model/terms_of_service_page_model.dart';

class TermsOfServicePageWidget extends StatefulWidget {
  const TermsOfServicePageWidget({super.key});

  @override
  _TermsOfServicePageWidgetState createState() => _TermsOfServicePageWidgetState();
}

class _TermsOfServicePageWidgetState extends State<TermsOfServicePageWidget> {
  late TermsOfServicePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(initialPage: 0);
  int _pageNumber = 0;

  DataManager dm = DataManager.getInstance();

  DateTime _termsTime = DateTime.now();
  DateTime _policyTime = DateTime.now();

  // 0 - 선택 안함, 1 - 남자, 2 - 여자
  int _genderIndex = 0;

  DateTime _birthDate = DateTime.now();

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
    return Scaffold(
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
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (count) => setState(
                    () {
                      _pageNumber = count;
                    },
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    TermsInputPageWidget(
                      pageController: pageController,
                    ),
                    GenderInputPageWidget(
                      pageController: pageController,
                    ),
                    AgeInputPageWidget(
                      pageController: pageController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (pageController.page == 2) {
                    setUserInfo(context);
                    _putUserInfo();
                    context.pop();
                  } else {
                    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  }
                },
                text: _pageNumber == 2 ? Strings.appDone.tr() : Strings.appContinue.tr(),
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
        ),
      ),
    );
  }

  void setUserInfo(BuildContext context) {
    _genderIndex = context.read<InputUserInfo>().genderIndex;
    _birthDate = context.read<InputUserInfo>().birthDate;
    _policyTime = context.read<InputUserInfo>().policyTime;
    _termsTime = context.read<InputUserInfo>().termsTime;
    context.read<InputUserInfo>().reset();
  }

  DateTime setTime(DateTime time) {
    return time = DateTime.now();
  }

  Future<void> _putUserInfo() async {
    Map<String, dynamic> userInfo = {
      'gender': dm.getIndexToGender(_genderIndex),
      'serviceAgreedDate': '$_termsTime',
      'privacyPolicyAgreedDate': '$_policyTime',
      'birthDate': '$_birthDate',
    };
    final response = await PutUserCall.call(userInfo);
    logger.d(DataManager.getInstance().userModel!.id);
    logger.d(response.response!.body);
  }
}
