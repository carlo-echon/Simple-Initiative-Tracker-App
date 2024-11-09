import 'package:simple_initiative_tracker_app/utils/combatant_indiv.dart';

class GroupCombatant {
  final List<IndivCombatant> combatants;
  final int initiative;

  GroupCombatant(this.initiative, this.combatants);
}