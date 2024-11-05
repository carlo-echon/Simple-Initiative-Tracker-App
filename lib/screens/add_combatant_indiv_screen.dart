import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/utils/colors.dart';

class AddCombatantIndivScreen extends StatefulWidget {
  static String routeName = '/indiv-combatant';
  const AddCombatantIndivScreen({Key? key}) : super(key: key);

  @override
  State<AddCombatantIndivScreen> createState() => _AddCombatantIndivScreenState();
}

class _AddCombatantIndivScreenState extends State<AddCombatantIndivScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Combatant (Individual)'),
        backgroundColor: bgColor,
      ),
      body: const Center(
        child: Text('This is for adding combatants'),
      ),
    );
  }
}