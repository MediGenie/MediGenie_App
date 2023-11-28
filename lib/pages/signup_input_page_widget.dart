import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
export '../model/terms_of_service_page_model.dart';

class SignupInputPageWidget extends StatefulWidget {
  final String? termTime;
  final String? privacyTime;

  const SignupInputPageWidget({
    super.key,
    String? termTime,
    String? privacyTime,
  })  : termTime = termTime,
        privacyTime = privacyTime;

  @override
  _SignupInputPageWidgetState createState() => _SignupInputPageWidgetState();
}

class _SignupInputPageWidgetState extends State<SignupInputPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  PageController pageController = PageController(initialPage: 0);

  String ageEnum = AgeEnum.TEENAGER.toString();
  String genderEnum = GenderEnum.OTHER.toString();

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
    logger.d(widget.termTime);
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
          elevation: 0.0,
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.appAboutYou.tr(),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).displayMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    lineHeight: 1.25,
                                  ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              Strings.appInformationInput.tr(),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                  ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            CustomRadioButton(
                              elevation: 0,
                              height: 100,
                              width: 100,
                              enableShape: true,
                              shapeRadius: 20,
                              radius: 20,
                              buttonLables: [
                                Strings.appMale.tr(),
                                Strings.appFemale.tr(),
                              ],
                              radioButtonValue: (value) async {
                                if (pageController.page == 0) {
                                  setGender(value.toString());
                                  genderEnum = value.toString();
                                  await pageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                } else {}
                              },
                              buttonValues: [
                                GenderEnum.MALE.value,
                                GenderEnum.FEMALE.value,
                              ],
                              selectedBorderColor: FlutterFlowTheme.of(context).primary,
                              unSelectedBorderColor: FlutterFlowTheme.of(context).disabledBackground,
                              selectedColor: FlutterFlowTheme.of(context).primary,
                              unSelectedColor: FlutterFlowTheme.of(context).secondaryBackground,
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: FlutterFlowTheme.of(context).tertiaryText,
                                unSelectedColor: FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context).labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              Strings.appHowOldDec.tr(),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).displayMedium.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    lineHeight: 1.25,
                                  ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            CustomRadioButton(
                              padding: 0,
                              scrollController: ScrollController(
                                initialScrollOffset: 0,
                                keepScrollOffset: false,
                              ),
                              enableButtonWrap: true,
                              wrapAlignment: WrapAlignment.start,
                              elevation: 0,
                              absoluteZeroSpacing: true,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                              spacing: 0,
                              height: 72,
                              width: MediaQuery.of(context).size.width,
                              enableShape: true,
                              shapeRadius: 16,
                              radius: 16,
                              horizontal: true,
                              buttonValues: [
                                AgeEnum.TEENAGER.value,
                                AgeEnum.YOUNG_ADULT.value,
                                AgeEnum.OLDER_ADULT.value,
                                AgeEnum.SENIOR.value,
                              ],
                              buttonLables: const [
                                '14 - 17',
                                '18 - 39',
                                '40 - 69',
                                '70+',
                              ],
                              radioButtonValue: (value) {
                                setAge(value.toString());
                                ageEnum = value.toString();
                                print(value);
                              },
                              selectedBorderColor: FlutterFlowTheme.of(context).primary,
                              unSelectedBorderColor: FlutterFlowTheme.of(context).disabledBackground,
                              selectedColor: FlutterFlowTheme.of(context).primary,
                              unSelectedColor: FlutterFlowTheme.of(context).secondaryBackground,
                              buttonTextStyle: ButtonTextStyle(
                                selectedColor: FlutterFlowTheme.of(context).tertiaryText,
                                unSelectedColor: FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context).labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await _putUserInfo();
                        await context.pushNamed('MediGeniePage');
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void setGender(String gender) {
    DataManager.getInstance().userModel!.userPersnalInfoMedel!.gender = gender;
  }

  void setAge(String age) {
    DataManager.getInstance().userModel!.userPersnalInfoMedel!.ageCategory = age;
  }

  Future<void> _putUserInfo() async {
    Map<String, dynamic> userInfo = {
      'ageCategory': ageEnum,
      'gender': genderEnum,
      'serviceAgreedDate': '${widget.termTime}',
      'privacyPolicyAgreedDate': '${widget.privacyTime}',
      'birthDate': '${widget.privacyTime}',
    };
    final response = await PutUserCall.call(userInfo);
    logger.d(DataManager.getInstance().userModel!.id);
    logger.d(response.response!.body);
  }
}
