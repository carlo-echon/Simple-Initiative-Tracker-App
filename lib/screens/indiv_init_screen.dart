import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_initiative_tracker_app/screens/add_combatant_indiv_screen.dart';
import 'package:simple_initiative_tracker_app/utils/colors.dart';
import 'package:simple_initiative_tracker_app/utils/combatant_indiv_provider.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_dialog_edit_hp.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_dialog_end_combat.dart';

class IndivInitiativeScreen extends StatefulWidget {
  static String routeName = '/indiv-initiative';
  const IndivInitiativeScreen({Key? key}) : super(key: key);

  @override
  State<IndivInitiativeScreen> createState() => _IndivInitiativeScreenState();
}

class _IndivInitiativeScreenState extends State<IndivInitiativeScreen> {

   int? _currentTurnIndex;
   bool _isCombatStarted = false;

  void _advanceTurn() {
    final provider = Provider.of<CombatantProvider>(context, listen: false);
    final combatants = provider.combatants.where((c) => !c.isDead).toList();

    if (combatants.isNotEmpty) {
      setState(() {
        if (_currentTurnIndex == null) {
          // Start at the first alive combatant
          _currentTurnIndex = 0;
          _isCombatStarted = true;
        } else {
          // Move to the next combatant in the list
          _currentTurnIndex = (_currentTurnIndex! + 1) % combatants.length;
        }
      });

    }
  }

    void _editHp(BuildContext context, int index, int currentHp) {
    showDialog(
      context: context,
      builder: (context) => EditHPDialog(
        initialHp: currentHp,
        onHpUpdated: (newHp, isDead) {
          final provider = Provider.of<CombatantProvider>(context, listen: false);
          provider.updateHp(index, newHp, isDead: isDead);
        },
      ),
    );
  }

   void _endCombat(BuildContext context) {
    showDialog(context: context,
     builder: (context) => EndCombatDialog(
      onConfirmEndCombat: () {
        final provider = Provider.of<CombatantProvider>(context, listen: false);
        provider.clearAllCombatants();

        setState(() {
          _currentTurnIndex = null;
          _isCombatStarted = false;
        });
      }
      ),
     );
   }

  void addCombatantIndiv(BuildContext context) {
    Navigator.pushNamed(context, AddCombatantIndivScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {

    final combatants = Provider.of<CombatantProvider>(context).combatants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Individual Initiative Tracker'),
        actions: <Widget> [
          IconButton(
            onPressed: () => addCombatantIndiv(context) ,
            tooltip: 'Add a combatant',
             icon: const Icon(Icons.add)
             ),
        ],
        backgroundColor: topBarColor,
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final combatant = combatants[index];
            final isCurrentTurn = _currentTurnIndex == index;

            return Container(
              color: isCurrentTurn ? Colors.amber.withOpacity(0.3) : Colors.transparent,
              child: ListTile(
              title: Text(
                combatant.name,
                style: TextStyle(
                  decoration: combatant.isDead ? TextDecoration.lineThrough : null
                ),
                ),
              subtitle: Text('Initiative: ${combatant.initiative}, AC: ${combatant.ac}, HP: ${combatant.hp}'),
              onTap: () => _editHp(context, index, combatant.hp),
            ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black54,),
          itemCount: combatants.length,
            ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: _advanceTurn,
                child: Text(
                _currentTurnIndex == null ? 'Start Combat' : 'Next Turn',
                  ),
              ),
              if (_isCombatStarted) 
                ElevatedButton(onPressed: () => _endCombat(context), child: const Text('End Combat'))
              
          ],
          ),
        ),
      );
  }
}