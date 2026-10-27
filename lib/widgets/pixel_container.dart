import 'package:flutter/material.dart';
import '../app/app_theme.dart';

class PixelContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool glow;
  final String? badgeTitle;
  final Color badgeColor;

  const PixelContainer({
    super.key,
    required this.child,
    this.borderColor = ArcadeColors.neonCyan,
    this.backgroundColor = ArcadeColors.backgroundCard,
    this.padding = const EdgeInsets.all(16),
    this.glow = false,
    this.badgeTitle,
    this.badgeColor = ArcadeColors.terminalGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: padding,
          decoration: AppTheme.pixelBox(
            background: backgroundColor,
            borderColor: borderColor,
            borderWidth: 2,
            radius: 6,
            glow: glow,
          ),
          child: child,
        ),
        if (badgeTitle != null)
          Positioned(
            top: -10,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Text(
                badgeTitle!,
                style: AppTheme.pixel(
                  fontSize: 7.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
