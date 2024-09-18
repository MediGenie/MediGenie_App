import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medi_genie/backend/api_requests/api_manager.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:medi_genie/pages/ai_chat_page_widget.dart';
import 'package:medi_genie/provider/input_userinfo.dart';
import 'package:medi_genie/provider/mypage_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

void main() async {
  // 개발 모드일 때만 사용
  HttpOverrides.global = MyHttpOverrides();
  //
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await FlutterFlowTheme.initialize();

  await clearSecureStorageOnReinstall();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/langs/langs.csv',
      //startLocale: Locale('ko', 'KR'),
      assetLoader: CsvAssetLoader(),
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<InputUserInfo>(
            create: (_) => InputUserInfo(),
          ),
          ChangeNotifierProvider<MyPageInfo>(
            create: (_) => MyPageInfo(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

Future clearSecureStorageOnReinstall() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool isRunBefore = preferences.getBool(kHasRunBeforeSPKey) ?? false;
  if (!isRunBefore) {
    secureStorage.deleteAll();
    preferences.setBool(kHasRunBeforeSPKey, true);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MediGenie',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.light),
      themeMode: _themeMode,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

// 개발 모드일 때만 사용
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  // ignore: library_private_types_in_public_api
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  late Widget? _currentPage;
  String _currentPageName = 'MediGeniePage';

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'MediGeniePage': const MediGeniePageWidget(),
      'DiagosisPage': const DiagosisPageWidget(),
      'MyPage': const MyPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    ApiManager.setLocale(context.locale);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: FloatingNavbar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
          backgroundColor: const Color(0x00FFFFFF),
          selectedItemColor: FlutterFlowTheme.of(context).primaryText,
          unselectedItemColor: FlutterFlowTheme.of(context).disabledText,
          selectedBackgroundColor: const Color(0x00000000),
          borderRadius: 24.0,
          itemBorderRadius: 8.0,
          margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          width: double.infinity,
          elevation: 0.0,
          items: [
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    const Icon(FFIcons.khome).icon,
                    color: currentIndex == 0 ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).disabledText,
                    size: 24.0,
                  ),
                  Text(
                    Strings.appHome.tr(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 0 ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).disabledText,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    const Icon(FFIcons.kdiagnosis).icon,
                    color: currentIndex == 1 ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).disabledText,
                    size: 24.0,
                  ),
                  Text(
                    Strings.appDiagnosis.tr(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 1 ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).disabledText,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    const Icon(FFIcons.kmy).icon,
                    color: currentIndex == 2 ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).disabledText,
                    size: 24.0,
                  ),
                  Text(
                    Strings.appMy.tr(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 2 ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).disabledText,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
