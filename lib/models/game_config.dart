enum GameMode { random, continent }

class GameConfig {
  final GameMode mode;
  final String? selectedContinent; // Usado apenas se mode == continent
  final int timeInSeconds;         // 30, 60, 180 ou 300 segundos

  GameConfig({
    required this.mode,
    this.selectedContinent,
    required this.timeInSeconds,
  });
}