
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppWidgetState();
}

class _MainAppWidgetState extends State<MainApp> {
  final List<Combatant> combatants = [];

  void _addCombatant(Combatant combatant) {
    setState(() {
      combatants.add(combatant);
      combatants.sort((a, b) => b.initiative.compareTo(a.initiative));
    });
  }

  void _clearCombat() {
    setState(() {
      combatants.clear();
    }); 
  }

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Initiative Tracker';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: Center(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final listcombatant = combatants[index];
              return ListTile(
                title: Text(listcombatant.name),
                subtitle: Text('Initiative: ${listcombatant.initiative}, AC: ${listcombatant.ac}, HP: ${listcombatant.hp}'),
                onTap: () {
                  _showEditHealthDialog(context, listcombatant);
                },
                  );
            }, 
            separatorBuilder: (BuildContext context, int index) => const Divider(), 
            itemCount: combatants.length,
            ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCombatantDialog(onAdd: _addCombatant)),
                );
              },
              child: const Icon(Icons.add),
      );
          },
      ),
      SizedBox(height: 8),
          Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
              heroTag: "btn2",
              onPressed: () => _dialogDeleteBuilder(context),
              child: Icon(Icons.delete),
            );
            }
          ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogDeleteBuilder(BuildContext context) {
    return showDialog<void>(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Combat Finished'),
          content: const Text('Confirming will delete all combatants in the combat list.\n' 
          'Are you sure, you want to continue?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Confirm'),
              onPressed: () {
                _clearCombat();
                Navigator.of(context).pop();
              },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                child: const Text('Cancel')
                ),
          ]
        );
      }
      );
  }

  void _showEditHealthDialog(BuildContext context, Combatant combatant) {
    TextEditingController _healthController = TextEditingController();

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Health'),
          content: Column(
            children: [
              Text('Current HP: ${combatant.hp}'),
              SizedBox(height: 16),
              TextField(
                controller: _healthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter value'
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                int value = int.tryParse(_healthController.text) ?? 0;
                setState(() {
                  combatant.hp += value;
                });
                Navigator.of(context).pop();
              }, 
              child: const Text('Add HP')
              ),
            TextButton(
              onPressed: () {
                int value = int.tryParse(_healthController.text) ?? 0;
                setState(() {
                  combatant.hp -= value;
                });
                Navigator.of(context).pop();
              }, 
              child: const Text('Subtract HP')
              ),
          ],
        );
      }
      );
  }
}

class AddCombatantDialog extends StatefulWidget {
  final Function(Combatant) onAdd;

  const AddCombatantDialog({required this.onAdd, Key? key}) : super(key: key);

  @override
  _AddCombatantDialogState createState() => _AddCombatantDialogState();
  
}

class _AddCombatantDialogState extends State<AddCombatantDialog> {
  final _nameController = TextEditingController();
  final _initiativeController = TextEditingController();
  final _acController = TextEditingController();
  final _hpController = TextEditingController();

  void _submit() {
    final combatant = Combatant(
      name: _nameController.text, 
      initiative: int.parse(_initiativeController.text), 
      ac: int.parse(_acController.text), 
      hp: int.parse(_hpController.text),
      );
    widget.onAdd(combatant);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Combatant")
      ),
      body: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Combatant\'s Name'
                ),
            ),
            TextField(
              controller: _initiativeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Combatant\'s Initiative'
                ),
            ),
            TextField(
              controller: _acController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Combatant\'s AC'
                ),
            ),
            TextField(
              controller: _hpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Combatant\'s HP'
                ),
            ),
            ElevatedButton(
              onPressed: () {
                _submit();
              },
              child: const Text('Confirm'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
      ),
    );
  }
  
@override
  void dispose() {
    _nameController.dispose();
    _initiativeController.dispose();
    _acController.dispose();
    _hpController.dispose();
    super.dispose();
  }

}

class Combatant {
  final String name;
  final int initiative;
  final int ac;
  int hp;

  Combatant({
    required this.name,
    required this.initiative,
    required this.ac,
    required this.hp,
  });
}


