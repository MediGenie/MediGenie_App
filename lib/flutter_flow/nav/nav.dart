import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_genie/pages/add_child_page_widget.dart';
import 'package:medi_genie/pages/addphoto_page_widget.dart';
import 'package:medi_genie/pages/diagnosis_test_page_widget.dart';
import 'package:medi_genie/pages/hearingtest_page_widget.dart';
import 'package:medi_genie/pages/result_loading_page_widget.dart';
import 'package:medi_genie/pages/testresult_page_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';
import '../../main.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) => const SplashPageWidget(),
      redirect: (context, state) {
        return null;
      },
      routes: [
        FFRoute(
          name: 'initialize',
          path: '/',
          builder: (context, params) => const SplashPageWidget(),
        ),
        FFRoute(
          name: 'MediGeniePage',
          path: '/mediGeniePage',
          builder: (context, params) => params.isEmpty ? const NavBarPage(initialPage: 'MediGeniePage') : const MediGeniePageWidget(),
        ),
        FFRoute(
          name: 'OnboardingPage',
          path: '/onboarding',
          builder: (context, params) => const OnboardingPageWidget(),
        ),
        FFRoute(
          name: 'SplashPage',
          path: '/splashPage',
          builder: (context, params) => const SplashPageWidget(),
        ),
        FFRoute(
          name: 'MyPage',
          path: '/myPage',
          builder: (context, params) => params.isEmpty ? const NavBarPage(initialPage: 'MyPage') : const MyPageWidget(),
        ),
        FFRoute(
          name: 'DiagosisPage',
          path: '/diagosisPage',
          builder: (context, params) => params.isEmpty ? const NavBarPage(initialPage: 'DiagosisPage') : const DiagosisPageWidget(),
        ),
        FFRoute(
          name: 'StartPage',
          path: '/startPage',
          builder: (context, params) => const StartPageWidget(),
        ),
        FFRoute(
          name: 'DiagnosisTestPage',
          path: '/DiagnosisTestPage',
          builder: (context, params) => DiagnosisTestPageWidget(
            heroRecommandIndex: params.state.uri.queryParameters['heroRecommandIndex'],
            selectDiagnosisIndex: params.state.uri.queryParameters['selectDiagnosisIndex'],
            selectDiagnosisCategory: params.state.uri.queryParameters['selectDiagnosisCategory'],
            selectDiagnosisSubject: params.state.uri.queryParameters['selectDiagnosisSubject'],
          ),
        ),
        FFRoute(
          name: 'SettingPage',
          path: '/settingPage',
          builder: (context, params) => const SettingPageWidget(),
        ),
        FFRoute(
          name: 'TermsOfServicePage',
          path: '/termsOfServicePage',
          builder: (context, params) => const TermsOfServicePageWidget(),
        ),
        FFRoute(
          name: 'QuestionPage',
          path: '/questionPage',
          builder: (context, params) => QuestionPageWidget(
            orderIndex: params.state.uri.queryParameters['orderIndex'],
          ),
        ),
        FFRoute(
          name: 'AddPhotoPage',
          path: '/addPhotoPage',
          builder: (context, params) => AddPhotoPageWidget(),
        ),
        FFRoute(
          name: 'TestResultPage',
          path: '/testResultPage',
          builder: (context, params) => TestResultPageWidget(
            index: params.state.uri.queryParameters['index'],
            result: params.state.uri.queryParameters['result'],
          ),
        ),
        FFRoute(
          name: 'HearingTestPage',
          path: '/hearingTestPage',
          builder: (context, params) => HearingTestPageWidget(),
        ),
        FFRoute(
          name: 'ResultLoadingPage',
          path: '/resultLoadingPage',
          builder: (context, params) => const ResultLoadingPageWidget(),
        ),
        FFRoute(
          name: 'AddChildPage',
          path: '/addChildPage',
          builder: (context, params) => const AddChildPageWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      //urlPathStrategy: UrlPathStrategy.path,
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value!)),
      );
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap => extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey) ? extraMap[kTransitionInfoKey] as TransitionInfo : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty => state.allParams.isEmpty || (state.extraMap.length == 1 && state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) => asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value).onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}
