import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'data/app_state.dart';
import 'data/router.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(ChangeNotifierProvider(create: (_) => AppState(), child: const MilimaniApp()));
}

class MilimaniApp extends StatelessWidget {
  const MilimaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<AppState>().locale;
    return MaterialApp.router(
      title: 'Milimani Beach Resort',
      debugShowCheckedModeBanner: false,
      theme: MilimaniTheme.light,
      routerConfig: appRouter,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('sw')],
    );
  }
}
