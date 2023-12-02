import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_theme.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/provider/input_userinfo.dart';
import 'package:provider/provider.dart';

class GenderInputPageWidget extends StatefulWidget {
  final PageController pageController;
  const GenderInputPageWidget({
    super.key,
    required PageController pageController,
  })  : pageController = pageController;

  @override
  State<GenderInputPageWidget> createState() => _GenderInputPageWidgetState();
}

class _GenderInputPageWidgetState extends State<GenderInputPageWidget> {
  // 0 - 선택 안함, 1 - 남자, 2 - 여자
  int _genderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.appWhatGender.tr(),
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
          SizedBox(
            width: double.infinity,
            height: 400.0,
            child: GridView(
              padding: EdgeInsets.zero,
              primary: false,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1.0,
              ),
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _genderIndex = 1;
                      context.read<InputUserInfo>().setGender(gender: _genderIndex);
                      widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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
                        color: _genderIndex == 1
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).disabledBackground,
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
                              'assets/images/imageicon/img_ic_male.png',
                              width: 32.0,
                              height: 32.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          Strings.appMale.tr(),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _genderIndex = 2;
                      context.read<InputUserInfo>().setGender(gender: _genderIndex);
                      widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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
                        color: _genderIndex == 2
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).disabledBackground,
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
                              'assets/images/imageicon/img_ic_female.png',
                              width: 32.0,
                              height: 32.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          Strings.appFemale.tr(),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
