import 'package:flutter/material.dart';
import 'package:flutter_course_it/src/config/app_theme.dart';
import 'package:flutter_course_it/src/config/routes.dart';
import 'package:flutter_course_it/src/ui/animated_collection_ui.dart';
import 'package:flutter_course_it/src/ui/home_ui.dart';

// Languages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_course_it/src/lang/localization_delegate.dart';
import 'package:flutter_course_it/src/lang/localization.dart';

// UI
import 'package:flutter_course_it/src/ui/splash_screen_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => Localization.of(context).trans("app_title"),
      theme: appTheme,

      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('it', 'IT')
      ],
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        const LocalizationDelegate(),
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.last;
      },
      builder: (context, child) {
        return Scaffold(
          appBar: null,
          body: SafeArea(
            child: child,
          )
        );
      },
      initialRoute: SplashRoute,
      routes: {
        SplashRoute: (context) => SplashScreenUI(),
        HomeRoute: (context) => HomeUI(),
        AnimatedCollectionRoute: (context) => AnimatedCollectionUI(),
      },
    );
  }
}