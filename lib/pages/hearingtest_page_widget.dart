import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_widgets.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/testing_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '../model/question_page_model.dart';
export '../model/question_page_model.dart';

// ignore: must_be_immutable
class HearingTestPageWidget extends StatefulWidget {
  String? orderIndex;
  HearingTestPageWidget({
    super.key,
    String? orderIndex,
  }) {
    this.orderIndex = orderIndex;
  }

  @override
  _HearingTestPageWidgetState createState() => _HearingTestPageWidgetState();
}

class _HearingTestPageWidgetState extends State<HearingTestPageWidget> {
  late QuestionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DataManager dm = DataManager.getInstance();
  int _testingIndex = 2;
  int questionIndex = 0;
  int hearingAudioTestCount = 0;
  bool isHearingStart = false;
  PageController pageController = PageController(initialPage: 0);
  PageController hearingPageController = PageController(initialPage: 0);

  AudioPlayer audioPlayer = AudioPlayer();

  int mainVolume = 0;
  bool isHearOK = false;

  List<dynamic> hm = [];
  HearingTestModel hModel = HearingTestModel();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuestionPageModel());
    audioPlayer.setAudioContext(const AudioContext(
      android: AudioContextAndroid(),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: [
          AVAudioSessionOptions.allowBluetooth,
          AVAudioSessionOptions.allowBluetoothA2DP,
          AVAudioSessionOptions.allowAirPlay,
        ],
      ),
    ));
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    //audioPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hm = dm.diagnosisTestData['hearingtest'];
    hModel = HearingTestModel.formJson(hm.first);
    _testingIndex = hModel.index!;
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
        flexibleSpace: appBarMenuContainer(),
        centerTitle: false,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: IconButton(
              onPressed: () => {
                UIManager.getInstance().diagnosisLeaveAlert(
                  context,
                ),
              },
              icon: Icon(
                const Icon(FFIcons.kclose).icon,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              questionTitleContainer(context),
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (count) => setState(() {
                      questionIndex = count;
                    }),
                    scrollDirection: Axis.horizontal,
                    children: [
                      // hearingProgress - 귀검사 기본 프로세스 리스트, questionIndex 가 여기에 들어가서 진행됨. stepcount - 총 소리 갯수, 0 이면 진행 안됨, hearing - 비어있을때 진행 안됨
                      // audioSound - 귀검사 진행시 나오는 소리 리스트
                      for (int i = 0; i < hModel.hearingProgress!.length; i++)
                        if (hModel.hearingProgress![i].progressType! == "text") startHearingContainer(context) else testingBeepButton(context, hModel.hearingProgress![i])
                      // testingBeepButton(context),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        // 텍스트 질문 시에는 다음 질문으로 넘어감
                        onPressed: questionIndex == 0 || questionIndex == 2
                            ? () async {
                                if (questionIndex == 0) {
                                  await pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                  //_hearingTestSoundStart(hearingAudioTestCount);
                                } else if (questionIndex == 2) {
                                  await pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                  //_hearingTestSoundStart(hearingAudioTestCount);
                                }
                              }
                            // 청력 검사는 끝나고 5번째 질문은 다음 스텝으로 넘어갈 수 있음
                            : questionIndex == 4
                                ? () async {
                                    audioStop();
                                    if (dm.diagnosisTestData.length == _testingIndex + 1) {
                                      PostDiagnosisResultCall.call(DataManager.getInstance().setTempData()).then(
                                        (value) => {
                                          if (value.statusCode == 200)
                                            {
                                              context.pushNamed(
                                                dm.getNextDiagnosisPageName(_testingIndex),
                                                queryParameters: {
                                                  'index': '$_testingIndex',
                                                  'result': value.response!.body,
                                                },
                                              ),
                                            },
                                        },
                                      );
                                    } else {
                                      context.pushNamed(
                                        dm.getNextDiagnosisPageName(_testingIndex),
                                        queryParameters: {
                                          'index': '$_testingIndex',
                                        },
                                      );
                                    }
                                  }
                                //}
                                // 오디오 검사 시작하니깐 페이지뷰를 다른걸로 써야 함. 그리고 오디오 검사가 끝나면 다음 질문으로 넘어감
                                : (questionIndex == 1 || questionIndex == 3) & isHearingStart & (mainVolume > 0)
                                    ? () async {
                                        hearingTestEnd();
                                        if (hModel.hearingProgress![questionIndex].stepCount! > (hearingAudioTestCount + 1)) {
                                          await hearingPageController.nextPage(
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        } else {
                                          hearingAudioTestCount = 0;
                                          await pageController.nextPage(
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        }
                                      }
                                    : null,
                        text: Strings.appContinue.tr(),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
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
                          disabledColor: FlutterFlowTheme.of(context).disabledBackground,
                          disabledTextColor: FlutterFlowTheme.of(context).disabledText,
                        ),
                        showLoadingIndicator: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container questionTitleContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            '${hModel.hearingProgress?[questionIndex].question}',
            textAlign: TextAlign.start,
            maxLines: 3,
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          if (hModel.hearingProgress![questionIndex].subtitle != null)
            AutoSizeText(
              '${hModel.hearingProgress![questionIndex].subtitle}',
              maxLines: 2,
              style: FlutterFlowTheme.of(context).labelMedium,
            ),
          if (hModel.hearingProgress![questionIndex].subtitle != null)
            const SizedBox(
              height: 20,
            )
        ],
      ),
    );
  }

  Container appBarMenuContainer() {
    int index = 1;
    return Container(
      width: double.infinity,
      //height: kToolbarHeight,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var item in dm.diagnosisTestData.entries)
            if (item.key != 'startmenu')
              startMenuContainer(
                item.key,
                item.value,
                index++,
              ),
        ],
      ),
    );
  }

  Row startMenuContainer(String key, dynamic value, int index) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: index == _testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: index == _testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).disabledBackground,
              width: 1,
            ),
          ),
          child: Text(
            '$index',
            textAlign: TextAlign.center,
            style: index == _testingIndex
                ? FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: FlutterFlowTheme.of(context).tertiaryText,
                    )
                : FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: FlutterFlowTheme.of(context).disabledText,
                    ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          child: Text(index == _testingIndex ? '${value[0]['title']}' : '', style: FlutterFlowTheme.of(context).labelMedium),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  void Refresh() {
    setState(() {});
  }

  Widget startHearingContainer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/images/img_connectearphones.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget testingBeepButton(BuildContext context, HearingProgressModel hearingProgressModel) {
    return PageView(
      controller: hearingPageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        hearingAudioTestCount = value;
        logger.d("hraingAudioTestCount : $hearingAudioTestCount");
        //logger.d('_audioModel : ${_hearingProgressModel.frequency}');
      },
      children: [
        for (int i = 0; i < hearingProgressModel.audioSound!.length; i++) audioProgess(context, hearingProgressModel.audioSound![i]),
      ],
    );
  }

  SizedBox audioProgess(BuildContext context, HearingAudioModel audioModel) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                SleekCircularSlider(
                  innerWidget: (double value) {
                    return Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              '$mainVolume %',
                              style: FlutterFlowTheme.of(context).displayLarge.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '${audioModel.frequency}Hz',
                              style: FlutterFlowTheme.of(context).displayLarge.override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(
                        trackWidth: 2,
                        progressBarWidth: 20,
                        shadowWidth: 50,
                      ),
                      customColors: CustomSliderColors(
                          dotColor: Colors.white.withOpacity(0.8),
                          trackColor: FlutterFlowTheme.of(context).divider,
                          progressBarColors: [
                            FlutterFlowTheme.of(context).primary,
                            FlutterFlowTheme.of(context).primary,
                            FlutterFlowTheme.of(context).primary,
                          ],
                          shadowColor: HexColor('#FFD7E2'),
                          shadowMaxOpacity: 0.08),
                      startAngle: 145,
                      angleRange: 250,
                      size: 260.0),
                  initialValue: mainVolume.toDouble(),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  if (mainVolume >= 10) mainVolume -= 10;
                  mainVolumeControl(mainVolume);
                  setState(() {});
                },
                text: '-',
                options: FFButtonOptions(
                  width: 64.0,
                  height: 64.0,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 40,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).divider,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                  disabledColor: FlutterFlowTheme.of(context).disabledBackground,
                  disabledTextColor: FlutterFlowTheme.of(context).disabledText,
                ),
                showLoadingIndicator: false,
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (mainVolume == 0 && !isHearingStart) hearingTestSoundStart(audioModel.step!);
                  if (mainVolume <= 90) mainVolume += 10;
                  mainVolumeControl(mainVolume);
                  setState(() {});
                },
                text: '+',
                options: FFButtonOptions(
                  width: 64.0,
                  height: 64.0,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Plus Jakarta Sans',
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 40,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).divider,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                  disabledColor: FlutterFlowTheme.of(context).disabledBackground,
                  disabledTextColor: FlutterFlowTheme.of(context).disabledText,
                ),
                showLoadingIndicator: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> hearingTestSoundStart(int index) async {
    isHearingStart = true;

    HearingAudioModel audio = hModel.hearingProgress![questionIndex].audioSound![index];
    logger.d('sound : ${audio.frequency}Hz');
    String ear = hModel.hearingProgress![questionIndex].progressType == 'right' ? 'R' : 'L';
    String audioName = '${audio.frequency}Hz_$ear.mp3';
    audioStart(audioName);
  }

  void mainVolumeControl(int value) {
    double vol = value / 100.0;
    audioPlayer.setVolume(vol);
    //setState(() {});
  }

  void audioStart(String audioName) {
    audioPlayer.setVolume(mainVolume / 100);

    audioPlayer.play(AssetSource('audios/$audioName'));
  }

  void audioStop() {
    audioPlayer.stop();
  }

  void hearingTestEnd() {
    isHearingStart = false;
    mainVolume = 0;
    audioPlayer.stop();
    setState(() {});
  }

  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Hearing Test'),
  //       content: Text('Are you ready to start the hearing test?'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: Text('No'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, true),
  //           child: Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

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
