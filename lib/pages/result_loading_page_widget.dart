import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ResultLoadingPageWidget extends StatefulWidget {
  const ResultLoadingPageWidget({Key? key}) : super(key: key);

  @override
  _ResultLoadingPageWidgetState createState() => _ResultLoadingPageWidgetState();
}

class _ResultLoadingPageWidgetState extends State<ResultLoadingPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1E2429),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SleekCircularSlider(
                appearance: appearance07,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final customWidth07 = CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors07 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.1),
    trackColor: HexColor('#7EFFFF').withOpacity(0.2),
    progressBarColors: [HexColor('#17C5E5'), HexColor('#DFFF97'), HexColor('#04FFB5')],
    shadowColor: HexColor('#0CA1BD'),
    shadowMaxOpacity: 0.05);

final CircularSliderAppearance appearance07 = CircularSliderAppearance(
    customWidths: customWidth07, customColors: customColors07, startAngle: 180, angleRange: 360, size: 130.0, spinnerMode: true);

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
