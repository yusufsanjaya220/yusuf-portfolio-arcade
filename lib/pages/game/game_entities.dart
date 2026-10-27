import 'dart:math';
import 'package:flutter/material.dart';
import '../../app/app_theme.dart';

enum EnemyType { bug, glitch, crash, tank, boss }
enum PowerUpType { flutterBoost, cleanCodeShield, hotReload, multiThread }

class PlayerShip {
  double x;
  double y;
  double width = 36;
  double height = 40;
  int hp = 3;
  int maxHp = 3;
  bool isInvincible = false;
  double invincibilityTimer = 0.0;
  bool hasShield = false;
  double rapidFireTimer = 0.0;
  double multiShotTimer = 0.0;
  double fireCooldown = 0.0;

  PlayerShip({required this.x, required this.y});

  void takeDamage() {
    if (isInvincible) return;
    if (hasShield) {
      hasShield = false;
      isInvincible = true;
      invincibilityTimer = 1.0;
      return;
    }
    hp = max(0, hp - 1);
    isInvincible = true;
    invincibilityTimer = 1.8;
  }

  void heal() {
    hp = min(maxHp, hp + 1);
  }

  void update(double dt) {
    if (isInvincible) {
      invincibilityTimer -= dt;
      if (invincibilityTimer <= 0) {
        isInvincible = false;
      }
    }
    if (rapidFireTimer > 0) rapidFireTimer -= dt;
    if (multiShotTimer > 0) multiShotTimer -= dt;
    if (fireCooldown > 0) fireCooldown -= dt;
  }
}

class Bullet {
  double x;
  double y;
  double vx;
  double vy;
  double radius = 4;
  bool isPlayerBullet;
  Color color;

  Bullet({
    required this.x,
    required this.y,
    this.vx = 0,
    required this.vy,
    this.isPlayerBullet = true,
    this.color = ArcadeColors.neonCyan,
  });

  void update(double dt) {
    x += vx * dt;
    y += vy * dt;
  }
}

class Enemy {
  double x;
  double y;
  double width;
  double height;
  EnemyType type;
  int hp;
  int maxHp;
  double speed;
  double shootTimer = 0.0;
  double initialX;
  double timeAlive = 0.0;

  Enemy({
    required this.x,
    required this.y,
    required this.type,
    required this.hp,
    required this.speed,
    this.width = 30,
    this.height = 30,
  })  : maxHp = hp,
        initialX = x;

  factory Enemy.create({
    required EnemyType type,
    required double startX,
    required double startY,
    required int wave,
  }) {
    switch (type) {
      case EnemyType.bug:
        return Enemy(
          x: startX,
          y: startY,
          type: type,
          hp: 1,
          speed: 110 + (wave * 6.0),
          width: 28,
          height: 28,
        );
      case EnemyType.glitch:
        return Enemy(
          x: startX,
          y: startY,
          type: type,
          hp: 1,
          speed: 130 + (wave * 7.0),
          width: 30,
          height: 30,
        );
      case EnemyType.crash:
        return Enemy(
          x: startX,
          y: startY,
          type: type,
          hp: 2,
          speed: 175 + (wave * 8.0),
          width: 32,
          height: 32,
        );
      case EnemyType.tank:
        return Enemy(
          x: startX,
          y: startY,
          type: type,
          hp: 5,
          speed: 65 + (wave * 4.0),
          width: 44,
          height: 44,
        );
      case EnemyType.boss:
        return Enemy(
          x: startX,
          y: startY,
          type: type,
          hp: 35 + (wave * 5),
          speed: 55,
          width: 76,
          height: 70,
        );
    }
  }

  void update(double dt, double playerX) {
    timeAlive += dt;
    shootTimer += dt;

    switch (type) {
      case EnemyType.bug:
        y += speed * dt;
        break;
      case EnemyType.glitch:
        y += speed * dt;
        x = initialX + sin(timeAlive * 6.0) * 45;
        break;
      case EnemyType.crash:
        y += speed * dt;
        // homing gently towards player
        if (x < playerX) {
          x += 60 * dt;
        } else {
          x -= 60 * dt;
        }
        break;
      case EnemyType.tank:
        y += speed * dt;
        break;
      case EnemyType.boss:
        if (y < 90) {
          y += 50 * dt;
        } else {
          x = initialX + sin(timeAlive * 2.0) * 120;
        }
        break;
    }
  }
}

class PowerUp {
  double x;
  double y;
  PowerUpType type;
  double radius = 14;
  double speed = 80;

  PowerUp({required this.x, required this.y, required this.type});

  void update(double dt) {
    y += speed * dt;
  }
}

class ExplosionParticle {
  double x;
  double y;
  double vx;
  double vy;
  double life = 1.0;
  double maxLife;
  Color color;
  double size;

  ExplosionParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    this.maxLife = 0.5,
    this.size = 3.5,
  }) : life = maxLife;

  void update(double dt) {
    x += vx * dt;
    y += vy * dt;
    life -= dt;
  }
}
