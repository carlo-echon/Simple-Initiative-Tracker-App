import 'package:flutter/material.dart';
import 'package:simple_initiative_tracker_app/screens/group_init_screen.dart';
import 'package:simple_initiative_tracker_app/screens/indiv_init_screen.dart';
import 'package:simple_initiative_tracker_app/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

  void groupInitiative(BuildContext context) {
    Navigator.pushNamed(context, GroupInitiativeScreen.routeName);
  }

  void indivInitative(BuildContext context) {
    Navigator.pushNamed(context, IndivInitiativeScreen.routeName);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onPressed: () => indivInitative(context), 
            text: "Individual Initiative"
          ),
          SizedBox(
            width: 5,
            height: 5,
          ),
          CustomButton(
            onPressed: () => groupInitiative(context),
            text: "Group Initiative"
          ),
        ],
      ),
    )
    );
  }
}