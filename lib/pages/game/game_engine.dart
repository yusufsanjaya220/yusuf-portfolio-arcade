import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/app_theme.dart';
import '../../app/audio_controller.dart';
import '../../data/models.dart';
import '../../data/profile_data.dart';
import 'game_entities.dart';

enum GameStatus { ready, playing, paused, gameOver, waveCompleted }

class GameEngine extends ChangeNotifier {
  double worldWidth = 600;
  double worldHeight = 800;

  late PlayerShip player;
  List<Bullet> bullets = [];
  List<Enemy> enemies = [];
  List<PowerUp> powerUps = [];
  List<ExplosionParticle> particles = [];
  List<InGameAchievement> achievements = [];

  GameStatus status = GameStatus.ready;
  int score = 0;
  int highScore = 0;
  int wave = 1;
  int combo = 0;
  double comboMultiplier = 1.0;

  double waveAnnouncementTimer = 0.0;
  String waveAnnouncement = "WAVE 1";

  // Spawning logic
  int enemiesLeftInWave = 0;
  double spawnCooldown = 0.0;
  bool bossSpawned = false;

  // Unlocked notification banner
  InGameAchievement? recentAchievement;
  double achievementBannerTimer = 0.0;

  final Random _rng = Random();

  GameEngine() {
    player = PlayerShip(x: worldWidth / 2, y: worldHeight - 65);
    achievements = ProfileData.generateAchievements();
    _loadHighScore();
  }

  void updateWorldSize(double width, double height) {
    worldWidth = width;
    worldHeight = height;
    player.y = worldHeight - 65;
    player.x = player.x.clamp(player.width / 2, worldWidth - player.width / 2);
  }

