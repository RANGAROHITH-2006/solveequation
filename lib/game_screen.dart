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

  // Get current question based on round
  GameQuestion get currentQuestion => gameLevel.questions[currentRound - 1];

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startTimer();
  }

  void _initializeGame() {
    gameLevel = GameData.getLevelData(widget.level) ?? GameData.levels.first;
    timeRemaining = gameLevel.timeLimit;
    currentRound = 1;
    score = 0;
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
      isCorrect = answer == currentQuestion.correctAnswer;
    });

    if (isCorrect!) {
      // Correct answer: +10 points
      setState(() {
        score += 10;
      });
      // Check if this was the last round
      if (currentRound >= GameData.roundsPerLevel) {
        // Level completed - show completion popup
        Future.delayed(const Duration(milliseconds: 500), () {
          _showLevelCompletePopup();
        });
      } else {
        // Auto proceed to next round after a brief delay
        Future.delayed(const Duration(milliseconds: 500), () {
          _goToNextRound();
        });
      }
    } else {
      // Wrong answer: -5 points
      setState(() {
        score -= 5;
        if (score < 0) score = 0; // Don't go below 0
      });
      // Show wrong answer popup with both answers
      _showWrongAnswerPopup(answer, currentQuestion.correctAnswer);
    }
  }

  void _showWrongAnswerPopup(int userAnswer, int correctAnswer) {
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
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.cancel, color: Colors.red, size: 50),
                ),
                const SizedBox(height: 16),
                // Title with -5
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Wrong !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '-5',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Answer comparison
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // User's answer
                    Column(
                      children: [
                        const Text(
                          'Your Answer',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Text(
                            '$userAnswer',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Correct answer
                    Column(
                      children: [
                        const Text(
                          'Correct Answer',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: Text(
                            '$correctAnswer',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Retry button
                SizedBox(
                  width: double.infinity,
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
                      'Try Again',
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
          ),
        );
      },
    );
  }

  void _goToNextRound() {
    setState(() {
      currentRound++;
      selectedAnswer = null;
      isCorrect = null;
    });
  }

  void _showLevelCompletePopup() {
    gameTimer?.cancel();
    int countdown = 10;
    Timer? countdownTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Start countdown timer
            countdownTimer ??= Timer.periodic(const Duration(seconds: 1), (
              timer,
            ) {
              if (countdown > 0) {
                setDialogState(() {
                  countdown--;
                });
              } else {
                timer.cancel();
                // Auto navigate to next level
                Navigator.of(context).pop();
                int nextLevel = widget.level + 1;
                if (nextLevel <= GameData.getTotalLevels()) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder:
                          (context) => EquationGameScreen(level: nextLevel),
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              }
            });

            return WillPopScope(
              onWillPop: () async {
                countdownTimer?.cancel();
                return true;
              },
              child: Scaffold(
                backgroundColor: Colors.transparent,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PauseScreen(),
                            ),
                          );
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

                          const Spacer(flex: 1),
                          // Level Up Image
                          Image.asset(
                            'assets/svg/completed.png',
                            width: 250,
                            height: 200,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.emoji_events,
                                  color: Colors.amber,
                                  size: 100,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          // Bottom card
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E2E),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Great job! title
                                const Text(
                                  'Great job!',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Your Score label
                                const Text(
                                  'Your Score',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Score with medal icon
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.workspace_premium,
                                      color: Colors.amber,
                                      size: 36,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$score',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // Next Level button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      countdownTimer?.cancel();
                                      Navigator.of(context).pop();
                                      int nextLevel = widget.level + 1;
                                      if (nextLevel <=
                                          GameData.getTotalLevels()) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder:
                                                (context) => EquationGameScreen(
                                                  level: nextLevel,
                                                ),
                                          ),
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3B82F6),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      widget.level < GameData.getTotalLevels()
                                          ? 'Next Level'
                                          : 'Home',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Countdown text
                                Text(
                                  'Next level starts in ${countdown.toString().padLeft(2, '0')} : ${(countdown % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PauseScreen(),
                            ),
                          );
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
                        currentQuestion.equation,
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
                            child: _buildOptionButton(
                              currentQuestion.options[0],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildOptionButton(
                              currentQuestion.options[1],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Second row of options
                      Row(
                        children: [
                          Expanded(
                            child: _buildOptionButton(
                              currentQuestion.options[2],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildOptionButton(
                              currentQuestion.options[3],
                            ),
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
