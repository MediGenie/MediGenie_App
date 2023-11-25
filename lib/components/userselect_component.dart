import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_util.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/user_model.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserSelectComponenetWidget extends StatefulWidget {
  Function? loginCallbak = () {};
  UserSelectComponenetWidget({Key? key, Function? loginCallbak}) : super(key: key) {
    this.loginCallbak = loginCallbak;
  }

  @override
  _UserSelectComponenetWidgetState createState() => _UserSelectComponenetWidgetState();
}

class _UserSelectComponenetWidgetState extends State<UserSelectComponenetWidget> {
  int selectValue = -1;
  DataManager dm = DataManager.getInstance();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              child: Divider(
                color: FlutterFlowTheme.of(context).divider,
                thickness: 4.0,
                indent: 150.0,
                endIndent: 150.0,
                height: 4.0,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Strings.appMemberSelectDec.tr(),
                    style: FlutterFlowTheme.of(context).displaySmall,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profileChildListContainer(context, UserFamilyMemberModel(id: 0, name: dm.userModel!.username)),
                for (UserFamilyMemberModel member in dm.userModel!.userFamilyMemberModels!)
                  profileChildListContainer(context, member),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget profileChildListContainer(BuildContext context, UserFamilyMemberModel member) {
    String genderIconName = member.id == 0
        ? 'skin'
        : member.gender == 'MALE'
            ? 'boy'
            : 'girl';
    String memberName = member.id == 0 ? dm.userModel!.username! : member.name!;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 52,
            child: Row(
              children: [
                Container(
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
                ),
                Text(
                  memberName,
                  style: FlutterFlowTheme.of(context).labelLarge,
                ),
              ],
            ),
          ),
          Radio(
            value: member.id!,
            groupValue: selectValue,
            onChanged: (value) async {
              setState(
                () {
                  logger.d("value ====== $value");
                  selectValue = value as int;
                  UIManager.getInstance().currentDiagnosis!.memberId = selectValue;
                },
              );
              await Future.delayed(const Duration(milliseconds: 200));
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
