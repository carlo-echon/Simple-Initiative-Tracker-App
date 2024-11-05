import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/screens/add_combatant_indiv_screen.dart';
import 'package:simple_initiative_tracker_app/screens/group_init_screen.dart';
import 'package:simple_initiative_tracker_app/screens/indiv_init_screen.dart';
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
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      routes: {
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        GroupInitiativeScreen.routeName: (context) => const GroupInitiativeScreen(),
        IndivInitiativeScreen.routeName: (context) => const IndivInitiativeScreen(),
        AddCombatantIndivScreen.routeName: (context) => const AddCombatantIndivScreen(),
      },
      initialRoute: MainMenuScreen.routeName,
    );
  }
}


