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
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform).catchError((e){
  print(" Error : ${e.toString()}");
});
  Env.setEnvironment(EnvState.test);
  SessionManager.initSharedPreference().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'ShopNowNow',
        theme: kThemeData,
        navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: (SessionManager.getToken() != null)
            ? const SplashScreen()
            : const HomePage(),
      ),
    );
  }
}
