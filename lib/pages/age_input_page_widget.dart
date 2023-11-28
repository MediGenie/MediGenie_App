import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_theme.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/provider/input_userinfo.dart';
import 'package:provider/provider.dart';

class AgeInputPageWidget extends StatefulWidget {
  final PageController pageController;
  const AgeInputPageWidget({
    super.key,
    required PageController pageController,
  }) : pageController = pageController;

  @override
  State<AgeInputPageWidget> createState() => _AgeInputPageWidgetState();
}

class _AgeInputPageWidgetState extends State<AgeInputPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    logger.d('AgeInputPageWidget = $scaffoldKey');
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 0.0),
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
            height: 250,
            child: CupertinoDatePicker(
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2000, 1, 1),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  context.read<InputUserInfo>().setBirthDate(birthDate: newDateTime);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
