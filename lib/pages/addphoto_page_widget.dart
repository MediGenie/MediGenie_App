import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/flutter_flow/flutter_flow_widgets.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/manager/uiManager.dart';
import 'package:medi_genie/model/testing_model.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '../model/question_page_model.dart';
export '../model/question_page_model.dart';

// ignore: must_be_immutable
class AddPhotoPageWidget extends StatefulWidget {
  String? orderIndex;
  AddPhotoPageWidget({
    Key? key,
    String? orderIndex,
  }) : super(key: key) {
    this.orderIndex = orderIndex;
  }

  @override
  _AddPhotoPageWidgetState createState() => _AddPhotoPageWidgetState();
}

class _AddPhotoPageWidgetState extends State<AddPhotoPageWidget> {
  late QuestionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  DataManager dm = DataManager.getInstance();
  // 문진 순서 인덱스
  int testingIndex = 2;
  // 질문 순서 인덱스
  int qustionIndex = 0;
  int photoCount = 0;
  PageController pageController = PageController(initialPage: 0);

  List<dynamic> apm = [];
  AddPhotoTestModel apModel = AddPhotoTestModel();

  List<ConsultContainer> consultInfo = [];

  List<XFile>? _imageFileList = [];

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuestionPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    apm = dm.diagnosisTestData['addphoto'];
    apModel = AddPhotoTestModel.formJson(apm.first);
    testingIndex = apModel.index!;
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
                        qustionIndex = count;
                      }),
                      scrollDirection: Axis.horizontal,
                      children: [
                        questionContainer(context),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                children: [
                                  Stack(
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          _onImageButtonPressed(
                                            ImageSource.gallery,
                                            context: context,
                                            isMultiImage: true,
                                          );
                                        },
                                        text: Strings.appAddPhoto.tr(),
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 64.0,
                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                          textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: FlutterFlowTheme.of(context).disabledText,
                                              ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).disabledBackground,
                                            style: BorderStyle.solid,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        showLoadingIndicator: false,
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(-0.42, 0.0),
                                        heightFactor: 2.6,
                                        child: Icon(
                                          const Icon(FFIcons.kadd).icon,
                                          color: FlutterFlowTheme.of(context).disabledText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            !kIsWeb && defaultTargetPlatform == TargetPlatform.windows
                                ? FutureBuilder<void>(
                                    future: retrieveLostData(),
                                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return Text(
                                            'You have not yet picked an image.',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context).labelMedium,
                                          );
                                        case ConnectionState.done:
                                          return _handlePreview();
                                        case ConnectionState.active:
                                          if (snapshot.hasError) {
                                            return Text(
                                              'Pick image/video error: ${snapshot.error}}',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(context).labelMedium,
                                            );
                                          } else {
                                            return Text(
                                              'You have not yet picked an image.',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(context).labelMedium,
                                            );
                                          }
                                      }
                                    },
                                  )
                                : _handlePreview(),
                          ],
                        ),
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
                          onPressed: GetConsultNext() && qustionIndex == 0
                              ? () async {
                                  await pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                }
                              : photoCount > 0
                                  ? () async {
                                      final List<MultipartFile> files = _imageFileList!.map((img) => MultipartFile.fromFileSync(img.path, contentType: MediaType("image", "jpg"))).toList();

                                      FormData formData = FormData.fromMap({"files": files});
                                      final images = await PostImageUploadCall.call(formData);
                                      UIManager.getInstance().currentDiagnosis!.images = images;
                                      if (dm.diagnosisTestData.length == testingIndex + 1) {
                                        PostDiagnosisResultCall.call(DataManager.getInstance().setTempData()).then(
                                          (value) => {
                                            //context.pop(),
                                            context.pushNamed(
                                              dm.getNextDiagnosisPageName(testingIndex),
                                              queryParameters: {
                                                'index': '$testingIndex',
                                                'result': value.response!.body,
                                              },
                                            )
                                          },
                                        );
                                        // await context.pushNamed(
                                        //   'ResultLoadingPage',
                                        //   queryParameters: {
                                        //     'nextScreenName': '${dm.getNextDiagnosisPageName(testingIndex)}',
                                        //   },
                                        // );
                                        //await Future.delayed(Duration(seconds: 1));
                                      } else {
                                        await context.pushNamed(
                                          dm.getNextDiagnosisPageName(testingIndex),
                                          queryParameters: {
                                            'index': '$testingIndex',
                                          },
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
                            borderRadius: BorderRadius.circular(20.0),
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
      ),
    );
  }

  SizedBox questionContainer(BuildContext context) {
    consultInfo.addAll([
      ConsultContainer(index: 0, onPressed: Refresh),
      ConsultContainer(index: 1, onPressed: Refresh),
    ]);
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  consultInfo[0],
                  consultInfo[1],
                ],
              ),
            ],
          ),
        ],
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
          Text(
            '${apModel.questions![qustionIndex].question}',
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          if (apModel.questions![qustionIndex].subtitle != '')
            AutoSizeText(
              '${apModel.questions![qustionIndex].subtitle}',
              maxLines: 2,
              style: FlutterFlowTheme.of(context).labelMedium,
            ),
          if (apModel.questions![qustionIndex].subtitle != '')
            const SizedBox(
              height: 20,
            ),
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
            color: index == testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: index == testingIndex ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).disabledBackground,
              width: 1,
            ),
          ),
          child: Text(
            '$index',
            textAlign: TextAlign.center,
            style: index == testingIndex
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
          child: Text(
            index == testingIndex ? '${value[0]['title']}' : '',
            style: FlutterFlowTheme.of(context).labelMedium,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  void Refresh() {
    setState(() {
      photoCount = _imageFileList!.length;
    });
  }

  bool GetConsultNext() {
    for (int i = 0; i < consultInfo.length; i++) {
      if (consultInfo[i].isPressed == true) {
        return true;
      }
    }
    return false;
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Future<void> _onImageButtonPressed(ImageSource source, {required BuildContext context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
      if (isVideo) {
        final XFile? file = await _picker.pickVideo(
          source: source,
          maxDuration: const Duration(seconds: 10),
        );
        await _playVideo(file);
      } else if (isMultiImage) {
        {
          try {
            final double? width = maxWidthController.text.isNotEmpty ? double.parse(maxWidthController.text) : null;
            final double? height = maxHeightController.text.isNotEmpty ? double.parse(maxHeightController.text) : null;
            //final int? quality = qualityController.text.isNotEmpty ? int.parse(qualityController.text) : null;
            final List<XFile> pickedFileList = await _picker.pickMultiImage(
              maxWidth: width,
              maxHeight: height,
              imageQuality: 1,
            );
            setState(
              () {
                _imageFileList = pickedFileList;
              },
            );
          } catch (e) {
            setState(
              () {
                print(e);
                _pickImageError = e;
              },
            );
          }
        }
      } else {
        await _displayPickImageDialog(
          context,
          (double? maxWidth, double? maxHeight, int? quality) async {
            try {
              final XFile? pickedFile = await _picker.pickImage(
                source: source,
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                imageQuality: quality,
              );
              setState(() {
                _setImageFileListFromFile(pickedFile);
              });
            } catch (e) {
              setState(
                () {
                  _pickImageError = e;
                },
              );
            }
          },
        );
      }
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add optional parameters'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: maxWidthController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(hintText: 'Enter maxWidth if desired'),
              ),
              TextField(
                controller: maxHeightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(hintText: 'Enter maxHeight if desired'),
              ),
              TextField(
                controller: qualityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Enter quality if desired'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('PICK'),
              onPressed: () {
                final double? width = maxWidthController.text.isNotEmpty ? double.parse(maxWidthController.text) : null;
                final double? height = maxHeightController.text.isNotEmpty ? double.parse(maxHeightController.text) : null;
                final int? quality = qualityController.text.isNotEmpty ? int.parse(qualityController.text) : null;
                onPick(width, height, quality);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _handlePreview() {
    if (isVideo) {
      return _previewImages();
    } else {
      Refresh();
      return _previewImages();
    }
  }

  Widget _previewImages() {
    print(_imageFileList);
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            // Why network for web?
            // See https://pub.dev/packages/image_picker_for_web#limitations-on-the-web-platform
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: kIsWeb
                        ? Image.network(
                            _imageFileList![index].path,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          )
                        : Image.file(
                            File(_imageFileList![index].path),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => const Center(child: Text('This image type is not supported')),
                          ),
                  ),
                  IconButton(
                    padding: const EdgeInsetsDirectional.fromSTEB(66, 0, 0, 0),
                    onPressed: () {},
                    icon: Icon(
                      const Icon(FFIcons.kcloseCircle).icon,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          if (response.files == null) {
            _setImageFileListFromFile(response.file);
          } else {
            _imageFileList = response.files;
          }
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }
}

typedef OnPickImageCallback = void Function(double? maxWidth, double? maxHeight, int? quality);

// ignore: must_be_immutable
class ConsultContainer extends StatefulWidget {
  final int index;
  final onPressed;
  bool isPressed = false;

  ConsultContainer({
    Key? key,
    required this.index,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ConsultContainer> createState() => _ConsultContainerState();
}

class _ConsultContainerState extends State<ConsultContainer> {
  @override
  Widget build(BuildContext context) {
    String type = (widget.index == 0 ? 'left' : 'right');
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isPressed = !widget.isPressed;
          UIManager.getInstance().currentDiagnosis!.earPos = type;
          widget.onPressed();
        });
      },
      child: Container(
        width: 154.0,
        height: 154.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: widget.isPressed ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).disabledBackground,
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
                  'assets/images/imageicon/img_ic_ear-$type.png',
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              type,
              style: FlutterFlowTheme.of(context).labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