  Future<void> _loadHighScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      highScore = prefs.getInt('retro_space_highscore') ?? 0;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> _saveHighScore() async {
    if (score > highScore) {
      highScore = score;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('retro_space_highscore', highScore);
      } catch (_) {}
    }
  }

  void startGame() {
    score = 0;
    wave = 1;
    combo = 0;
    comboMultiplier = 1.0;
    bullets.clear();
    enemies.clear();
    powerUps.clear();
    particles.clear();
    player = PlayerShip(x: worldWidth / 2, y: worldHeight - 65);
    _startWave(1);
    status = GameStatus.playing;
    AudioController.instance.click();
    notifyListeners();
  }

  void _startWave(int w) {
    wave = w;
    waveAnnouncement = "WAVE $wave";
    waveAnnouncementTimer = 2.2;
    bossSpawned = false;

    if (wave % 5 == 0) {
      // Boss wave
      enemiesLeftInWave = 1;
    } else {
      enemiesLeftInWave = 8 + (wave * 4);
    }
  }

  void pauseGame() {
    if (status == GameStatus.playing) {
      status = GameStatus.paused;
      notifyListeners();
    }
  }

  void resumeGame() {
    if (status == GameStatus.paused) {
      status = GameStatus.playing;
      notifyListeners();
    }
  }

  void movePlayer(double targetX) {
    if (status != GameStatus.playing) return;
    player.x = targetX.clamp(player.width / 2, worldWidth - player.width / 2);
  }

  void movePlayerRelative(double dx) {
    if (status != GameStatus.playing) return;
    movePlayer(player.x + dx);
  }

  void triggerPlayerShoot() {
    if (status != GameStatus.playing) return;
    if (player.fireCooldown > 0) return;

    final isRapid = player.rapidFireTimer > 0;
    player.fireCooldown = isRapid ? 0.12 : 0.24;

    if (player.multiShotTimer > 0) {
      // 3-way shot
      bullets.add(Bullet(x: player.x, y: player.y - 18, vy: -550));
      bullets.add(Bullet(x: player.x - 12, y: player.y - 12, vx: -120, vy: -500));
      bullets.add(Bullet(x: player.x + 12, y: player.y - 12, vx: 120, vy: -500));
    } else {
      bullets.add(Bullet(x: player.x, y: player.y - 20, vy: -550));
    }

    AudioController.instance.laser();
  }

  void tick(double dt) {
    if (status != GameStatus.playing) return;

    // Auto shoot continuously if playing
    triggerPlayerShoot();

    player.update(dt);

    if (achievementBannerTimer > 0) {
      achievementBannerTimer -= dt;
      if (achievementBannerTimer <= 0) {
        recentAchievement = null;
      }
    }

    if (waveAnnouncementTimer > 0) {
      waveAnnouncementTimer -= dt;
    }

    // Spawn enemies
    _updateSpawns(dt);

    // Update bullets
    for (int i = bullets.length - 1; i >= 0; i--) {
      final b = bullets[i];
      b.update(dt);
      if (b.y < -30 || b.y > worldHeight + 30 || b.x < -30 || b.x > worldWidth + 30) {
        bullets.removeAt(i);
      }
    }

    // Update enemies
    for (int i = enemies.length - 1; i >= 0; i--) {
      final e = enemies[i];
      e.update(dt, player.x);

      // Tank and boss shooting
      if (e.type == EnemyType.tank && e.shootTimer > 2.2) {
        e.shootTimer = 0;
        bullets.add(Bullet(
          x: e.x,
          y: e.y + e.height / 2,
          vy: 240,
          isPlayerBullet: false,
          color: ArcadeColors.dangerRed,
        ));
      } else if (e.type == EnemyType.boss && e.shootTimer > 1.3) {
        e.shootTimer = 0;
        // Boss 3-way burst
        bullets.add(Bullet(x: e.x, y: e.y + e.height / 2, vy: 260, isPlayerBullet: false, color: ArcadeColors.dangerRed));
        bullets.add(Bullet(x: e.x - 15, y: e.y + e.height / 2, vx: -90, vy: 240, isPlayerBullet: false, color: ArcadeColors.accentOrange));
        bullets.add(Bullet(x: e.x + 15, y: e.y + e.height / 2, vx: 90, vy: 240, isPlayerBullet: false, color: ArcadeColors.accentOrange));
      }

      // Check collision with player
      final distToPlayer = (Offset(e.x, e.y) - Offset(player.x, player.y)).distance;
      if (distToPlayer < (e.width / 2 + player.width / 2)) {
        _createExplosion(e.x, e.y, ArcadeColors.dangerRed, 20);
        enemies.removeAt(i);
        _playerHit();
        continue;
      }

      // Remove enemies escaping bottom
      if (e.y > worldHeight + 50) {
        enemies.removeAt(i);
        combo = 0;
        comboMultiplier = 1.0;
      }
    }

    // Update PowerUps
    for (int i = powerUps.length - 1; i >= 0; i--) {
      final p = powerUps[i];
      p.update(dt);

      final dist = (Offset(p.x, p.y) - Offset(player.x, player.y)).distance;
      if (dist < (p.radius + player.width / 2)) {
        _collectPowerUp(p);
        powerUps.removeAt(i);
        continue;
      }

      if (p.y > worldHeight + 40) {
        powerUps.removeAt(i);
      }
    }

    // Bullet collisions
    _checkBulletCollisions();

    // Update Particles
    for (int i = particles.length - 1; i >= 0; i--) {
      final part = particles[i];
      part.update(dt);
      if (part.life <= 0) {
        particles.removeAt(i);
      }
    }

    // Check wave clear
    if (enemiesLeftInWave <= 0 && enemies.isEmpty && status == GameStatus.playing) {
      _startWave(wave + 1);
    }

    // Check achievements
    _checkAchievements();

    notifyListeners();
  }

  void _updateSpawns(double dt) {
    if (waveAnnouncementTimer > 0) return;

    spawnCooldown -= dt;
    if (spawnCooldown > 0) return;

    if (wave % 5 == 0) {
      if (!bossSpawned) {
        enemies.add(Enemy.create(type: EnemyType.boss, startX: worldWidth / 2, startY: -60, wave: wave));
        bossSpawned = true;
        enemiesLeftInWave = 0;
      }
      return;
    }

    if (enemiesLeftInWave > 0) {
      spawnCooldown = max(0.5, 1.6 - (wave * 0.1));
      enemiesLeftInWave--;

      final startX = 35 + _rng.nextDouble() * (worldWidth - 70);
      EnemyType type = EnemyType.bug;

      final roll = _rng.nextDouble();
      if (wave >= 4 && roll < 0.20) {
        type = EnemyType.tank;
      } else if (wave >= 3 && roll < 0.45) {
        type = EnemyType.crash;
      } else if (wave >= 2 && roll < 0.70) {
        type = EnemyType.glitch;
      }

      enemies.add(Enemy.create(type: type, startX: startX, startY: -35, wave: wave));
    }
  }

  void _checkBulletCollisions() {
    for (int bi = bullets.length - 1; bi >= 0; bi--) {
      final b = bullets[bi];

      if (b.isPlayerBullet) {
        // Player bullet hits enemy
        for (int ei = enemies.length - 1; ei >= 0; ei--) {
          final e = enemies[ei];
          final rect = Rect.fromCenter(center: Offset(e.x, e.y), width: e.width, height: e.height);
          if (rect.contains(Offset(b.x, b.y))) {
            bullets.removeAt(bi);
            e.hp--;
            _createExplosion(b.x, b.y, ArcadeColors.neonCyan, 4);

            if (e.hp <= 0) {
              _enemyDestroyed(e);
              enemies.removeAt(ei);
            }
            break;
          }
        }
      } else {
        // Enemy bullet hits player
        final rect = Rect.fromCenter(center: Offset(player.x, player.y), width: player.width, height: player.height);
        if (rect.contains(Offset(b.x, b.y))) {
          bullets.removeAt(bi);
          _playerHit();
        }
      }
    }
  }

  void _enemyDestroyed(Enemy e) {
    AudioController.instance.explosion();
    _createExplosion(e.x, e.y, e.type == EnemyType.boss ? ArcadeColors.scoreYellow : ArcadeColors.dangerRed, e.type == EnemyType.boss ? 40 : 14);

    combo++;
    comboMultiplier = min(3.0, 1.0 + (combo ~/ 5) * 0.25);

    int basePoints = 50;
    switch (e.type) {
      case EnemyType.bug: basePoints = 50; break;
      case EnemyType.glitch: basePoints = 75; break;
      case EnemyType.crash: basePoints = 100; break;
      case EnemyType.tank: basePoints = 250; break;
      case EnemyType.boss: basePoints = 1000; break;
    }

    score += (basePoints * comboMultiplier).toInt();
    _saveHighScore();

    // Power-up drop chance (25%)
    if (_rng.nextDouble() < 0.25) {
      final pTypes = PowerUpType.values;
      final selected = pTypes[_rng.nextInt(pTypes.length)];
      powerUps.add(PowerUp(x: e.x, y: e.y, type: selected));
    }
  }

  void _collectPowerUp(PowerUp p) {
    AudioController.instance.powerup();
    _createExplosion(p.x, p.y, ArcadeColors.scoreYellow, 10);

    switch (p.type) {
      case PowerUpType.flutterBoost:
        player.rapidFireTimer = 10.0;
        break;
      case PowerUpType.cleanCodeShield:
        player.hasShield = true;
        break;
      case PowerUpType.hotReload:
        player.heal();
        break;
      case PowerUpType.multiThread:
        player.multiShotTimer = 10.0;
        break;
    }
  }

  void _playerHit() {
    if (player.isInvincible) return;
    AudioController.instance.explosion();
    combo = 0;
    comboMultiplier = 1.0;
    player.takeDamage();

    if (player.hp <= 0) {
      status = GameStatus.gameOver;
      _saveHighScore();
      AudioController.instance.gameover();
    }
  }

  void _createExplosion(double x, double y, Color color, int count) {
    for (int i = 0; i < count; i++) {
      final angle = _rng.nextDouble() * 2 * pi;
      final speed = 60 + _rng.nextDouble() * 180;
      particles.add(ExplosionParticle(
        x: x,
        y: y,
        vx: cos(angle) * speed,
        vy: sin(angle) * speed,
        color: color,
        maxLife: 0.3 + _rng.nextDouble() * 0.4,
        size: 2.5 + _rng.nextDouble() * 3.0,
      ));
    }
  }

  void _checkAchievements() {
    for (final ach in achievements) {
      if (!ach.isUnlocked) {
        bool met = false;
        if (ach.triggerScore > 0 && score >= ach.triggerScore) met = true;
        if (ach.triggerWave > 0 && wave >= ach.triggerWave) met = true;

        if (met) {
          ach.isUnlocked = true;
          recentAchievement = ach;
          achievementBannerTimer = 4.0;
          AudioController.instance.powerup();
        }
      }
    }
  }
}
