import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/service_constants.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/homepage/screens/homepage.dart';
import 'package:shopnownow/modules/onboarding/splash_screen.dart';
import 'package:shopnownow/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        title: 'Shop Now Now',
        theme: kThemeData,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SessionManager.getToken() == null ?
        const SplashScreen() : const HomePage(),
      ),
    );
  }
}