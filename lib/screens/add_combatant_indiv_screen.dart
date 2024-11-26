import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:simple_initiative_tracker_app/utils/colors.dart';
import 'package:simple_initiative_tracker_app/utils/combatant_indiv_provider.dart';
import 'package:simple_initiative_tracker_app/utils/combatant_indiv.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_button.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_textfield.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_textfield_num.dart';


class AddCombatantIndivScreen extends StatefulWidget {
  static String routeName = '/indiv-combatant';
  const AddCombatantIndivScreen({Key? key}) : super(key: key);

  @override
  State<AddCombatantIndivScreen> createState() => _AddCombatantIndivScreenState();
}

class _AddCombatantIndivScreenState extends State<AddCombatantIndivScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _initiativeController = TextEditingController();
  final TextEditingController _armorController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();

  void _submitCombatant(BuildContext context) {
    final name = _nameController.text;
    final initiative = int.tryParse(_initiativeController.text);
    final ac = int.tryParse(_armorController.text) ?? 10;
    final hp = int.tryParse(_healthController.text) ?? 1;

    if (name.isNotEmpty && initiative != null) {
      final provider = Provider.of<CombatantProvider>(context, listen: false);
      provider.addCombatant(IndivCombatant(name, initiative, ac, hp));

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _armorController.dispose();
    _initiativeController.dispose();
    _healthController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Combatant (Individual)'),
        backgroundColor: topBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _nameController,
               hintText: 'Name'
               ),
               const SizedBox(height: 10.0),
            CustomTextFieldNum(
              controller: _initiativeController,
               hintText: 'Initiative'
               ),
               const SizedBox(height: 10.0),
            CustomTextFieldNum(
              controller: _armorController,
               hintText: 'AC'
               ),
               const SizedBox(height: 10.0),
            CustomTextFieldNum(
              controller: _healthController,
               hintText: 'HP'
               ),
               const SizedBox(height: 25.0),
            CustomButton(
              onPressed: () => _submitCombatant(context),
               text: "Add Combatant"
               ),
          ]
        ),
        ),
    );
  }
}