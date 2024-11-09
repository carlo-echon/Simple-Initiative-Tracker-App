class IndivCombatant {
  final String name;
  final int initiative;
  final int ac;
  int hp;
  bool isDead;

  IndivCombatant(this.name, this.initiative, this.ac, this.hp, {this.isDead = false});
}