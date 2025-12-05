import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'game_data.dart';

class EquationGameHomeScreen extends StatelessWidget {
  const EquationGameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        32,
        1,
        52,
      ), // Purple background
      body: SafeArea(
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
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Help action
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.help_outline,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // Share action
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 24,
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
                                    'assets/svg/book.png',
                                    width: 280,
                                    height: 150,
                                    fit: BoxFit.contain,
                                  ),
                                  // Equation text on top of book
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
                          
                              const SizedBox(height: 16),
                              // Answer options
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF34C759),
                                      borderRadius: BorderRadius.circular(8),
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
                                  const SizedBox(width: 16),
                                  Container(
                                    width: 60,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8E8E93),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '8',
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
                                    width: 60,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8E8E93),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '9',
                                        style: TextStyle(
                                          color:  Color(0xFFFFFFFF),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    width: 60,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8E8E93),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '8',
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
              flex: 7,
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
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header section
                        const Text(
                          'Games',
                          style: TextStyle(
                            fontSize: 16,
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
                        const SizedBox(height: 12),

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
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: GameData.getTotalLevels(), // Use dynamic level count
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: LevelItem(
                                  levelNumber: index + 1,
                                  isCompleted:
                                      index < 3, // First 3 levels completed
                                  isUnlocked:
                                      index < 5, // First 5 levels unlocked
                                  onTap: () {
                                    // Navigate to level
                                    _startEquationGame(context, index + 1);
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

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

                        // Play Game button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // Start game with level 1
                              _startEquationGame(context, 1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007AFF),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Play Game',
                              style: TextStyle(
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
    );
  }

  void _startEquationGame(BuildContext context, int level) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EquationGameScreen(level: level)),
    );
  }
}

class LevelItem extends StatelessWidget {
  final int levelNumber;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const LevelItem({
    super.key,
    required this.levelNumber,
    required this.isCompleted,
    required this.isUnlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    late Widget icon;

    if (isCompleted) {
      // Completed level - green check
      icon = Container(
        width: 48,
        height: 48,
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
        width: 48,
        height: 48,
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
        width: 48,
        height: 48,
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
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(
            '$levelNumber',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
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
