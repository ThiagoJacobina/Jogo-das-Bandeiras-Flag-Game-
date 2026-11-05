import 'package:shared_preferences/shared_preferences.dart';

class ScoreService {
  static const String _keyHighScore = 'flag_game_high_score';

  /// Obtém o maior número de acertos salvo no aparelho
  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyHighScore) ?? 0;
  }

  /// Salva a pontuação se for maior que o recorde atual
  static Future<bool> saveScore(int currentScore) async {
    final prefs = await SharedPreferences.getInstance();
    final highScore = prefs.getInt(_keyHighScore) ?? 0;
    
    if (currentScore > highScore) {
      await prefs.setInt(_keyHighScore, currentScore);
      return true; // Novo recorde alcançado!
    }
    return false;
  }
}