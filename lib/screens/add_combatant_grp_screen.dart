import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_initiative_tracker_app/utils/colors.dart';
import 'package:simple_initiative_tracker_app/utils/combatant_indiv.dart';
import 'package:simple_initiative_tracker_app/utils/group_provider.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_button.dart';


class AddCombatantGroupScreen extends StatefulWidget {
  static String routeName = '/add-combatant-group';
   const AddCombatantGroupScreen({Key? key}) : super(key: key);

  @override
  _AddCombatantGroupScreenState createState() => _AddCombatantGroupScreenState();
}

class _AddCombatantGroupScreenState extends State<AddCombatantGroupScreen> {
  final TextEditingController _initiativeController = TextEditingController();
  final List<IndivCombatant> _newCombatants = [];
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _acController = TextEditingController();

  void _addCombatant() {
    if (_nameController.text.isNotEmpty &&
        _hpController.text.isNotEmpty &&
        _acController.text.isNotEmpty) {
      final combatant = IndivCombatant(
      _nameController.text,
      int.parse(_initiativeController.text),
      int.parse(_acController.text),
      int.parse(_hpController.text),
      );
      setState(() {
        _newCombatants.add(combatant);
      });
      _nameController.clear();
      _hpController.clear();
      _acController.clear();
    }
  }

  void _submitGroup() {
  final initiative = int.tryParse(_initiativeController.text);
  if (initiative != null && _newCombatants.isNotEmpty) {
    // Passing a new list to avoid clearing combatants in provider when _newCombatants is cleared
    final newCombatantsCopy = List<IndivCombatant>.from(_newCombatants);
    Provider.of<GroupCombatantProvider>(context, listen: false).addGroup(initiative, newCombatantsCopy);
    
    // Clear local state for adding new group
    _newCombatants.clear();
    _initiativeController.clear();
    Navigator.of(context).pop();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter valid initiative and combatants')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Combatant Group'),
        backgroundColor: topBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _initiativeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Group Initiative'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Combatant Name'),
            ),
            TextField(
              controller: _hpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'HP'),
            ),
            TextField(
              controller: _acController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'AC'),
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              onPressed: _addCombatant,
              text: 'Add Combatant to Group',
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _newCombatants.length,
                itemBuilder: (context, index) {
                  final combatant = _newCombatants[index];
                  return ListTile(
                    title: Text(combatant.name),
                    subtitle: Text('HP: ${combatant.hp}, AC: ${combatant.ac}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              onPressed: _submitGroup,
              text: 'Save Group',
            ),
          ],
        ),
      ),
    );
  }
}