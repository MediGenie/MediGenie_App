import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:medi_genie/backend/api_requests/api_manager.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_theme.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/provider/input_userinfo.dart';
import 'package:provider/provider.dart';

class NameInputPageWidget extends StatefulWidget {
  final PageController pageController;
  const NameInputPageWidget({
    super.key,
    required PageController pageController,
  }) : pageController = pageController;

  @override
  State<NameInputPageWidget> createState() => _NameInputPageWidgetState();
}

class _NameInputPageWidgetState extends State<NameInputPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DataManager dm = DataManager.getInstance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.appChildNameDec.tr(),
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).displayMedium,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            Strings.appInformationInput.tr(),
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          const SizedBox(
            height: 26.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameInputOrder(context, false),
              nameInputOrder(context, true),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox nameInputOrder(BuildContext context, bool isFirstName) {
    if (ApiManager.locale!.countryCode == 'US') isFirstName = !isFirstName;
    print(ApiManager.locale!.countryCode);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.43,
      height: 60.0,
      child: MaterialTextField(
        // autoFocus: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabled: true,
        keyboardType: TextInputType.name,
        hint: isFirstName ? Strings.appDoe.tr() : Strings.appJohn.tr(),
        labelText: isFirstName ? Strings.appFirstName.tr() : Strings.appLastName.tr(),
        textInputAction: TextInputAction.next,
        theme: FilledOrOutlinedTextTheme(
          floatingLabelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Plus Jakarta Sans',
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
          enabledColor: FlutterFlowTheme.of(context).divider,
          focusedColor: FlutterFlowTheme.of(context).divider,
          fillColor: Colors.transparent,
          radius: 16,
        ),
        //validator: FormValidation.requiredTextField,
        validator: (value) {
          if (value!.isEmpty) {
            return Strings.appValidName.tr();
          }
          return null;
        },
        onChanged: (value) {
          if (!isFirstName) {
            context.read<InputUserInfo>().setFirstName(firstName: value);
          } else {
            context.read<InputUserInfo>().setLastName(lastName: value);
          }
        },
        // onFieldSubmitted: (value) async {
        //   if (isFirstName) widget.pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        // },
      ),
    );
  }
}
