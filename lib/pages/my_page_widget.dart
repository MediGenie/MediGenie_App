import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/components/login_popup_widget.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/user_model.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import '../model/my_page_model.dart';
export '../model/my_page_model.dart';

class MyPageWidget extends StatefulWidget {
  const MyPageWidget({super.key});

  @override
  _MyPageWidgetState createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  late MyPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  DataManager dm = DataManager.getInstance();
  UIManager um = UIManager.getInstance();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyPageModel());
    _onDataInputCheck();
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            Strings.appMy.tr(),
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: IconButton(
                onPressed: () => {context.pushNamed('SettingPage')},
                icon: Icon(
                  const Icon(FFIcons.ksettings).icon,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: dm.getMyInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 0.0),
                  child: Column(
                    children: [
                      if (dm.isLogin) userInfoContainer(context) else signInContainer(context),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget userInfoContainer(BuildContext context) {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiaryText,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dm.userModel!.username}',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).headlineMedium,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            //    ${dm.userModel!.userPersnalInfoMedel!.ageCategory ?? 'YOUNG_ADULT'}'
                            ('app_${dm.userModel!.userPersnalInfoMedel!.gender ?? 'gender'}').tr(),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).labelSmall,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (dm.userModel!.userFamilyMemberModels!.isNotEmpty)
                            Text(
                              Strings.appChild.tr(),
                              style: FlutterFlowTheme.of(context).headlineSmall,
                            ),
                          if (dm.userModel!.userFamilyMemberModels!.isNotEmpty)
                            const SizedBox(
                              height: 12,
                            ),
                          SizedBox(
                            height: 40,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (UserFamilyMemberModel member in dm.userModel!.userFamilyMemberModels!) profileChildListContainer(context, member.gender == 'MALE'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 24.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          'assets/images/img_thumbnail_profile_default.png',
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ClipRRect(
                child: Container(
                  width: double.infinity,
                  height: 45.0,
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: Strings.appAll.tr(),
                        icon: Image.asset('assets/images/imageicon/img_ic_doctor.png', width: 20.0, height: 20.0),
                        options: FFButtonOptions(
                          elevation: 0,
                          width: 86.0,
                          height: 46.0,
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (UserDiagnosisResultModel diagnosis in dm.userModel!.userDiagnosisResultModels!) diagnosisListItemContainer(context, diagnosis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container profileChildListContainer(BuildContext context, bool isMale) {
    String genderIconName = isMale ? 'boy' : 'girl';
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).disabledBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Image.asset(
        'assets/images/imageicon/img_ic_$genderIconName.png',
        width: 22,
        height: 22,
      ),
    );
  }

  Container diagnosisListItemContainer(BuildContext context, UserDiagnosisResultModel diagnosis) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      height: 84,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Stack(
                  // 화면 밖으로 넘어가는 부분을 보여준다. (overflow)
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).accent2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 18,
                      child: Image.asset(
                        'assets/images/icon/${um.getDiagnosisIcon(dm.getDiagnosisIdToSubject(diagnosis.diagnosisId!))}',
                        color: FlutterFlowTheme.of(context).primary,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Positioned(
                      left: 44,
                      top: 40,
                      child: Image.asset(
                        'assets/images/imageicon/img_ic_state_${um.getPrescriptionToSeverityLevel(diagnosis.prescriptions!)}.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      diagnosis.department!.toUpperCase(),
                      style: FlutterFlowTheme.of(context).titleSmall,
                    ),
                    Text(
                      um.getDateToYearMonthDay(diagnosis.createdAt!),
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (diagnosis.userFamilyMemberModel!.id != null)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 14),
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).disabledBackground,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(
                  'assets/images/imageicon/img_ic_boy.png',
                  width: 16,
                  height: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget signInContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        width: double.infinity,
        height: 164,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.appManageHealthDec.tr(),
                  style: FlutterFlowTheme.of(context).headlineMedium,
                  textAlign: TextAlign.center,
                ),
                FFButtonWidget(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
                      builder: (context) => LoginPopupWidget(loginCallbak: loginComplete),
                    );
                  },
                  text: Strings.appSignin.tr(),
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
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  showLoadingIndicator: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginComplete(bool isSuccess) {
    if (dm.userModel!.userPersnalInfoMedel!.gender == null && isSuccess) {
      context.pushNamed('TermsOfServicePage');
      setState(() {});
    }
  }

  Future<void> _onDataInputCheck() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (dm.isLogin && dm.userModel!.userPersnalInfoMedel!.gender == null && ModalRoute.of(context)!.settings.name != 'TermsOfServicePage') {
      context.pushNamed('TermsOfServicePage');
    }
  }
}
