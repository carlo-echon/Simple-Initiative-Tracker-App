import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/screens/main_menu_screen.dart';

import 'utils/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Simple Initiative Tracking',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      routes: {
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
      },
      initialRoute: MainMenuScreen.routeName,
    );
  }
}


