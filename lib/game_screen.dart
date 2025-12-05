import 'package:flutter/material.dart';
import 'package:solveequationgame/pause_screen.dart';
import 'dart:async';
import 'game_data.dart';

class EquationGameScreen extends StatefulWidget {
  final int level;

  const EquationGameScreen({super.key, required this.level});

  @override
  State<EquationGameScreen> createState() => _EquationGameScreenState();
}

class _EquationGameScreenState extends State<EquationGameScreen> {
  late GameLevel gameLevel;
  int currentRound = 1;
  int score = 0;
  int timeRemaining = 60;
  Timer? gameTimer;
  bool isPaused = false;
  int? selectedAnswer;
  bool? isCorrect;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startTimer();
  }

  void _initializeGame() {
    gameLevel = GameData.getLevelData(widget.level) ?? GameData.levels.first;
    timeRemaining = gameLevel.timeLimit;
  }

  void _startTimer() {
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else if (timeRemaining == 0) {
        _gameOver();
      }
    });
  }

  // void _pauseGame() {
  //   setState(() {
  //     isPaused = !isPaused;
  //   });

  //   if (isPaused) {
  //     // Show pause dialog
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Game Paused'),
  //           content: const Text('Tap Resume to continue playing.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 setState(() {
  //                   isPaused = false;
  //                 });
  //               },
  //               child: const Text('Resume'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 Navigator.of(context).pop(); // Exit game
  //               },
  //               child: const Text('Exit'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  void _gameOver() {
    gameTimer?.cancel();
    // Handle game over logic
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _selectAnswer(int answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == gameLevel.correctAnswer;
    });

    if (isCorrect!) {
      setState(() {
        score += gameLevel.pointsPerCorrect;
      });
      _showResultPopup(
        'Correct !',
        'Great job! You got the right answer.',
        Colors.green,
        Icons.check_circle,
      );
    } else {
      _showResultPopup(
        'Wrong !',
        'The correct answer is ${gameLevel.correctAnswer}',
        Colors.red,
        Icons.cancel,
      );
    }
  }

  void _showResultPopup(
    String title,
    String message,
    Color color,
    IconData icon,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 50),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                // Retry and Next buttons
                Row(
                  children: [
                    // Retry button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            selectedAnswer = null;
                            isCorrect = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Next button
                    if (isCorrect == true)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Go to next level
                          int nextLevel = widget.level + 1;
                          if (nextLevel <= GameData.getTotalLevels()) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        EquationGameScreen(level: nextLevel),
                              ),
                            );
                          } else {
                            // No more levels, go back to home
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/svg/background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color(0xFF1E0A32));
              },
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header with pause, level, timer, and help
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Pause button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PauseScreen()));
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isPaused ? Icons.play_arrow : Icons.pause,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),

                      // Level title
                      Text(
                        'Level ${widget.level}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // Timer icon and help icon
                      Row(
                        children: [
                          // Timer/Ad icon (red circle with play)
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Help icon
                          GestureDetector(
                            onTap: () {
                              // Help action
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.help_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Round, Timer, and Score info
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Round info
                      Text(
                        'Round $currentRound/7',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Timer
                      Text(
                        _formatTime(timeRemaining),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Score
                      Text(
                        'Score $score',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Book with equation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Book image
                      Image.asset(
                        'assets/svg/book.png',
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                      // Equation text on book
                      Text(
                        gameLevel.equation,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Answer options - 2x2 grid with rounded rectangles
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // First row of options
                      Row(
                        children: [
                          Expanded(
                            child: _buildOptionButton(gameLevel.options[0]),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildOptionButton(gameLevel.options[1]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Second row of options
                      Row(
                        children: [
                          Expanded(
                            child: _buildOptionButton(gameLevel.options[2]),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildOptionButton(gameLevel.options[3]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(int option) {
    // Determine button color based on selection
    Color buttonColor = const Color(0xFF3D3D4E);
    Color circleColor = Colors.white.withOpacity(0.5);
    bool isSelected = selectedAnswer == option;

    if (isSelected && isCorrect == true) {
      buttonColor = Colors.green;
      circleColor = Colors.white;
    } else if (isSelected && isCorrect == false) {
      buttonColor = Colors.red;
      circleColor = Colors.white;
    }

    return GestureDetector(
      onTap: selectedAnswer == null ? () => _selectAnswer(option) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            // Circle indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(color: circleColor, width: 2),
              ),
              child:
                  isSelected
                      ? Icon(
                        isCorrect == true ? Icons.check : Icons.close,
                        size: 16,
                        color: buttonColor,
                      )
                      : null,
            ),
            const SizedBox(width: 16),
            // Option value
            Text(
              '$option',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
