import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_button.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_textfield.dart';

class EditHPDialog extends StatefulWidget {
  final int initialHp;
  final void Function(int, bool) onHpUpdated;

  const EditHPDialog({
    Key? key,
    required this.initialHp,
    required this.onHpUpdated,
  }) : super(key: key);

  @override
  State<EditHPDialog> createState() => _EditHpDialogState();
}

class _EditHpDialogState extends State<EditHPDialog> {
  late TextEditingController _hpController;

  @override
  void initState() {
    super.initState();
    _hpController = TextEditingController();
  }

  @override
  void dispose() {
    _hpController.dispose();
    super.dispose();
  }

  void _submitSubtractHp() {
    final hpValue = int.tryParse(_hpController.text) ?? 0;
    int newHp = widget.initialHp - hpValue;
    if (newHp > 0) {
      widget.onHpUpdated(newHp, false);
      Navigator.of(context).pop();
    } else {
      widget.onHpUpdated(newHp, true);
      Navigator.of(context).pop();
    }
  }

  void _submitAddHp () {
    final hpValue = int.tryParse(_hpController.text) ?? 0;
    int newHp = widget.initialHp + hpValue;
    if (newHp >= 0) {
      widget.onHpUpdated(newHp, false);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid number for HP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit HP'),
      content: CustomTextField(
        controller: _hpController, 
        hintText: "Enter HP Value",
        ),
        actions: [
          CustomButton(onPressed: _submitAddHp, text: "Add HP"),
          CustomButton(onPressed: _submitSubtractHp, text: 'Subtract HP')
        ],
    );
  }
}