import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/app_theme.dart';
import '../../app/localization.dart';
import 'game_engine.dart';
import 'game_entities.dart';

class SpaceShooterWidget extends StatefulWidget {
  final VoidCallback onExit;
  final bool isFullScreen;

  const SpaceShooterWidget({
    super.key,
    required this.onExit,
    this.isFullScreen = false,
  });

  @override
  State<SpaceShooterWidget> createState() => _SpaceShooterWidgetState();
}

class _SpaceShooterWidgetState extends State<SpaceShooterWidget>
    with SingleTickerProviderStateMixin {
  late GameEngine engine;
  late AnimationController _ticker;
  Duration _lastTick = Duration.zero;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    engine = GameEngine();
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_onTick);
    _ticker.repeat();
    engine.startGame();
  }

  void _onTick() {
    final now = _ticker.lastElapsedDuration ?? Duration.zero;
    if (_lastTick != Duration.zero) {
      final dt = (now - _lastTick).inMicroseconds / 1000000.0;
      // Clamp dt to prevent teleportation on lag spikes
      engine.tick(dt.clamp(0.001, 0.05));
    }
    _lastTick = now;
  }

  @override
  void dispose() {
    _ticker.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.keyA) {
        engine.movePlayerRelative(-30);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        engine.movePlayerRelative(30);
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        engine.triggerPlayerShoot();
      } else if (event.logicalKey == LogicalKeyboardKey.keyP ||
          event.logicalKey == LogicalKeyboardKey.escape) {
        if (engine.status == GameStatus.playing) {
          engine.pauseGame();
        } else if (engine.status == GameStatus.paused) {
          engine.resumeGame();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          engine.updateWorldSize(constraints.maxWidth, constraints.maxHeight);

          return Container(
            color: const Color(0xFF070B18),
            child: Stack(
              children: [
                // Interactive Game Canvas with Touch & Drag support
                GestureDetector(
                  onPanDown: (details) => engine.movePlayer(details.localPosition.dx),
                  onPanUpdate: (details) => engine.movePlayer(details.localPosition.dx),
                  child: MouseRegion(
                    onHover: (event) => engine.movePlayer(event.localPosition.dx),
                    child: AnimatedBuilder(
                      animation: engine,
                      builder: (context, _) {
                        return CustomPaint(
                          size: Size(constraints.maxWidth, constraints.maxHeight),
                          painter: SpaceShooterPainter(engine: engine),
                        );
                      },
                    ),
                  ),
                ),

                // Top Game HUD
                Positioned(
                  top: 12,
                  left: 12,
                  right: 12,
                  child: _buildTopHud(),
                ),

                // Achievement Unlocked Banner Toast
                AnimatedBuilder(
                  animation: engine,
                  builder: (context, _) {
                    final ach = engine.recentAchievement;
                    if (ach == null) return const SizedBox.shrink();
                    final isId = LocaleController.instance.isId;
                    return Positioned(
                      top: 70,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: AppTheme.pixelBox(
                            borderColor: ArcadeColors.scoreYellow,
                            background: const Color(0xF0181F38),
                            glow: true,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.emoji_events, color: ArcadeColors.scoreYellow, size: 22),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "ACHIEVEMENT UNLOCKED: ${ach.title.toUpperCase()}",
                                      style: AppTheme.pixel(
                                        fontSize: 9,
                                        color: ArcadeColors.scoreYellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isId ? ach.descriptionId : ach.descriptionEn,
                                      style: AppTheme.body(fontSize: 11, color: ArcadeColors.textMain),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Wave Announcement
                AnimatedBuilder(
                  animation: engine,
                  builder: (context, _) {
                    if (engine.waveAnnouncementTimer <= 0) return const SizedBox.shrink();
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: AppTheme.pixelBox(
                          borderColor: ArcadeColors.neonCyan,
                          background: Colors.black.withValues(alpha: 0.85),
                          glow: true,
                        ),
                        child: Text(
                          engine.waveAnnouncement,
                          style: AppTheme.pixel(
                            fontSize: 22,
                            color: ArcadeColors.neonCyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Paused Screen Overlay
                AnimatedBuilder(
                  animation: engine,
                  builder: (context, _) {
                    if (engine.status != GameStatus.paused) return const SizedBox.shrink();
                    return _buildOverlay(
                      title: "GAME PAUSED",
                      titleColor: ArcadeColors.scoreYellow,
                      children: [
                        _buildActionButton(
                          label: LocaleController.instance.resume,
                          color: ArcadeColors.neonCyan,
                          onTap: engine.resumeGame,
                        ),
                        const SizedBox(height: 12),
                        _buildActionButton(
                          label: LocaleController.instance.restart,
                          color: ArcadeColors.terminalGreen,
                          onTap: engine.startGame,
                        ),
                        const SizedBox(height: 12),
                        _buildActionButton(
                          label: LocaleController.instance.exitGame,
                          color: ArcadeColors.dangerRed,
                          onTap: widget.onExit,
                        ),
                      ],
                    );
                  },
                ),

                // Game Over Screen Overlay
                AnimatedBuilder(
                  animation: engine,
                  builder: (context, _) {
                    if (engine.status != GameStatus.gameOver) return const SizedBox.shrink();
                    return _buildOverlay(
                      title: "GAME OVER",
                      titleColor: ArcadeColors.dangerRed,
                      children: [
                        Text(
                          "SCORE: ${engine.score}",
                          style: AppTheme.pixel(fontSize: 14, color: ArcadeColors.scoreYellow),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "HIGH SCORE: ${engine.highScore}",
                          style: AppTheme.pixel(fontSize: 10, color: ArcadeColors.textDim),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "WAVE REACHED: ${engine.wave}",
                          style: AppTheme.pixel(fontSize: 10, color: ArcadeColors.neonCyan),
                        ),
                        const SizedBox(height: 24),
                        _buildActionButton(
                          label: LocaleController.instance.restart,
                          color: ArcadeColors.neonCyan,
                          onTap: engine.startGame,
                        ),
                        const SizedBox(height: 12),
                        _buildActionButton(
                          label: LocaleController.instance.backToProfile,
                          color: ArcadeColors.terminalGreen,
                          onTap: widget.onExit,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopHud() {
    return AnimatedBuilder(
      animation: engine,
      builder: (context, _) {
        return Row(
          children: [
            // Lives Hearts
            Row(
              children: List.generate(playerMaxLives(), (index) {
                final isFull = index < engine.player.hp;
                return Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    isFull ? Icons.favorite : Icons.favorite_border,
                    color: isFull ? ArcadeColors.dangerRed : Colors.grey,
                    size: 18,
                  ),
                );
              }),
            ),
            const SizedBox(width: 14),

            // Score & Wave
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "SCORE: ${engine.score}",
                  style: AppTheme.pixel(fontSize: 9, color: ArcadeColors.scoreYellow),
                ),
                const SizedBox(height: 3),
                Text(
                  "WAVE ${engine.wave}",
                  style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.neonCyan),
                ),
              ],
            ),

            const Spacer(),

            // Pause Button
            IconButton(
              icon: Icon(
                engine.status == GameStatus.paused ? Icons.play_arrow : Icons.pause,
                color: ArcadeColors.textMain,
                size: 20,
              ),
              onPressed: () {
                if (engine.status == GameStatus.playing) {
                  engine.pauseGame();
                } else if (engine.status == GameStatus.paused) {
                  engine.resumeGame();
                }
              },
            ),

            // Exit Button
            IconButton(
              icon: const Icon(Icons.close, color: ArcadeColors.dangerRed, size: 20),
              onPressed: widget.onExit,
              tooltip: LocaleController.instance.exitGame,
            ),
          ],
        );
      },
    );
  }

  int playerMaxLives() => 3;

  Widget _buildOverlay({
    required String title,
    required Color titleColor,
    required List<Widget> children,
  }) {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.pixelBox(borderColor: titleColor, glow: true),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTheme.pixel(fontSize: 18, color: titleColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: AppTheme.pixelBox(borderColor: color, background: color.withValues(alpha: 0.15)),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTheme.pixel(fontSize: 10, color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class SpaceShooterPainter extends CustomPainter {
  final GameEngine engine;

  SpaceShooterPainter({required this.engine});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Star particles / background
    _drawStarfield(canvas, size);

    // 2. Draw Bullets
    _drawBullets(canvas);

    // 3. Draw PowerUps
    _drawPowerUps(canvas);

    // 4. Draw Enemies
    _drawEnemies(canvas);

    // 5. Draw Particles
    _drawParticles(canvas);

    // 6. Draw Player Ship
    _drawPlayer(canvas);
  }

  void _drawStarfield(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.4);
    // Fixed deterministic stars
    for (int i = 0; i < 35; i++) {
      final x = ((i * 73) % size.width);
      final y = ((i * 127) % size.height);
      canvas.drawCircle(Offset(x, y), (i % 3 == 0) ? 1.5 : 1.0, paint);
    }
  }

  void _drawPlayer(Canvas canvas) {
    final p = engine.player;

    // Invincibility flicker
    if (p.isInvincible && (engine.player.invincibilityTimer * 10).toInt() % 2 == 0) {
      return;
    }

    final center = Offset(p.x, p.y);

    // Shield Aura
    if (p.hasShield) {
      final shieldPaint = Paint()
        ..color = ArcadeColors.neonCyan.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      canvas.drawCircle(center, p.width * 0.85, shieldPaint);
    }

    // Engine flame
    final flamePaint = Paint()..color = ArcadeColors.accentOrange;
    final flamePath = Path()
      ..moveTo(p.x - 6, p.y + p.height / 2)
      ..lineTo(p.x + 6, p.y + p.height / 2)
      ..lineTo(p.x, p.y + p.height / 2 + 12 + (Random().nextDouble() * 6))
      ..close();
    canvas.drawPath(flamePath, flamePaint);

    // Player Hull (Retro Cyan/White Fighter)
    final shipPaint = Paint()..color = ArcadeColors.neonCyan;
    final shipPath = Path()
      ..moveTo(p.x, p.y - p.height / 2) // Nose
      ..lineTo(p.x + p.width / 2, p.y + p.height / 2) // Right wing
      ..lineTo(p.x + p.width / 4, p.y + p.height / 3)
      ..lineTo(p.x, p.y + p.height / 4)
      ..lineTo(p.x - p.width / 4, p.y + p.height / 3)
      ..lineTo(p.x - p.width / 2, p.y + p.height / 2) // Left wing
      ..close();
    canvas.drawPath(shipPath, shipPaint);

    // Cockpit
    final cockpitPaint = Paint()..color = Colors.white;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(p.x, p.y - 2), width: 8, height: 14),
      cockpitPaint,
    );
  }

  void _drawEnemies(Canvas canvas) {
    for (final e in engine.enemies) {
      final center = Offset(e.x, e.y);

      switch (e.type) {
        case EnemyType.bug:
          // Greenish-Red bug
          final bugPaint = Paint()..color = const Color(0xFFEF4444);
          canvas.drawRect(Rect.fromCenter(center: center, width: e.width, height: e.height), bugPaint);
          // Antennae
          canvas.drawLine(Offset(e.x - 8, e.y - 14), Offset(e.x - 12, e.y - 20), Paint()..color = Colors.white..strokeWidth = 2);
          canvas.drawLine(Offset(e.x + 8, e.y - 14), Offset(e.x + 12, e.y - 20), Paint()..color = Colors.white..strokeWidth = 2);
          break;

        case EnemyType.glitch:
          // Diamond Tactical Orange Glitch
          final glitchPaint = Paint()..color = ArcadeColors.accentOrange;
          final path = Path()
            ..moveTo(e.x, e.y - e.height / 2)
            ..lineTo(e.x + e.width / 2, e.y)
            ..lineTo(e.x, e.y + e.height / 2)
            ..lineTo(e.x - e.width / 2, e.y)
            ..close();
          canvas.drawPath(path, glitchPaint);
          break;

        case EnemyType.crash:
          // Dart Rammer Red
          final crashPaint = Paint()..color = const Color(0xFFF43F5E);
          final path = Path()
            ..moveTo(e.x, e.y + e.height / 2)
            ..lineTo(e.x + e.width / 2, e.y - e.height / 2)
            ..lineTo(e.x - e.width / 2, e.y - e.height / 2)
            ..close();
          canvas.drawPath(path, crashPaint);
          break;

        case EnemyType.tank:
          // Heavy Gunmetal Armor Tank
          final tankPaint = Paint()..color = const Color(0xFF475569);
          canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: e.width, height: e.height), const Radius.circular(4)), tankPaint);
          // Turrets
          canvas.drawRect(Rect.fromCenter(center: Offset(e.x - 12, e.y + 16), width: 4, height: 10), Paint()..color = ArcadeColors.dangerRed);
          canvas.drawRect(Rect.fromCenter(center: Offset(e.x + 12, e.y + 16), width: 4, height: 10), Paint()..color = ArcadeColors.dangerRed);
          break;

        case EnemyType.boss:
          // Boss "Deadline" with HP bar
          final bossPaint = Paint()..color = const Color(0xFFDC2626);
          canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: e.width, height: e.height), const Radius.circular(8)), bossPaint);

          // Boss Core
          final corePaint = Paint()..color = ArcadeColors.scoreYellow;
          canvas.drawCircle(center, 14, corePaint);

          // Boss HP Bar above head
          final barWidth = e.width * 1.2;
          final hpPercent = (e.hp / e.maxHp).clamp(0.0, 1.0);
          canvas.drawRect(Rect.fromLTWH(e.x - barWidth / 2, e.y - e.height / 2 - 14, barWidth, 6), Paint()..color = const Color(0xCC000000));
          canvas.drawRect(Rect.fromLTWH(e.x - barWidth / 2, e.y - e.height / 2 - 14, barWidth * hpPercent, 6), Paint()..color = ArcadeColors.dangerRed);
          break;
      }
    }
  }

  void _drawBullets(Canvas canvas) {
    for (final b in engine.bullets) {
      final paint = Paint()..color = b.color;
      canvas.drawCircle(Offset(b.x, b.y), b.radius, paint);
    }
  }

  void _drawPowerUps(Canvas canvas) {
    for (final p in engine.powerUps) {
      Color color = ArcadeColors.scoreYellow;
      String symbol = "P";
      if (p.type == PowerUpType.flutterBoost) {
        color = ArcadeColors.neonCyan;
        symbol = "F";
      } else if (p.type == PowerUpType.cleanCodeShield) {
        color = ArcadeColors.matrixGreen;
        symbol = "S";
      } else if (p.type == PowerUpType.hotReload) {
        color = ArcadeColors.successGreen;
        symbol = "+";
      } else if (p.type == PowerUpType.multiThread) {
        color = ArcadeColors.accentOrange;
        symbol = "3";
      }

      final paint = Paint()..color = color;
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);

      // Simple character on powerup
      final textPainter = TextPainter(
        text: TextSpan(
          text: symbol,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(p.x - textPainter.width / 2, p.y - textPainter.height / 2));
    }
  }

  void _drawParticles(Canvas canvas) {
    for (final part in engine.particles) {
      final alpha = (part.life / part.maxLife).clamp(0.0, 1.0);
      final paint = Paint()..color = part.color.withValues(alpha: alpha);
      canvas.drawCircle(Offset(part.x, part.y), part.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
