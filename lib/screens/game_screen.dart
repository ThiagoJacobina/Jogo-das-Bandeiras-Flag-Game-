import 'dart:async';
import 'dart:math';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import '../data/countries_data.dart';
import '../models/country.dart';
import '../models/game_config.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  final GameConfig config;

  const GameScreen({super.key, required this.config});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<Country> _availableCountries;
  late Country _correctCountry;
  late List<Country> _options;

  int _score = 0;
  int _totalAnswered = 0;
  late int _remainingSeconds;
  Timer? _timer;

  String? _selectedAnswer;
  bool _answered = false;

  final List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.config.timeInSeconds;
    _setupCountryPool();
    _generateNextQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _setupCountryPool() {
    if (widget.config.mode == GameMode.continent && widget.config.selectedContinent != null) {
      _availableCountries = CountriesData.getByContinent(widget.config.selectedContinent!);
    } else {
      _availableCountries = List.from(CountriesData.allCountries);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
        _endGame();
      }
    });
  }

  void _generateNextQuestion() {
    final random = Random();
    
    _correctCountry = _availableCountries[random.nextInt(_availableCountries.length)];

    Set<Country> optionSet = {_correctCountry};
    while (optionSet.length < 4) {
      final randomCountry = CountriesData.allCountries[random.nextInt(CountriesData.allCountries.length)];
      optionSet.add(randomCountry);
    }

    _options = optionSet.toList()..shuffle();
    _selectedAnswer = null;
    _answered = false;
  }

  void _handleAnswer(Country selected) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _selectedAnswer = selected.name;
      _totalAnswered++;

      if (selected.name == _correctCountry.name) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted && _remainingSeconds > 0) {
        setState(() {
          _generateNextQuestion();
        });
      }
    });
  }

  void _endGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _score,
          totalAnswered: _totalAnswered,
        ),
      ),
    );
  }

  Color _getOptionBackgroundColor(Country option) {
    if (!_answered) return Colors.white;
    if (option.name == _correctCountry.name) return const Color(0xFFE8F5E9); // Verde suave
    if (option.name == _selectedAnswer) return const Color(0xFFFFEBEE); // Vermelho suave
    return Colors.white.withOpacity(0.6);
  }

  Color _getOptionBorderColor(Country option) {
    if (!_answered) return Colors.grey.shade300;
    if (option.name == _correctCountry.name) return Colors.green.shade600;
    if (option.name == _selectedAnswer) return Colors.red.shade600;
    return Colors.grey.shade300;
  }

  Color _getLabelColor(Country option) {
    if (!_answered) return Colors.indigo;
    if (option.name == _correctCountry.name) return Colors.green.shade800;
    if (option.name == _selectedAnswer) return Colors.red.shade800;
    return Colors.indigo.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _remainingSeconds / widget.config.timeInSeconds;
    final bool isLowTime = _remainingSeconds <= 10;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.indigo.shade900,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            _timer?.cancel();
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: isLowTime ? Colors.red.shade100 : Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLowTime ? Colors.red.shade300 : Colors.indigo.shade200,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 18,
                color: isLowTime ? Colors.red.shade700 : Colors.indigo.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                '${_remainingSeconds}s',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isLowTime ? Colors.red.shade700 : Colors.indigo.shade700,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.amber, Colors.orangeAccent],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.stars_rounded, size: 18, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  '$_score',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Barra de progresso com design arredondado
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: isLowTime ? Colors.redAccent : Colors.indigoAccent,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 24),

              // Card Central da Bandeira
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CountryFlag.fromCountryCode(
                          _correctCountry.isoCode,
                          height: 140,
                          width: 210,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A qual país pertence esta bandeira?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Lista de Opções de Resposta
              Expanded(
                child: ListView.builder(
                  itemCount: _options.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final option = _options[index];
                    final label = _optionLabels[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: InkWell(
                          onTap: () => _handleAnswer(option),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: _getOptionBackgroundColor(option),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _getOptionBorderColor(option),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                // Badge A, B, C, D
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: _getLabelColor(option).withOpacity(0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: _getLabelColor(option),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Nome do País
                                Expanded(
                                  child: Text(
                                    option.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade900,
                                    ),
                                  ),
                                ),

                                // Ícone de Feedback (Certo / Errado)
                                if (_answered && option.name == _correctCountry.name)
                                  const Icon(Icons.check_circle_rounded, color: Colors.green, size: 24),
                                if (_answered && option.name == _selectedAnswer && option.name != _correctCountry.name)
                                  const Icon(Icons.cancel_rounded, color: Colors.red, size: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}