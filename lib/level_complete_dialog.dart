import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solveequationgame/game_data.dart';

/// Self-contained Level Complete dialog with coin-drop + score-count animation.
///
/// Usage:
///   LevelCompleteDialog.show(
///     context: context,
///     level: 1,
///     score: 123,
///     startScoreKey: myScoreGlobalKeyOrNull, // optional: GlobalKey of score widget to animate from
///     hasNext: true,
///     onNext: () { /* navigate to next level or home */ },
///   );
class LevelCompleteDialog extends StatefulWidget {
  final int level;
  final int score;
  final GlobalKey? startScoreKey; // optional source position
  final bool hasNext;
  final VoidCallback onNext;

  const LevelCompleteDialog({
    Key? key,
    required this.level,
    required this.score,
    required this.onNext,
    this.startScoreKey,
    this.hasNext = true,
  }) : super(key: key);

  static Future<void> show({
    required BuildContext context,
    required int level,
    required int score,
    GlobalKey? startScoreKey,
    required VoidCallback onNext,
    bool hasNext = true,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LevelCompleteDialog(
        level: level,
        score: score,
        startScoreKey: startScoreKey,
        hasNext: hasNext,
        onNext: onNext,
      ),
    );
  }

  @override
  _LevelCompleteDialogState createState() => _LevelCompleteDialogState();
}

