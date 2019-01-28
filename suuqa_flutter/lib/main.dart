import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/pages/home/home.dart';
import 'package:suuqa/src/widgets/inherited/inherited_camera.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

List<CameraDescription> _cameras;
User _cUser;
bool _isLoggedIn;

Future main() async {
  _cameras = await availableCameras();

  if ((await Services().auth.auth.currentUser()) != null) {
    _cUser = await APIs().users.cUser();
    _isLoggedIn = true;
  } else {
    _isLoggedIn = false;
  }

  runApp(InheritedCamera(
    child: InheritedUser(
      child: App(),
      isLoggedIn: _isLoggedIn,
      user: _cUser,
    ),
    cameras: _cameras,
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Widget _view = Container();
  String _title = Config.title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Platform.isIOS
        ? this._view = CupertinoApp(
      home: Home(),
      navigatorObservers: [
        Services().analytics.firebaseAnalyticsObserver,
      ],
      title: this._title,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    )
        : this._view = MaterialApp(
      home: Home(),
      navigatorObservers: [
        Services().analytics.firebaseAnalyticsObserver,
      ],
      title: this._title,
      debugShowCheckedModeBanner: false,
    );

    return this._view;
  }
}
