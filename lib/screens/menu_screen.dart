import 'package:flutter/material.dart';
import '../data/countries_data.dart';
import '../models/game_config.dart';
import '../services/score_service.dart';
import 'game_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedTime = 60; // Padrão: 60s
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final score = await ScoreService.getHighScore();
    setState(() {
      _highScore = score;
    });
  }

  void _startGame(GameMode mode, {String? continent}) {
    final config = GameConfig(
      mode: mode,
      selectedContinent: continent,
      timeInSeconds: _selectedTime,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen(config: config)),
    ).then((_) => _loadHighScore()); // Atualiza o recorde ao voltar do jogo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚩 Flag Game', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner de Recorde Local
            Card(
              color: Colors.amber.shade100,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    const Icon(Icons.emoji_events, size: 36, color: Colors.amber),
                    const SizedBox(height: 4),
                    const Text('Maior Pontuação', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    Text(
                      '$_highScore Acertos',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Seleção do Temporizador
            const Text('⏱️ Selecione o Tempo de Jogo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 30, label: Text('30s')),
                ButtonSegment(value: 60, label: Text('1m')),
                ButtonSegment(value: 180, label: Text('3m')),
                ButtonSegment(value: 300, label: Text('5m')),
              ],
              selected: {_selectedTime},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedTime = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 30),

            // Botão Modo Aleatório
            ElevatedButton.icon(
              onPressed: () => _startGame(GameMode.random),
              icon: const Icon(Icons.public),
              label: const Text('JOGO ALEATÓRIO (MUNDO)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Seleção por Continente
            const Text('🌍 Jogar por Continente:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...CountriesData.continents.map(
              (continent) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: OutlinedButton.icon(
                  onPressed: () => _startGame(GameMode.continent, continent: continent),
                  icon: const Icon(Icons.map_outlined),
                  label: Text(continent, style: const TextStyle(fontSize: 15)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}