class GameQuestion {
  final String equation;
  final int correctAnswer;
  final List<int> options;

  const GameQuestion({
    required this.equation,
    required this.correctAnswer,
    required this.options,
  });
}

class GameLevel {
  final int level;
  final List<GameQuestion> questions; // 7 questions per level
  final int timeLimit; // in seconds
  final int pointsPerCorrect;

  const GameLevel({
    required this.level,
    required this.questions,
    this.timeLimit = 60,
    this.pointsPerCorrect = 10,
  });
}

class GameData {
  static const int roundsPerLevel = 7;

  static const List<GameLevel> levels = [
    // Level 1 - Basic Addition
    GameLevel(
      level: 1,
      questions: [
        GameQuestion(equation: "2 + 5 = ?", correctAnswer: 7, options: [5, 7, 9, 11]),
        GameQuestion(equation: "3 + 4 = ?", correctAnswer: 7, options: [6, 7, 8, 9]),
        GameQuestion(equation: "8 + 2 = ?", correctAnswer: 10, options: [8, 9, 10, 11]),
        GameQuestion(equation: "5 + 6 = ?", correctAnswer: 11, options: [10, 11, 12, 13]),
        GameQuestion(equation: "9 + 3 = ?", correctAnswer: 12, options: [11, 12, 13, 14]),
        GameQuestion(equation: "7 + 5 = ?", correctAnswer: 12, options: [10, 11, 12, 13]),
        GameQuestion(equation: "4 + 8 = ?", correctAnswer: 12, options: [10, 11, 12, 14]),
      ],
    ),

    // Level 2 - Basic Subtraction
    GameLevel(
      level: 2,
      questions: [
        GameQuestion(equation: "10 - 3 = ?", correctAnswer: 7, options: [5, 6, 7, 8]),
        GameQuestion(equation: "15 - 8 = ?", correctAnswer: 7, options: [5, 7, 9, 11]),
        GameQuestion(equation: "12 - 5 = ?", correctAnswer: 7, options: [6, 7, 8, 9]),
        GameQuestion(equation: "18 - 9 = ?", correctAnswer: 9, options: [7, 8, 9, 10]),
        GameQuestion(equation: "20 - 7 = ?", correctAnswer: 13, options: [11, 12, 13, 14]),
        GameQuestion(equation: "14 - 6 = ?", correctAnswer: 8, options: [6, 7, 8, 9]),
        GameQuestion(equation: "16 - 9 = ?", correctAnswer: 7, options: [5, 6, 7, 8]),
      ],
    ),

    // Level 3 - Basic Multiplication
    GameLevel(
      level: 3,
      questions: [
        GameQuestion(equation: "2 × 3 = ?", correctAnswer: 6, options: [4, 5, 6, 7]),
        GameQuestion(equation: "4 × 5 = ?", correctAnswer: 20, options: [16, 18, 20, 22]),
        GameQuestion(equation: "6 × 4 = ?", correctAnswer: 24, options: [20, 24, 28, 30]),
        GameQuestion(equation: "3 × 7 = ?", correctAnswer: 21, options: [18, 21, 24, 27]),
        GameQuestion(equation: "5 × 5 = ?", correctAnswer: 25, options: [20, 25, 30, 35]),
        GameQuestion(equation: "8 × 3 = ?", correctAnswer: 24, options: [21, 24, 27, 30]),
        GameQuestion(equation: "7 × 4 = ?", correctAnswer: 28, options: [24, 26, 28, 32]),
      ],
    ),

    // Level 4 - Basic Division
    GameLevel(
      level: 4,
      questions: [
        GameQuestion(equation: "12 ÷ 3 = ?", correctAnswer: 4, options: [3, 4, 5, 6]),
        GameQuestion(equation: "20 ÷ 4 = ?", correctAnswer: 5, options: [4, 5, 6, 7]),
        GameQuestion(equation: "36 ÷ 6 = ?", correctAnswer: 6, options: [4, 6, 8, 9]),
        GameQuestion(equation: "45 ÷ 9 = ?", correctAnswer: 5, options: [4, 5, 6, 7]),
        GameQuestion(equation: "24 ÷ 8 = ?", correctAnswer: 3, options: [2, 3, 4, 5]),
        GameQuestion(equation: "56 ÷ 7 = ?", correctAnswer: 8, options: [6, 7, 8, 9]),
        GameQuestion(equation: "72 ÷ 9 = ?", correctAnswer: 8, options: [6, 7, 8, 9]),
      ],
    ),

    // Level 5 - Mixed Operations (Easy)
    GameLevel(
      level: 5,
      questions: [
        GameQuestion(equation: "12 + 18 = ?", correctAnswer: 30, options: [28, 30, 32, 35]),
        GameQuestion(equation: "25 - 17 = ?", correctAnswer: 8, options: [6, 7, 8, 9]),
        GameQuestion(equation: "6 × 7 = ?", correctAnswer: 42, options: [36, 42, 48, 54]),
        GameQuestion(equation: "48 ÷ 6 = ?", correctAnswer: 8, options: [6, 7, 8, 9]),
        GameQuestion(equation: "33 + 27 = ?", correctAnswer: 60, options: [55, 58, 60, 62]),
        GameQuestion(equation: "50 - 23 = ?", correctAnswer: 27, options: [25, 27, 29, 31]),
        GameQuestion(equation: "9 × 8 = ?", correctAnswer: 72, options: [64, 72, 80, 81]),
      ],
    ),

    // Level 6 - Addition (Medium)
    GameLevel(
      level: 6,
      questions: [
        GameQuestion(equation: "45 + 37 = ?", correctAnswer: 82, options: [78, 80, 82, 84]),
        GameQuestion(equation: "68 + 24 = ?", correctAnswer: 92, options: [88, 90, 92, 94]),
        GameQuestion(equation: "53 + 49 = ?", correctAnswer: 102, options: [98, 100, 102, 104]),
        GameQuestion(equation: "76 + 38 = ?", correctAnswer: 114, options: [110, 112, 114, 116]),
        GameQuestion(equation: "89 + 45 = ?", correctAnswer: 134, options: [130, 132, 134, 136]),
        GameQuestion(equation: "57 + 66 = ?", correctAnswer: 123, options: [119, 121, 123, 125]),
        GameQuestion(equation: "94 + 28 = ?", correctAnswer: 122, options: [118, 120, 122, 124]),
      ],
    ),

    // Level 7 - Multiplication (Medium)
    GameLevel(
      level: 7,
      questions: [
        GameQuestion(equation: "7 × 8 = ?", correctAnswer: 56, options: [52, 56, 60, 64]),
        GameQuestion(equation: "9 × 9 = ?", correctAnswer: 81, options: [72, 79, 81, 90]),
        GameQuestion(equation: "12 × 5 = ?", correctAnswer: 60, options: [55, 58, 60, 65]),
        GameQuestion(equation: "11 × 7 = ?", correctAnswer: 77, options: [70, 74, 77, 84]),
        GameQuestion(equation: "8 × 12 = ?", correctAnswer: 96, options: [88, 92, 96, 104]),
        GameQuestion(equation: "6 × 15 = ?", correctAnswer: 90, options: [84, 88, 90, 95]),
        GameQuestion(equation: "9 × 11 = ?", correctAnswer: 99, options: [90, 95, 99, 108]),
      ],
    ),

    // Level 8 - Division (Medium)
    GameLevel(
      level: 8,
      questions: [
        GameQuestion(equation: "84 ÷ 7 = ?", correctAnswer: 12, options: [10, 11, 12, 14]),
        GameQuestion(equation: "96 ÷ 8 = ?", correctAnswer: 12, options: [10, 12, 14, 16]),
        GameQuestion(equation: "108 ÷ 9 = ?", correctAnswer: 12, options: [10, 11, 12, 13]),
        GameQuestion(equation: "144 ÷ 12 = ?", correctAnswer: 12, options: [10, 11, 12, 14]),
        GameQuestion(equation: "110 ÷ 11 = ?", correctAnswer: 10, options: [8, 9, 10, 11]),
        GameQuestion(equation: "78 ÷ 6 = ?", correctAnswer: 13, options: [11, 12, 13, 14]),
        GameQuestion(equation: "91 ÷ 7 = ?", correctAnswer: 13, options: [11, 12, 13, 14]),
      ],
    ),

    // Level 9 - Mixed Operations (Hard)
    GameLevel(
      level: 9,
      questions: [
        GameQuestion(equation: "23 + 29 = ?", correctAnswer: 52, options: [50, 52, 54, 56]),
        GameQuestion(equation: "84 - 36 = ?", correctAnswer: 48, options: [46, 48, 50, 52]),
        GameQuestion(equation: "13 × 7 = ?", correctAnswer: 91, options: [84, 91, 98, 105]),
        GameQuestion(equation: "156 ÷ 12 = ?", correctAnswer: 13, options: [11, 12, 13, 14]),
        GameQuestion(equation: "67 + 78 = ?", correctAnswer: 145, options: [141, 143, 145, 147]),
        GameQuestion(equation: "125 - 58 = ?", correctAnswer: 67, options: [63, 65, 67, 69]),
        GameQuestion(equation: "15 × 9 = ?", correctAnswer: 135, options: [125, 130, 135, 145]),
      ],
    ),

    // Level 10 - Challenge Level
    GameLevel(
      level: 10,
      questions: [
        GameQuestion(equation: "256 + 189 = ?", correctAnswer: 445, options: [435, 440, 445, 450]),
        GameQuestion(equation: "500 - 237 = ?", correctAnswer: 263, options: [257, 260, 263, 267]),
        GameQuestion(equation: "25 × 16 = ?", correctAnswer: 400, options: [375, 400, 425, 450]),
        GameQuestion(equation: "225 ÷ 15 = ?", correctAnswer: 15, options: [12, 13, 15, 18]),
        GameQuestion(equation: "178 + 294 = ?", correctAnswer: 472, options: [462, 468, 472, 478]),
        GameQuestion(equation: "18 × 17 = ?", correctAnswer: 306, options: [289, 298, 306, 324]),
        GameQuestion(equation: "324 ÷ 18 = ?", correctAnswer: 18, options: [16, 17, 18, 19]),
      ],
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
