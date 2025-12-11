// // Quick Reference: Common Level Progress Operations

// import 'package:solveequationgame/services/level_progress_service.dart';

// void main() {
//   // Get the service instance
//   final progressService = LevelProgressService.instance;
  
//   // ============================================
//   // CHECKING LEVEL STATUS
//   // ============================================
  
//   // Check if a level is unlocked
//   bool isLevel5Unlocked = progressService.isLevelUnlocked(5);
//   print('Level 5 unlocked: $isLevel5Unlocked');
  
//   // Check if a level is completed
//   bool isLevel3Completed = progressService.isLevelCompleted(3);
//   print('Level 3 completed: $isLevel3Completed');
  
//   // Get the highest level completed
//   int highestLevel = progressService.getHighestLevelCompleted();
//   print('Highest level completed: $highestLevel');
  
//   // ============================================
//   // UPDATING PROGRESS
//   // ============================================
  
//   // Mark a level as completed with a score
//   progressService.markLevelCompleted(3, score: 85);
  
//   // Update highest level completed (only if higher than current)
//   progressService.updateHighestLevelCompleted(5);
  
//   // ============================================
//   // RETRIEVING DATA
//   // ============================================
  
//   // Get score for a specific level
//   int level3Score = progressService.getLevelScore(3);
//   print('Level 3 score: $level3Score');
  
//   // Get total number of completed levels
//   int totalCompleted = progressService.getTotalCompletedLevels();
//   print('Total completed levels: $totalCompleted');
  
//   // Get all level completions as a map
//   Map<int, bool> allCompletions = progressService.getAllLevelCompletions(10);
//   print('All completions: $allCompletions');
  
//   // Get all level scores as a map
//   Map<int, int> allScores = progressService.getAllLevelScores(10);
//   print('All scores: $allScores');
  
//   // ============================================
//   // DEBUGGING & TESTING
//   // ============================================
  
//   // Print current progress state for all levels
//   progressService.printProgressState(10);
  
//   // Reset all progress (useful for testing)
//   progressService.resetAllProgress();
  
//   // ============================================
//   // TYPICAL GAME FLOW EXAMPLE
//   // ============================================
  
//   // When player starts the game (first time)
//   // Only Level 1 is unlocked, rest are locked
  
//   // When player completes Level 1:
//   progressService.markLevelCompleted(1, score: 70);
//   // Now Level 2 becomes unlocked automatically
  
//   // When player completes Level 2:
//   progressService.markLevelCompleted(2, score: 85);
//   // Now Level 3 becomes unlocked
  
//   // And so on...
  
//   // ============================================
//   // IN HOME SCREEN (ListView.builder)
//   // ============================================
  
//   // itemBuilder: (context, index) {
//   //   final levelNumber = index + 1;
//   //   final isCompleted = progressService.isLevelCompleted(levelNumber);
//   //   final isUnlocked = progressService.isLevelUnlocked(levelNumber);
//   //   
//   //   return LevelItem(
//   //     levelNumber: levelNumber,
//   //     isCompleted: isCompleted,
//   //     isUnlocked: isUnlocked,
//   //     onTap: () {
//   //       if (isUnlocked) {
//   //         // Navigate to game
//   //       }
//   //     },
//   //   );
//   // }
  
//   // ============================================
//   // IN GAME SCREEN (Level Completion)
//   // ============================================
  
//   // void _onLevelComplete() {
//   //   final progressService = LevelProgressService.instance;
//   //   progressService.markLevelCompleted(widget.level, score: score);
//   //   // Show completion popup
//   //   _showCompletionDialog();
//   // }
// }
