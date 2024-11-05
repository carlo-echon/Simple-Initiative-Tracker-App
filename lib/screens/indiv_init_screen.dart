import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/screens/add_combatant_indiv_screen.dart';
import 'package:simple_initiative_tracker_app/utils/colors.dart';

class IndivInitiativeScreen extends StatefulWidget {
  static String routeName = '/indiv-initiative';
  const IndivInitiativeScreen({Key? key}) : super(key: key);

  @override
  State<IndivInitiativeScreen> createState() => _IndivInitiativeScreenState();
}

class _IndivInitiativeScreenState extends State<IndivInitiativeScreen> {

  void addCombatantIndiv(BuildContext context) {
    Navigator.pushNamed(context, AddCombatantIndivScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Individual Initiative Tracker'),
        actions: <Widget> [
          IconButton(
            onPressed: () => addCombatantIndiv(context) ,//onPressed 
            tooltip: 'Add a combatant',
             icon: const Icon(Icons.add)
             ),
        ],
        backgroundColor: bgColor,
      ),
      body: const Center(
        child: Text('This is the list view of the combatants'),
      ),
    );
  }
}