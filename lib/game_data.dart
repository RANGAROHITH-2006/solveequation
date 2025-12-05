class GameLevel {
  final int level;
  final String equation;
  final int correctAnswer;
  final List<int> options;
  final int timeLimit; // in seconds
  final int pointsPerCorrect;

  const GameLevel({
    required this.level,
    required this.equation,
    required this.correctAnswer,
    required this.options,
    this.timeLimit = 60,
    this.pointsPerCorrect = 10,
  });
}

class GameData {
  static const List<GameLevel> levels = [
    // Level 1
    GameLevel(
      level: 1,
      equation: "2+25 = ?",
      correctAnswer: 27,
      options: [7, 17, -3, 27],
    ),

    // Level 2
    GameLevel(
      level: 2,
      equation: "15-8 = ?",
      correctAnswer: 7,
      options: [5, 7, 9, 11],
    ),

    // Level 3
    GameLevel(
      level: 3,
      equation: "6×4 = ?",
      correctAnswer: 24,
      options: [20, 24, 28, 30],
    ),

    // Level 4
    GameLevel(
      level: 4,
      equation: "36÷6 = ?",
      correctAnswer: 6,
      options: [4, 6, 8, 9],
    ),

    // Level 5
    GameLevel(
      level: 5,
      equation: "12+18 = ?",
      correctAnswer: 30,
      options: [28, 30, 32, 35],
    ),

    // Level 6
    GameLevel(
      level: 6,
      equation: "45-17 = ?",
      correctAnswer: 28,
      options: [26, 28, 30, 32],
    ),

    // Level 7
    GameLevel(
      level: 7,
      equation: "7×8 = ?",
      correctAnswer: 56,
      options: [52, 56, 60, 64],
    ),

    // Level 8
    GameLevel(
      level: 8,
      equation: "72÷9 = ?",
      correctAnswer: 8,
      options: [6, 7, 8, 9],
    ),

    // Level 9
    GameLevel(
      level: 9,
      equation: "23+29 = ?",
      correctAnswer: 52,
      options: [50, 52, 54, 56],
    ),

    // Level 10
    GameLevel(
      level: 10,
      equation: "84-36 = ?",
      correctAnswer: 48,
      options: [46, 48, 50, 52],
    ),

     GameLevel(
      level: 1,
      equation: "2+25 = ?",
      correctAnswer: 27,
      options: [7, 17, -3, 27],
    ),

    // Level 2
    GameLevel(
      level: 2,
      equation: "15-8 = ?",
      correctAnswer: 7,
      options: [5, 7, 9, 11],
    ),

    // Level 3
    GameLevel(
      level: 3,
      equation: "6×4 = ?",
      correctAnswer: 24,
      options: [20, 24, 28, 30],
    ),

    // Level 4
    GameLevel(
      level: 4,
      equation: "36÷6 = ?",
      correctAnswer: 6,
      options: [4, 6, 8, 9],
    ),

    // Level 5
    GameLevel(
      level: 5,
      equation: "12+18 = ?",
      correctAnswer: 30,
      options: [28, 30, 32, 35],
    ),

    // Level 6
    GameLevel(
      level: 6,
      equation: "45-17 = ?",
      correctAnswer: 28,
      options: [26, 28, 30, 32],
    ),

    // Level 7
    GameLevel(
      level: 7,
      equation: "7×8 = ?",
      correctAnswer: 56,
      options: [52, 56, 60, 64],
    ),

    // Level 8
    GameLevel(
      level: 8,
      equation: "72÷9 = ?",
      correctAnswer: 8,
      options: [6, 7, 8, 9],
    ),

    // Level 9
    GameLevel(
      level: 9,
      equation: "23+29 = ?",
      correctAnswer: 52,
      options: [50, 52, 54, 56],
    ),

    // Level 10
    GameLevel(
      level: 10,
      equation: "84-36 = ?",
      correctAnswer: 48,
      options: [46, 48, 50, 52],
    ),

     GameLevel(
      level: 1,
      equation: "2+25 = ?",
      correctAnswer: 27,
      options: [7, 17, -3, 27],
    ),

    // Level 2
    GameLevel(
      level: 2,
      equation: "15-8 = ?",
      correctAnswer: 7,
      options: [5, 7, 9, 11],
    ),

    // Level 3
    GameLevel(
      level: 3,
      equation: "6×4 = ?",
      correctAnswer: 24,
      options: [20, 24, 28, 30],
    ),

    // Level 4
    GameLevel(
      level: 4,
      equation: "36÷6 = ?",
      correctAnswer: 6,
      options: [4, 6, 8, 9],
    ),

    // Level 5
    GameLevel(
      level: 5,
      equation: "12+18 = ?",
      correctAnswer: 30,
      options: [28, 30, 32, 35],
    ),

    // Level 6
    GameLevel(
      level: 6,
      equation: "45-17 = ?",
      correctAnswer: 28,
      options: [26, 28, 30, 32],
    ),

    // Level 7
    GameLevel(
      level: 7,
      equation: "7×8 = ?",
      correctAnswer: 56,
      options: [52, 56, 60, 64],
    ),

    // Level 8
    GameLevel(
      level: 8,
      equation: "72÷9 = ?",
      correctAnswer: 8,
      options: [6, 7, 8, 9],
    ),

    // Level 9
    GameLevel(
      level: 9,
      equation: "23+29 = ?",
      correctAnswer: 52,
      options: [50, 52, 54, 56],
    ),

    // Level 10
    GameLevel(
      level: 10,
      equation: "84-36 = ?",
      correctAnswer: 48,
      options: [46, 48, 50, 52],
    ),

     GameLevel(
      level: 1,
      equation: "2+25 = ?",
      correctAnswer: 27,
      options: [7, 17, -3, 27],
    ),

    // Level 2
    GameLevel(
      level: 2,
      equation: "15-8 = ?",
      correctAnswer: 7,
      options: [5, 7, 9, 11],
    ),

    // Level 3
    GameLevel(
      level: 3,
      equation: "6×4 = ?",
      correctAnswer: 24,
      options: [20, 24, 28, 30],
    ),

    // Level 4
    GameLevel(
      level: 4,
      equation: "36÷6 = ?",
      correctAnswer: 6,
      options: [4, 6, 8, 9],
    ),

    // Level 5
    GameLevel(
      level: 5,
      equation: "12+18 = ?",
      correctAnswer: 30,
      options: [28, 30, 32, 35],
    ),

    // Level 6
    GameLevel(
      level: 6,
      equation: "45-17 = ?",
      correctAnswer: 28,
      options: [26, 28, 30, 32],
    ),

    // Level 7
    GameLevel(
      level: 7,
      equation: "7×8 = ?",
      correctAnswer: 56,
      options: [52, 56, 60, 64],
    ),

    // Level 8
    GameLevel(
      level: 8,
      equation: "72÷9 = ?",
      correctAnswer: 8,
      options: [6, 7, 8, 9],
    ),

    // Level 9
    GameLevel(
      level: 9,
      equation: "23+29 = ?",
      correctAnswer: 52,
      options: [50, 52, 54, 56],
    ),

    // Level 10
    GameLevel(
      level: 10,
      equation: "84-36 = ?",
      correctAnswer: 48,
      options: [46, 48, 50, 52],
    ),

     GameLevel(
      level: 1,
      equation: "2+25 = ?",
      correctAnswer: 27,
      options: [7, 17, -3, 27],
    ),

    // Level 2
    GameLevel(
      level: 2,
      equation: "15-8 = ?",
      correctAnswer: 7,
      options: [5, 7, 9, 11],
    ),

    // Level 3
    GameLevel(
      level: 3,
      equation: "6×4 = ?",
      correctAnswer: 24,
      options: [20, 24, 28, 30],
    ),

    // Level 4
    GameLevel(
      level: 4,
      equation: "36÷6 = ?",
      correctAnswer: 6,
      options: [4, 6, 8, 9],
    ),

    // Level 5
    GameLevel(
      level: 5,
      equation: "12+18 = ?",
      correctAnswer: 30,
      options: [28, 30, 32, 35],
    ),

    // Level 6
    GameLevel(
      level: 6,
      equation: "45-17 = ?",
      correctAnswer: 28,
      options: [26, 28, 30, 32],
    ),

    // Level 7
    GameLevel(
      level: 7,
      equation: "7×8 = ?",
      correctAnswer: 56,
      options: [52, 56, 60, 64],
    ),

    // Level 8
    GameLevel(
      level: 8,
      equation: "72÷9 = ?",
      correctAnswer: 8,
      options: [6, 7, 8, 9],
    ),

    // Level 9
    GameLevel(
      level: 9,
      equation: "23+29 = ?",
      correctAnswer: 52,
      options: [50, 52, 54, 56],
    ),

    // Level 10
    GameLevel(
      level: 10,
      equation: "84-36 = ?",
      correctAnswer: 48,
      options: [46, 48, 50, 52],
    ),
  ];

  static GameLevel? getLevelData(int level) {
    if (level > 0 && level <= levels.length) {
      return levels[level - 1];
    }
    return null;
  }

  static int getTotalLevels() {
    return levels.length;
  }
}
