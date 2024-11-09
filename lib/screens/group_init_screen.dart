import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_initiative_tracker_app/screens/add_combatant_grp_screen.dart';
import 'package:simple_initiative_tracker_app/utils/colors.dart';
import 'package:simple_initiative_tracker_app/utils/group_provider.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_dialog_edit_hp.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_dialog_end_combat.dart';

class GroupInitiativeScreen extends StatefulWidget {
  static String routeName = '/group-initiative';
  const GroupInitiativeScreen({Key? key}) : super(key: key);

  @override
  State<GroupInitiativeScreen> createState() => _GroupInitiativeScreenState();
}

class _GroupInitiativeScreenState extends State<GroupInitiativeScreen> {

  int? _currentTurnIndex;
  bool _isCombatStarted = false;

  void addCombatantGroup(BuildContext context) {
    Navigator.pushNamed(context, AddCombatantGroupScreen.routeName);
  }

  void _advanceTurn() {
    final provider = Provider.of<GroupCombatantProvider>(context, listen: false);
    final groups = provider.groups.where((g) => g.combatants.any((c) => !c.isDead)).toList();

    if (groups.isNotEmpty) {
      setState(() {
        if (_currentTurnIndex == null) {
          // Start at the first group with an alive combatant
          _currentTurnIndex = 0;
          _isCombatStarted = true;
        } else {
          // Move to the next group
          _currentTurnIndex = (_currentTurnIndex! + 1) % groups.length;
        }
      });
    }
  }

  void _endCombat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EndCombatDialog(
        onConfirmEndCombat: () {
          final provider = Provider.of<GroupCombatantProvider>(context, listen: false);
          provider.clearGroups();
          setState(() {
            _currentTurnIndex = null;
            _isCombatStarted = false;
          });
        },
      ),
    );
  }

  void _editHp(BuildContext context, int index, int currentHp, int groupIndex) {
    showDialog(context: context, 
    builder: (context) => EditHPDialog(
        initialHp: currentHp, 
        onHpUpdated: (newHp, isDead) {
          final provider = Provider.of<GroupCombatantProvider>(context, listen: false);
          provider.updateHpInGroup(groupIndex, index, newHp, isDead: isDead);
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final groups = Provider.of<GroupCombatantProvider>(context).groups;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Initiative Tracker'),
        actions: <Widget> [
          IconButton(
            onPressed: () => addCombatantGroup(context) ,
            tooltip: 'Add a combatant',
             icon: const Icon(Icons.add)
             ),
        ],
        backgroundColor: topBarColor,
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int groupIndex) {
            final group = groups[groupIndex];
            final isCurrentTurn = _currentTurnIndex == groupIndex;

            return Container(
              color: isCurrentTurn ? Colors.amber.withOpacity(0.3) : Colors.transparent,
              child: ExpansionTile(
                title: Text('Group Initiative: ${group.initiative}'),
                children: group.combatants.map((combatant) {
                  final combatantIndex = group.combatants.indexOf(combatant);
                  return ListTile(
                    title: Text(
                      combatant.name,
                      style: TextStyle(
                        decoration: combatant.isDead ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('HP: ${combatant.hp}, AC: ${combatant.ac}'),
                    onTap: () => _editHp(context, combatantIndex, combatant.hp, groupIndex), //Make Edit HP Dialog work for Group initiative
                  );
                }).toList(),
                ),
            );
          }, 
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black54), 
          itemCount: groups.length,
          )
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: _advanceTurn,
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(238, 217, 179, 1),          // Text color
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Square edges
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,               // Adjust horizontal padding for width
                  vertical: 12.0,                 // Adjust vertical padding for height
                ),
              ),
                child: Text(
                _currentTurnIndex == null ? 'Start Combat' : 'Next Turn',
                style: const TextStyle(
                  color: Color.fromRGBO(163, 76, 80, 1),
                ),
                  ),
              ),
              const SizedBox(
                width: 15,
                height: 5,
              ),
              if (_isCombatStarted) 
                ElevatedButton(onPressed: () => _endCombat(context),
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(238, 217, 179, 1),          // Text color
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Square edges
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,               // Adjust horizontal padding for width
                  vertical: 12.0,                 // Adjust vertical padding for height
                ),
              ),
                 child: const Text('End Combat',
                 style: TextStyle(
                  color: Color.fromRGBO(163, 76, 80, 1),
                  )
                 ),
                 )
              
          ],
          ),
      )
    );
  }
}