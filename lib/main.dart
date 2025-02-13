import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:sqa/extensions/string_extension.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/utils/routing_data.dart';
import 'package:sqa/views/create_event_view.dart';
import 'package:sqa/views/detail_view.dart';
import 'package:sqa/views/event_view.dart';
import 'package:sqa/views/home_view.dart';
import 'package:sqa/views/intro_view.dart';
import 'package:sqa/views/join_event_qr.dart';
import 'package:sqa/views/login_view.dart';
import 'package:sqa/views/settings_view.dart';
import 'package:sqa/views/sign_in_view_email_pw.dart';
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

  static const introRoute = '/';
  static const loginRoute = '/login';
  static const signInRoute = '/signIn';
  static const signUpRoute = '/signUp';
  static const homeRoute = '/home';
  static const detailRoute = '/detail';
  static const squadRoute = '/squad';
  static const eventRoute = '/event';
  static const settingsRoute = '/settings';
  static const createEventRoute = '/createEvent';
  static const joinEventByQR = '/joinEventByQR';
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
        cardTheme: SqaTheme.createCardTheme(),
      ),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    RoutingData routingData = settings.name!.getRoutingData;

    switch (routingData.route) {
      case introRoute:
        return MaterialPageRoute(
            builder: (context) => const IntroView(), settings: settings);
      case signInRoute:
        return MaterialPageRoute(
            builder: (context) => const SignInViewEmailPw(),
            settings: settings);
      case signUpRoute:
        return MaterialPageRoute(
            builder: (context) => const SignUpView(), settings: settings);
      case loginRoute:
        return MaterialPageRoute(
            builder: (context) => const LoginView(), settings: settings);
      case homeRoute:
        return MaterialPageRoute(
            builder: (context) => const HomeView(), settings: settings);
      case detailRoute:
        return MaterialPageRoute(
            builder: (context) => SqaDetailView(
                  eventId: routingData['eventId'],
                ),
            settings: settings);
      case squadRoute:
        return MaterialPageRoute(
            builder: (context) => const SquadView(), settings: settings);
      case eventRoute:
        return MaterialPageRoute(
            builder: (context) => const EventView(), settings: settings);
      case settingsRoute:
        return MaterialPageRoute(
            builder: (context) => const SettingsView(), settings: settings);
      case createEventRoute:
        return MaterialPageRoute(
            builder: (context) => const CreateEventView(), settings: settings);
      case joinEventByQR:
        return MaterialPageRoute(
            builder: (context) => const JoinEventQr(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const IntroView(), settings: settings);
    }
  }
}
