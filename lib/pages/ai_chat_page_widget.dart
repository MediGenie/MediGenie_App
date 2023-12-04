import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:medi_genie/backend/stream_client.dart';
import 'package:medi_genie/localization/strings.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:medi_genie/manager/dataManager.dart';
import 'package:http/http.dart' as http;

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';

class AiChatPageWidget extends StatefulWidget {
  const AiChatPageWidget({super.key});

  @override
  State<AiChatPageWidget> createState() => _AiChatPageWidgetState();
}

class _AiChatPageWidgetState extends State<AiChatPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  String _gptStreamText = '';
  int _gptStreamResultIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    _handleChat();
    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0x00ECEEF0),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Text(
            Strings.appDiagnosis.tr(),
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Chat(
          theme: const DefaultChatTheme(
            inputBackgroundColor: Color(0xFF1E2429),
            inputTextColor: Color(0xFFECEEF0),
            primaryColor: Color(0xFF1E2429),
            secondaryColor: Color(0xFF1E2429),
            sendButtonIcon: Icon(
              Icons.send,
              color: Color(0xFFECEEF0),
            ),
          ),
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      ),
    );
  }

  Future<void> _handleChat() async {
    try {
      print("handleChat");
      try {
        final stream = sendMessageStream("test");
        await for (final textChunk in stream) {
          setState(() {
            _gptStreamText += textChunk;
          });
        }
        print(_gptStreamText);
      } catch (exception) {
        print(exception.toString());
      }
    } catch (error) {
      logger.d(error);
    }
  }

  // Send Message to ChatGPT and receives the streamed response in chunk
  Stream<String> sendMessageStream(String text) async* {
    print("sendMessageStream");
    setState(() {
      _gptStreamText = '';
    });
    final request = http.Request("POST", Uri.parse("http://localhost:5001/api/chatbot/656c1cef9a8f00b81311d09f"));
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NTZiMTVlN2U2NzRjNGJkNTM0YjljOWIiLCJuYW1lIjoiYWRtaW4iLCJwcm9maWxlSW1hZ2VVcmwiOiJodHRwczovL3BldC1uZXR3b3JrLXNlZWRzLnMzLnVzLXdlc3QtMS5hbWF6b25hd3MuY29tL3B1cnBsZS1wcm9maWxlLmpwZyIsImVtYWlsIjoic2pwamphbmcxMUBuYXZlci5jb20iLCJhZ2UiOjQyLCJsb2NhdGlvbiI6InNlb3VsIiwiaWF0IjoxNzAxNjA5MjQ0LCJleHAiOjE3MDE3MTAwNDR9.Axtu5XdvYnfvStFBvX8cc5S_SuzqcUWxcBCtpIYt5sc";
    //request.headers["Accept-Language"] = "${ApiManager.locale!.languageCode}_${ApiManager.locale!.countryCode}";
    request.body = jsonEncode({
      //if (dm.isLogin) "uuid": "${dm.deviceId}",
      "diagnosisResultId": _gptStreamResultIndex,
    });
    final response = await StreamClient.instance.send(request);
    final statusCode = response.statusCode;
    final byteStream = response.stream;

    if (!(statusCode >= 200 && statusCode < 300)) {
      var error = "";
      await for (final byte in byteStream) {
        final decoded = utf8.decode(byte).trim();
        final map = jsonDecode(decoded) as Map;
        final errorMessage = map["error"]["message"] as String;
        error += errorMessage;
      }
      throw Exception("($statusCode) ${error.isEmpty ? "Bad Response" : error}");
    }

    inspect(response);
    await for (final byte in byteStream) {
      var decoded = utf8.decode(byte);
      yield decoded;
    }
  }

  void loginComplete(bool isSuccess) {
    if (isSuccess) {
    } else {}

    setState(() {});
  }
}
