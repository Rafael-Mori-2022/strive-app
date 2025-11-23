enum XpAction {
  addWater(15, "Hidratação"),
  addMeal(30, "Refeição registrada"),
  completeWorkout(100, "Treino concluído"),
  updateProfile(50, "Perfil atualizado"),
  dailyLogin(20, "Login diário");

  final int points;
  final String label;
  const XpAction(this.points, this.label);
}