import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/views/create_event_view.dart';
import 'package:sqa/views/detail_view.dart';
import 'package:sqa/views/event_view.dart';
import 'package:sqa/views/home_view.dart';
import 'package:sqa/views/intro_view.dart';
import 'package:sqa/views/login_view.dart';
import 'package:sqa/views/settings_view.dart';
import 'package:sqa/views/sign_in_view_email_pw.dart';
import 'package:sqa/views/sign_in_view_with_phone_number.dart';
import 'package:sqa/views/sign_up_view.dart';
import 'package:sqa/views/squad_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String accessToken = const String.fromEnvironment("ACCESS_TOKEN");
  MapboxOptions.setAccessToken(accessToken);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: SqaTheme.primaryColor,
        focusColor: SqaTheme.primaryColor,
        scaffoldBackgroundColor: SqaTheme.backgroundColor,
        progressIndicatorTheme: SqaTheme.createProgressIndicatorTheme(),
        appBarTheme: SqaTheme.createAppbarTheme(),
        bottomAppBarTheme: SqaTheme.createBottomAppBar(),
        searchBarTheme: SqaTheme.createSearchbarTheme(),
        iconButtonTheme: SqaTheme.createIconButtonTheme(),
        textButtonTheme: SqaTheme.createTextButtonTheme(),
        dropdownMenuTheme: SqaTheme.createDropDownMenuTheme(),
        outlinedButtonTheme: SqaTheme.createOutlineButtonTheme(),
        floatingActionButtonTheme: SqaTheme.createFloatingActionButtonTheme(),
        sliderTheme: SqaTheme.createSliderTheme(),
        datePickerTheme: SqaTheme.createDatePickerTheme(),
        timePickerTheme: SqaTheme.createTimePickerTheme(),
        elevatedButtonTheme: SqaTheme.createElevatedButtonTheme(),
        inputDecorationTheme: SqaTheme.createInputDecorationTheme(),
        filledButtonTheme: SqaTheme.createFilledButtonTheme(),
        dialogTheme: SqaTheme.createDialogTheme(),
        textTheme: SqaTheme.createTextTheme(),
      ),
      initialRoute: '/',
      //TODO dynamic routing for detail route so we can pass eventid
      routes: {
        '/': (_) => const IntroView(),
        '/login': (_) => const LoginView(),
        '/signIn': (_) => const SignInViewEmailPw(),
        '/signUp': (_) => const SignUpView(),
        '/home': (_) => const HomeView(),
        '/detail': (_) => const SqaDetailView(),
        '/squad': (_) => const SquadView(),
        '/event': (_) => const EventView(),
        '/settings': (_) => const SettingsView(),
        '/createEvent': (_) => const CreateEventView()
      },
    );
  }
}
