import 'package:kena/app/routes/routes.dart';
import 'package:kena/app/styles/app_dimensions.dart';
import 'package:kena/app/styles/theme_factory.dart';
import 'package:kena/l10n/app_localizations.dart';
import 'package:kena/provider/auth/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppDimensions.mockSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final locale = context.watch<LocaleNotifier>().locale;
        return MaterialApp(
          title: 'kena',
          debugShowCheckedModeBanner: false, //hide debug banner
          themeMode: ThemeMode.light,
          theme: ThemeFactory.darkThemeData(),
          darkTheme: ThemeFactory.darkThemeData(),
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: Routes.initialRoute(),
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
