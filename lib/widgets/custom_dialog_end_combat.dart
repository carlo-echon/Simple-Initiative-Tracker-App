import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_button.dart';

class EndCombatDialog extends StatelessWidget {
  final VoidCallback onConfirmEndCombat; // Callback for confirming end of combat

  const EndCombatDialog({
    Key? key,
    required this.onConfirmEndCombat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('End Combat'),
      content: const Text("Are you sure you want to end combat?"),
      actions: [
        CustomButton(
          onPressed: () {
            onConfirmEndCombat(); // End combat
            Navigator.of(context).pop(); // Close dialog
          },
          text: "Yes",
        ),
        CustomButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          text: 'No',
        ),
      ],
    );
  }
}