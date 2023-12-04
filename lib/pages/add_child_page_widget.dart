import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_icon_button.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_theme.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_util.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_widgets.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';

import 'package:flutter/material.dart';
import 'package:medi_genie/pages/age_input_page_widget.dart';
import 'package:medi_genie/pages/name_input_page_widget.dart';
import 'package:medi_genie/provider/input_userinfo.dart';
import 'package:provider/provider.dart';

import 'gender_input_page_widget.dart';
export '../model/terms_of_service_page_model.dart';

class AddChildPageWidget extends StatefulWidget {
  final String? termTime;
  final String? privacyTime;

  const AddChildPageWidget({
    super.key,
    this.termTime,
    this.privacyTime,
  });

  @override
  _AddChildPageWidgetState createState() => _AddChildPageWidgetState();
}

class _AddChildPageWidgetState extends State<AddChildPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  DataManager dm = DataManager.getInstance();
  PageController pageController = PageController(initialPage: 0);
  int _pageNumber = 0;

  String _firstName = "";
  String _lastName = "";

  // 0 - 선택 안함, 1 - 남자, 2 - 여자
  int _genderIndex = 0;

  DateTime _birthDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
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
            if (_pageNumber == 0) {
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
                    //TermsInputPageWidget(),
                    NameInputPageWidget(
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
                  if (_pageNumber == 2) {
                    setChildInfo(context);
                    await _postAddChild();
                    context.pop();
                  } else {
                    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  }
                },
                text: _pageNumber == 2 ? Strings.appDone.tr() : Strings.appContinue.tr(),
                //text: Strings.appContinue.tr(),
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

  void setChildInfo(BuildContext context) {
    _firstName = context.read<InputUserInfo>().firstName;
    _lastName = context.read<InputUserInfo>().lastName;
    _genderIndex = context.read<InputUserInfo>().genderIndex;
    _birthDate = context.read<InputUserInfo>().birthDate;
    context.read<InputUserInfo>().reset();
  }

  void setGender(String gender) {
    dm.userModel!.userPersnalInfoMedel!.gender = gender;
  }

  void setAge(String age) {
    dm.userModel!.userPersnalInfoMedel!.ageCategory = age;
  }

  Future<void> _postAddChild() async {
    final response = await PostChildAddCall.call(
      type: 'CHILD',
      name: '$_firstName $_lastName',
      birthDate: '$_birthDate',
      gender: dm.getIndexToGender(_genderIndex),
    );
    await DataManager.getInstance().getMyInfo(isUpdate: true);
    setState(() {});
    logger.d(response.response!.body);
  }
}
