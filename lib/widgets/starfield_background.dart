import 'dart:math';
import 'package:flutter/material.dart';

class StarfieldBackground extends StatefulWidget {
  final Widget child;

  const StarfieldBackground({super.key, required this.child});

  @override
  State<StarfieldBackground> createState() => _StarfieldBackgroundState();
}

class _StarfieldBackgroundState extends State<StarfieldBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Star> _stars = [];
  final Random _rng = Random(42);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 70; i++) {
      _stars.add(_Star(
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        speed: 0.02 + _rng.nextDouble() * 0.05,
        size: 1.0 + _rng.nextDouble() * 1.8,
        brightness: 0.2 + _rng.nextDouble() * 0.6,
      ));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              size: Size.infinite,
              painter: _StarfieldPainter(stars: _stars, progress: _controller.value),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _Star {
  double x;
  double y;
  double speed;
  double size;
  double brightness;

  _Star({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.brightness,
  });
}

class _StarfieldPainter extends CustomPainter {
  final List<_Star> stars;
  final double progress;

  _StarfieldPainter({required this.stars, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in stars) {
      final currentY = (s.y + progress * s.speed * 2) % 1.0;
      final px = s.x * size.width;
      final py = currentY * size.height;

      final paint = Paint()
        ..color = Colors.white.withValues(alpha: s.brightness)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(px, py), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter oldDelegate) => true;
}
