import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Providers/tutor_education_provider.dart';
import 'package:ustaad/Providers/tutor_exp_provider.dart';
import 'package:ustaad/Providers/tutor_veirfy_provider.dart';
import 'package:ustaad/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExperienceProvider(context),
        ),
        ChangeNotifierProvider(
          create: (_) => EducationProvider(context),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        title: 'Ustaad',
        home: const SplashScreen(),
      ),
    );
  }
}
