
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/service_constants.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/firebase_options.dart';
import 'package:shopnownow/modules/homepage/screens/homepage.dart';
import 'package:shopnownow/modules/onboarding/splash_screen.dart';
import 'package:shopnownow/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform).catchError((e){
  print(" Error : ${e.toString()}");
});
  Env.setEnvironment(EnvState.test);
  SessionManager.initSharedPreference().then((value) => runApp(const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'ShopNowNow',
        theme: kThemeData,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SessionManager.getToken() == null
            ? const SplashScreen()
            : const HomePage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
