import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'game_screen.dart';
import 'game_data.dart';
import 'services/level_progress_service.dart';
import 'utils/help_dialog.dart';

class EquationGameHomeScreen extends StatefulWidget {
  const EquationGameHomeScreen({super.key});

  @override
  State<EquationGameHomeScreen> createState() => _EquationGameHomeScreenState();
}

class _EquationGameHomeScreenState extends State<EquationGameHomeScreen> {
  final LevelProgressService _progressService = LevelProgressService.instance;
  int? selectedLevel; // Track the selected level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/homeback.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color.fromARGB(255, 32, 1, 52));
              },
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Top section with navigation and game preview
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // Navigation bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => {},
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showHelpDialog(context);
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/help.png',
                                      fit: BoxFit.contain,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container();
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    Share.share(
                                      'Check out Solve Equation Game! Test your math skills and solve equations quickly. Download now!',
                                      subject: 'Play Solve Equation Game',
                                    );
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/share.png',
                                      fit: BoxFit.contain,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Game preview area - Equation display
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 0.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Equation display with book background
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Background book image
                                      Image.asset(
                                        'assets/images/book.png',
                                        width: 280,
                                        height: 150,
                                        fit: BoxFit.contain,
                                      ),

                                      const Text(
                                        '4 + 5 = ?',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  // Answer options
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF34C759),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '5',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF8E8E93),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF8E8E93),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF8E8E93),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '9',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom sheet
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header section
                            const Text(
                              'Games',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF007AFF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Solve Equation',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Levels section
                            const Text(
                              'Levels',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Level selector
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    GameData.getTotalLevels(), // Use dynamic level count
                                itemBuilder: (context, index) {
                                  final levelNumber = index + 1;
                                  final isCompleted = _progressService
                                      .isLevelCompleted(levelNumber);
                                  final isUnlocked = _progressService
                                      .isLevelUnlocked(levelNumber);

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: LevelItem(
                                      levelNumber: levelNumber,
                                      isCompleted: isCompleted,
                                      isUnlocked: isUnlocked,
                                      isSelected: selectedLevel == levelNumber,
                                      onTap: () {
                                        // Select level instead of navigating
                                        setState(() {
                                          selectedLevel = levelNumber;
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Benefits section
                            const Text(
                              'Benefits',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),

                            const BenefitItem(
                              icon: Icons.psychology_outlined,
                              title: 'Math Skills Enhancement',
                              description:
                                  'Improve your arithmetic and problem-solving abilities through engaging practice.',
                            ),
                            const SizedBox(height: 16),
                            const BenefitItem(
                              icon: Icons.flash_on_outlined,
                              title: 'Logical Thinking',
                              description:
                                  'Enhance your ability to think logically and understand mathematical patterns.',
                            ),
                            const SizedBox(height: 16),
                            const BenefitItem(
                              icon: Icons.timer_outlined,
                              title: 'Quick Mental Calculations',
                              description:
                                  'Boost the speed at which you perform mental arithmetic and solve equations.',
                            ),

                            const SizedBox(height: 24),

                            // Start button (requires level selection)
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: selectedLevel != null
                                    ? () {
                                        // Start game with selected level
                                        _startEquationGame(context, selectedLevel!);
                                      }
                                    : null, // Disable if no level selected
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007AFF),
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.grey,
                                  disabledForegroundColor: Colors.white60,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  selectedLevel != null
                                      ? 'Start Level $selectedLevel'
                                      : 'Select a Level to Start',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ), // Add bottom padding for scroll
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startEquationGame(BuildContext context, int level) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EquationGameScreen(level: level)),
    );
    // Refresh the UI when returning from the game to show updated progress
    setState(() {});
  }
}

class LevelItem extends StatelessWidget {
  final int levelNumber;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isSelected;
  final VoidCallback? onTap;

  const LevelItem({
    super.key,
    required this.levelNumber,
    required this.isCompleted,
    required this.isUnlocked,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    late Widget icon;

    if (isCompleted) {
      // Completed level - green check
      icon = Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFF34C759),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 24),
      );
    } else if (isUnlocked) {
      // Playable level - blue play
      icon = Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFF007AFF),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
      );
    } else {
      // Locked level - grey lock
      icon = Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFD1D1D6),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Icon(Icons.lock, color: Colors.white, size: 24),
      );
    }

    return GestureDetector(
      onTap: isUnlocked ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: const Color(0xFF007AFF), width: 3)
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              '$levelNumber',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF007AFF) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const BenefitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF007AFF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6D6D80),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
