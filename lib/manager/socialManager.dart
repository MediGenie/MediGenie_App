import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medi_genie/backend/api_requests/api_calls.dart';
import 'package:medi_genie/backend/api_requests/api_manager.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:medi_genie/model/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';

enum SocialType {
  GOOGLE('GOOGLE'),
  APPLE('APPLE'),
  NONE('NONE');

  final String value;

  const SocialType(this.value);

  static void setSocialType({required SocialType type}) {
    SocialManager.socialType = type;
    const FlutterSecureStorage().write(
      key: 'socialType',
      value: type.value,
    );
  }
}

const List<String> scopes = <String>[
  'email',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId

  scopes: scopes,
);

class SocialManager {
  static SocialType socialType = SocialType.NONE;
  static final SocialManager _instance = SocialManager._internal();
  factory SocialManager() => _instance;
  SocialManager._internal();

  static SocialManager getInstance() {
    return _instance;
  }

  Future<void> loginWithApple({required Function(bool) callback}) async {
    bool isAppleLogin = false;
    final clientState = const Uuid().v4();
    if (await SignInWithApple.isAvailable()) {
      try {
        final appleIdCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'medi.medigenie.com',
            redirectUri: Uri.parse(
              'https://api.aiplaza.kr/api/apple/redirect',
            ),
          ),
          state: clientState, //<---- 여기에 앱으로 돌아갈 앱링크, 딥링크를 넣으셔야됩니다.
        );

        logger.d(appleIdCredential);
        logger.d(appleIdCredential.authorizationCode);
        logger.d(appleIdCredential.email);
        logger.d(appleIdCredential.identityToken);

        List<String> jwt = appleIdCredential.identityToken?.split('.') ?? [];
        String payload = jwt[1];
        payload = base64.normalize(payload);

        final List<int> jsonData = base64.decode(payload);
        final userInfo = jsonDecode(utf8.decode(jsonData));

        final response = await GetAppleLoginCall.call(
          code: appleIdCredential.authorizationCode,
          email: userInfo['email'],
        );
        logger.d(response.response!.body);
        final accessToken = await socialTokenValidate(response);
        const FlutterSecureStorage().write(
          key: 'appleIdCredential',
          value: appleIdCredential.userIdentifier,
        );
        SocialType.setSocialType(type: SocialType.APPLE);
        const FlutterSecureStorage().write(key: 'appleAccessToken', value: accessToken);

        isAppleLogin = true;
        callback(isAppleLogin);
      } catch (e) {
        logger.d('error = $e');
        // if (e.runtimeType != '_Type') {
        //   SignInWithAppleAuthorizationException exception = e as SignInWithAppleAuthorizationException;
        //   switch (exception.code) {
        //     case AuthorizationErrorCode.canceled:
        //       print('User canceled authorization');
        //       break;
        //     case AuthorizationErrorCode.failed:
        //       print('Authorization failed');
        //       break;
        //     case AuthorizationErrorCode.invalidResponse:
        //       print('Invalid response');
        //       break;
        //     case AuthorizationErrorCode.notHandled:
        //       print('Authorization not handled');
        //       break;
        //     case AuthorizationErrorCode.notInteractive:
        //       print('Authorization not interactive');
        //       break;
        //     case AuthorizationErrorCode.unknown:
        //       print('Authorization unknown');
        //       break;
        //   }
        // }
      }
    }
    //SignInWithApple.getCredentialState(userIdentifier)
  }

  void appleLogout({required Function() callback}) async {
    await const FlutterSecureStorage().delete(key: 'appleIdCredential');
    await const FlutterSecureStorage().delete(key: 'appleAccessToken');
    SocialType.setSocialType(type: SocialType.NONE);
  }

  Future<void> appleLoginCheck({required Function(bool) callback}) async {
    bool isSeccess = false;
    // FlutterSecureStorage().delete(key: 'appleIdCredential');
    // FlutterSecureStorage().delete(key: 'appleAccessToken');
    final userId = await const FlutterSecureStorage().read(key: 'appleIdCredential');
    final accessToken = await const FlutterSecureStorage().read(key: 'appleAccessToken');
    if (userId == null) {
      logger.d("not apple login");
      await loginWithApple(callback: callback);
      isSeccess = true;
    } else {
      final credentialState = await SignInWithApple.getCredentialState(userId);
      switch (credentialState) {
        case CredentialState.authorized:
          {
            print('apple authorized - 1');
            logger.d(accessToken);
            ApiManager.setToken(accessToken!);
            print('apple authorized - 2');
            DataManager.getInstance().isLogin = true;
            print('apple authorized - 3');
            isSeccess = true;
            break;
          }
        case CredentialState.notFound:
          print('notFound');
          break;
        case CredentialState.revoked:
          print('revoked');
          break;
      }
    }
    await callback(isSeccess);
  }

  Future<void> loginWithGoogle({required Function(bool) callback}) async {
    bool isSeccess = false;
    try {
      _googleSignIn.isSignedIn().then((isLogin) async {
        if (!isLogin) {
          await _googleSignIn.signIn().then((result) {
            if (result != null) {
              result.authentication.then((googleKey) async {
                String? accessToken = googleKey.accessToken;
                String? token = googleKey.idToken;
                logger.d(accessToken);
                logger.d(token);
                final response = await GetGoogleLoginCall.call(token: accessToken);
                String saveToken = await socialTokenValidate(response);
                const FlutterSecureStorage().write(
                  key: 'googleIdToken',
                  value: saveToken,
                );
              });
            }
            isSeccess = true;
          }).catchError((err) {
            // ignore: prefer_interpolation_to_compose_strings
            logger.d('Err' + err.toString());
          });
        } else {
          String token = await const FlutterSecureStorage().read(key: 'googleIdToken') ?? "";
          logger.d(token);
          ApiManager.setToken(token);
          DataManager.getInstance().isLogin = true;
        }
        SocialType.setSocialType(type: SocialType.GOOGLE);
        await callback(isSeccess);
      });
    } catch (error) {
      logger.d(error);
    }
  }

  void googleLogout({required Function() callback}) async {
    _googleSignIn.isSignedIn().then((isLogin) async {
      if (isLogin) {
        await _googleSignIn.signOut();
        await const FlutterSecureStorage().delete(key: 'googleIdToken');
        DataManager.getInstance().isLogin = false;
        callback();
        logger.d('google logout');
      }
    });
  }

  Future<void> socailLogin({required Function(bool) callback}) async {
    final type = await const FlutterSecureStorage().read(key: 'socialType');
    logger.d(type);
    switch (type) {
      case 'GOOGLE':
        await loginWithGoogle(callback: callback);
        break;
      case 'APPLE':
        await appleLoginCheck(callback: callback);
        break;
      case 'NONE':
        break;
    }
  }

  void socialLogout({required Function() callback}) async {
    final type = await const FlutterSecureStorage().read(key: 'socialType');

    switch (type) {
      case 'GOOGLE':
        googleLogout(callback: callback);
        break;
      case 'APPLE':
        appleLogout(callback: callback);
        break;
      case 'NONE':
        break;
    }
  }

  Future<String> socialTokenValidate(ApiCallResponse response) async {
    var responseJson;
    var userResponse;
    if (response.succeeded) {
      responseJson = await jsonDecode(response.response?.body ?? "")['jwt'];
      userResponse = await jsonDecode(response.response?.body ?? "")['user'];
      DataManager.getInstance().userModel = UserModel.fromJson(userResponse);
      ApiManager.setToken(responseJson);
      DataManager.getInstance().isLogin = true;
      logger.d(responseJson);
      logger.d(userResponse);
    }
    return responseJson;
  }

  Future<bool> isSocialLogin() async {
    bool isLogin = false;
    final type = await const FlutterSecureStorage().read(key: 'socialType');
    switch (type) {
      case 'GOOGLE':
        isLogin = await const FlutterSecureStorage().containsKey(key: 'googleIdToken');
        break;
      case 'APPLE':
        isLogin = false; //await const FlutterSecureStorage().containsKey(key: 'appleIdCredential');
        break;
      case 'NONE':
        break;
    }
    print("------------ isLogin -> $isLogin");
    return isLogin;
  }
}