class _LevelCompleteDialogState extends State<LevelCompleteDialog>
    with TickerProviderStateMixin {
  // Countdown before auto-next
  int countdown = 10;
  Timer? _countdownTimer;

  // Score animation
  late AnimationController _scoreController;
  late Animation<int> _scoreAnimation;

  // Coin drop
  final int _coinCount = 10;
  final List<AnimationController> _coinControllers = [];
  final List<Animation<double>> _coinAnims = [];
  final List<double> _coinXOffsets = [];
  final List<bool> _coinActive = [];
  final Random _rand = Random();

  // Positioning (start = where coins originate, end = popup score icon position)
  double _startX = 0, _startY = -100, _endX = 0, _endY = 0;

  // Keys inside the popup to compute target
  final GlobalKey _popupScoreKey = GlobalKey();
  final GlobalKey _popupScoreIconKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculatePositionsAndStart();
    });
    _startCountdown();
  }

  void _initAnimations() {
    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scoreAnimation = IntTween(begin: 0, end: widget.score).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeOut),
    )..addListener(() => setState(() {}));

    for (int i = 0; i < _coinCount; i++) {
      final ctl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
      );
      final anim = CurvedAnimation(parent: ctl, curve: Curves.easeInOut);
      anim.addListener(() {
        if (mounted) setState(() {});
      });
      ctl.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          HapticFeedback.lightImpact();
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() {
                if (i < _coinActive.length) _coinActive[i] = false;
              });
            }
          });
        }
      });

      _coinControllers.add(ctl);
      _coinAnims.add(anim);
      // small horizontal jitter
      _coinXOffsets.add((_rand.nextDouble() * 6.0) - 3.0);
      _coinActive.add(true);
    }
  }

  void _calculatePositionsAndStart() {
    try {
      final overlayBox = context.findRenderObject() as RenderBox?;
      if (overlayBox == null) throw Exception('Overlay box null');

      // If caller provided a startScoreKey, try to use its center as start
      Offset startLocal;
      if (widget.startScoreKey != null) {
        final RenderBox? scoreBox = widget.startScoreKey!.currentContext
            ?.findRenderObject() as RenderBox?;
        if (scoreBox != null) {
          final scoreGlobal = scoreBox.localToGlobal(Offset.zero);
          final overlayGlobal = overlayBox.localToGlobal(Offset.zero);
          final startCenterGlobal = Offset(
            scoreGlobal.dx + scoreBox.size.width / 2,
            scoreGlobal.dy + scoreBox.size.height / 2,
          );
          startLocal = startCenterGlobal - overlayGlobal;
        } else {
          throw Exception('Start score renderbox not found');
        }
      } else {
        // Fallback: start at top-center of screen
        final w = MediaQuery.of(context).size.width;
        startLocal = Offset(w / 2, 100);
      }

      // target (popup icon) center
      Offset endLocal;
      final RenderBox? iconBox =
          _popupScoreIconKey.currentContext?.findRenderObject() as RenderBox?;
      if (iconBox != null) {
        final iconGlobal = iconBox.localToGlobal(Offset.zero);
        final overlayGlobal = overlayBox.localToGlobal(Offset.zero);
        final iconCenterGlobal =
            Offset(iconGlobal.dx + iconBox.size.width / 2, iconGlobal.dy + iconBox.size.height / 2);
        endLocal = iconCenterGlobal - overlayGlobal;
      } else {
        // fallback: center of dialog area
        final w = MediaQuery.of(context).size.width;
        endLocal = Offset(w / 2, MediaQuery.of(context).size.height / 2);
      }

      setState(() {
        _startX = startLocal.dx;
        _startY = startLocal.dy;
        _endX = endLocal.dx;
        _endY = endLocal.dy;

        // start coin animations staggered
        for (int i = 0; i < _coinControllers.length; i++) {
          Future.delayed(Duration(milliseconds: 120 * i), () {
            if (mounted) _coinControllers[i].forward();
          });
        }
        // start score count slightly delayed
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _scoreController.forward();
        });
      });
    } catch (_) {
      // fallback positions and still start animations
      setState(() {
        _startX = MediaQuery.of(context).size.width / 2;
        _startY = 80;
        _endX = MediaQuery.of(context).size.width / 2;
        _endY = MediaQuery.of(context).size.height / 2;
      });
      for (int i = 0; i < _coinControllers.length; i++) {
        Future.delayed(Duration(milliseconds: 120 * i), () {
          if (mounted) _coinControllers[i].forward();
        });
      }
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _scoreController.forward();
      });
    }
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (countdown > 1) {
        setState(() => countdown--);
      } else {
        t.cancel();
        // First dismiss the dialog, then trigger the onNext navigation
        if (mounted) Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 80), () {
          try {
            widget.onNext();
          } catch (_) {}
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _scoreController.dispose();
    for (final c in _coinControllers) c.dispose();
    super.dispose();
  }

  // Quadratic Bezier for coin path
  Offset _computeCoinBezier(int i, double t) {
    final p0 = Offset(_startX + _coinXOffsets[i] - 20, _startY - 20);
    final p2 = Offset(_endX - 20 - 12, _endY - 20);
    final midX = (p0.dx + p2.dx) / 2;
    final midY = (p0.dy + p2.dy) / 2;
    final control = Offset(midX + (i.isEven ? -20.0 : 20.0), midY - 80.0);

    double oneMinusT = 1.0 - t;
    double x = oneMinusT * oneMinusT * p0.dx +
        2 * oneMinusT * t * control.dx +
        t * t * p2.dx;
    double y = oneMinusT * oneMinusT * p0.dy +
        2 * oneMinusT * t * control.dy +
        t * t * p2.dy;
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox.expand(
        child: Stack(
          children: [
            Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // top image
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Image.asset(
                        'assets/images/completed.png',
                        width: 180,
                        height: 140,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.emoji_events, color: Colors.amber, size: 80),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E2E),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                _countdownTimer?.cancel();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.06),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text('🎉 Great job! 🎉', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 140,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Your Score', style: TextStyle(fontSize: 24, color: Colors.white70)),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/score.png',
                                          key: _popupScoreIconKey,
                                          width: 36,
                                          height: 36,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) {
                                            return const Icon(Icons.workspace_premium, color: Colors.amber, size: 28);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${_scoreAnimation.value}',
                                          key: _popupScoreKey,
                                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _countdownTimer?.cancel();
                                if (mounted) Navigator.of(context).pop();
                                Future.delayed(const Duration(milliseconds: 80), () {
                                  try {
                                    widget.onNext();
                                  } catch (_) {}
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B82F6),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                              ),
                              child: Text(widget.level < GameData.getTotalLevels()? 'Next Level' : 'Home', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text('Next level starts in ${countdown}s', style: const TextStyle(fontSize: 16, color: Colors.white54)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Coins overlay
            for (int i = 0; i < _coinCount; i++)
              if (i < _coinActive.length && _coinActive[i])
                Builder(builder: (ctx) {
                  final t = _coinAnims[i].value.clamp(0.0, 1.0);
                  final pos = _computeCoinBezier(i, t);
                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: t,
                        child: Image.asset('assets/images/score.png', width: 40, height: 40, errorBuilder: (_, __, ___) => const Icon(Icons.workspace_premium, color: Colors.amber, size: 36)),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
