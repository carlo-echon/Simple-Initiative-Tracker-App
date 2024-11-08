import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/utils/combatant_indiv.dart';
import 'package:simple_initiative_tracker_app/utils/group_combat.dart';

class GroupCombatantProvider with ChangeNotifier {
  final List<GroupCombatant> _groups = [];

  List <GroupCombatant> get groups => List.unmodifiable(_groups);

  void addGroup(int initiative, List<IndivCombatant> combatants) {
     _groups.add(GroupCombatant(initiative, combatants));
    _sortGroupsByInitiative();
    notifyListeners();
  }

   void _sortGroupsByInitiative() {
    _groups.sort((a, b) => b.initiative.compareTo(a.initiative)); // Higher initiative first
  }

  void updateHpInGroup(int groupIndex, int combatantIndex, int newHp, {bool isDead = false}) {
    final group = _groups[groupIndex];
    final combatant = group.combatants[combatantIndex];
    combatant.hp = newHp;
    combatant.isDead = isDead;
    notifyListeners();
  }

  void clearGroups() {
    _groups.clear();
    notifyListeners();
  }
}