// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage level progress persistence using SharedPreferences
class LevelProgressService {
  static const String _keyHighestLevel = 'highest_level_completed';
  static const String _keyLevelCompletionPrefix = 'level_completed_';
  static const String _keyLevelScorePrefix = 'level_score_';

  static LevelProgressService? _instance;
  SharedPreferences? _prefs;

  // Singleton pattern
  LevelProgressService._();

  static LevelProgressService get instance {
    _instance ??= LevelProgressService._();
    return _instance!;
  }

  /// Initialize the service - must be called before using any other methods
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get the highest level completed by the player
  /// Returns 0 if no level has been completed yet
  int getHighestLevelCompleted() {
    return _prefs?.getInt(_keyHighestLevel) ?? 0;
  }

  /// Update the highest level completed
  /// Only updates if the new level is higher than the current highest
  Future<void> updateHighestLevelCompleted(int level) async {
    final currentHighest = getHighestLevelCompleted();
    if (level > currentHighest) {
      await _prefs?.setInt(_keyHighestLevel, level);
    }
  }

  /// Mark a specific level as completed
  Future<void> markLevelCompleted(int level, {int score = 0}) async {
    await _prefs?.setBool('$_keyLevelCompletionPrefix$level', true);
    await _prefs?.setInt('$_keyLevelScorePrefix$level', score);
    await updateHighestLevelCompleted(level);
  }

  /// Check if a specific level is completed
  bool isLevelCompleted(int level) {
    return _prefs?.getBool('$_keyLevelCompletionPrefix$level') ?? false;
  }

  /// Get the score for a specific level
  /// Returns 0 if the level hasn't been completed
  int getLevelScore(int level) {
    return _prefs?.getInt('$_keyLevelScorePrefix$level') ?? 0;
  }

  /// Check if a level is unlocked
  /// Level 1 is always unlocked
  /// A level is unlocked if the previous level is completed
  bool isLevelUnlocked(int level) {
    if (level <= 1) return true;
    final highestCompleted = getHighestLevelCompleted();
    return level <= highestCompleted + 1;
  }

  /// Get the total number of completed levels
  int getTotalCompletedLevels() {
    return getHighestLevelCompleted();
  }

  /// Reset all progress (useful for testing or reset functionality)
  Future<void> resetAllProgress() async {
    await _prefs?.clear();
  }

  /// Get all level completion data as a map
  /// Returns a map where key is level number and value is completion status
  Map<int, bool> getAllLevelCompletions(int totalLevels) {
    final Map<int, bool> completions = {};
    for (int i = 1; i <= totalLevels; i++) {
      completions[i] = isLevelCompleted(i);
    }
    return completions;
  }

  /// Get all level scores as a map
  /// Returns a map where key is level number and value is the score
  Map<int, int> getAllLevelScores(int totalLevels) {
    final Map<int, int> scores = {};
    for (int i = 1; i <= totalLevels; i++) {
      scores[i] = getLevelScore(i);
    }
    return scores;
  }

  /// For debugging: Print current progress state
  void printProgressState(int totalLevels) {
    print('=== Level Progress State ===');
    print('Highest Level Completed: ${getHighestLevelCompleted()}');
    print('Total Completed Levels: ${getTotalCompletedLevels()}');
    print('\nLevel Details:');
    for (int i = 1; i <= totalLevels; i++) {
      final completed = isLevelCompleted(i);
      final unlocked = isLevelUnlocked(i);
      final score = getLevelScore(i);
      print('Level $i: ${completed ? "Completed" : unlocked ? "Unlocked" : "Locked"} (Score: $score)');
    }
    print('===========================');
  }
}
