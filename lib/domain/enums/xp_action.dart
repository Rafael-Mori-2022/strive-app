enum XpAction {
  addWater(15, "Hidratação"),
  addMeal(30, "Refeição registrada"),
  completeExercise(10, "Exercício concluído"), 
  completeWorkout(100, "Treino finalizado"),  
  updateProfile(50, "Perfil atualizado"),
  dailyLogin(20, "Login diário");

  final int points;
  final String label;
  const XpAction(this.points, this.label);
}