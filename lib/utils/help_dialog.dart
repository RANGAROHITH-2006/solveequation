import 'package:flutter/material.dart';

void showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'How to Play',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• Solve simple math equations quickly',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '• Select the correct answer from 4 options',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '• Correct answer: +10 points',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '• Wrong answer: -5 points',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '• Complete all 7 rounds before time runs out',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              '• Beat each level to unlock the next one',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Got it!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF007AFF),
              ),
            ),
          ),
        ],
      );
    },
  );
}
