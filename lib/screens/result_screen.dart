  import 'package:flutter/material.dart';
import '../services/score_service.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalAnswered;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalAnswered,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isNewHighScore = false;

  @override
  void initState() {
    super.initState();
    _checkHighScore();
  }

  Future<void> _checkHighScore() async {
    final isNew = await ScoreService.saveScore(widget.score);
    setState(() {
      _isNewHighScore = isNew;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = widget.totalAnswered > 0
        ? (widget.score / widget.totalAnswered) * 100
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fim de Jogo!'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isNewHighScore) ...[
              const Icon(Icons.stars, size: 80, color: Colors.amber),
              const SizedBox(height: 8),
              const Text(
                '🎉 NOVO RECORDE! 🎉',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              const SizedBox(height: 20),
            ],

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildStatRow('Perguntas Respondidas:', '${widget.totalAnswered}'),
                    const Divider(height: 24),
                    _buildStatRow('Total de Acertos:', '${widget.score}'),
                    const Divider(height: 24),
                    _buildStatRow(
                      'Aproveitamento:',
                      '${percentage.toStringAsFixed(1)}%',
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Retorna ao Menu Principal
              },
              icon: const Icon(Icons.home),
              label: const Text('MENU PRINCIPAL', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String title, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: isHighlight ? Colors.indigo : Colors.black87,
          ),
        ),
      ],
    );
  }
}