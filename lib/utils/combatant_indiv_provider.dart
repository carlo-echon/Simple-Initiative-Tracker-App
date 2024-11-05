import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/utils/combatant_indiv.dart';


class CombatantProvider with ChangeNotifier {
  // Private list of combatants
  List<IndivCombatant> _combatants = [];

  // Public getter to access combatants list
  List<IndivCombatant> get combatants => _combatants;

  // Method to add a new combatant and notify listeners of the change
  void addCombatant(IndivCombatant combatant) {
    _combatants.add(combatant);
    notifyListeners();
  }
}