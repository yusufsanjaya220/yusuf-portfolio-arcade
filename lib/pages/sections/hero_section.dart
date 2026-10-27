import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/audio_controller.dart';
import '../../app/localization.dart';
import '../../data/profile_data.dart';
import '../../widgets/pixel_container.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onStartGame;
  final VoidCallback onViewProfile;

  const HeroSection({
    super.key,
    required this.onStartGame,
    required this.onViewProfile,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final locale = LocaleController.instance;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 60 : 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mission / System Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: ArcadeColors.terminalGreen.withValues(alpha: 0.12),
              border: Border.all(color: ArcadeColors.terminalGreen, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ArcadeColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  locale.openForOpportunities,
                  style: AppTheme.pixel(
                    fontSize: 8,
                    color: ArcadeColors.textMain,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Main Hero Title (Name)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              ProfileData.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTheme.pixel(
                fontSize: isDesktop ? 36 : 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Tagline
          Text(
            ProfileData.tagline,
            textAlign: TextAlign.center,
            style: AppTheme.pixel(
              fontSize: isDesktop ? 13 : 10,
              color: ArcadeColors.neonCyan,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle Headline
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: AnimatedBuilder(
              animation: locale,
              builder: (context, _) {
                return Text(
                  locale.isId ? ProfileData.headlineId : ProfileData.headlineEn,
                  textAlign: TextAlign.center,
                  style: AppTheme.body(
                    fontSize: isDesktop ? 16 : 14,
                    color: ArcadeColors.textDim,
                    height: 1.6,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 36),

          // Action Buttons: PRESS START & LIHAT PROFIL
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 14,
            children: [
              // Pulsing "PRESS START" button
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, _) {
                  final glowOpacity = 0.3 + (_pulseController.value * 0.4);
                  return InkWell(
                    onTap: () {
                      AudioController.instance.click();
                      widget.onStartGame();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ArcadeColors.cyberAmber, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: ArcadeColors.cyberAmber.withValues(alpha: glowOpacity),
                            blurRadius: 18,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow, color: ArcadeColors.cyberAmber, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            locale.pressStart,
                            style: AppTheme.pixel(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // "LIHAT PROFIL" Secondary Button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ArcadeColors.neonCyan, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  backgroundColor: ArcadeColors.neonCyan.withValues(alpha: 0.08),
                ),
                icon: const Icon(Icons.person_pin, color: ArcadeColors.neonCyan, size: 20),
                label: Text(
                  locale.viewProfile,
                  style: AppTheme.pixel(
                    fontSize: 11,
                    color: ArcadeColors.neonCyan,
                    letterSpacing: 1.2,
                  ),
                ),
                onPressed: () {
                  AudioController.instance.click();
                  widget.onViewProfile();
                },
              ),
            ],
          ),
          const SizedBox(height: 50),

          // 3 Quick Highlight Bento Cards (Section 6.2 PRD)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 720;
                return Flex(
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ProfileData.quickHighlights.map((hl) {
                    final itemWidget = PixelContainer(
                      padding: const EdgeInsets.all(16),
                      badgeTitle: hl.badgeText,
                      badgeColor: hl.badgeText == "ACTIVE"
                          ? ArcadeColors.successGreen
                          : ArcadeColors.neonCyan,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ArcadeColors.borderPixel,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(hl.icon, color: ArcadeColors.neonCyan, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locale.isId ? hl.titleId : hl.titleEn,
                                  style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.textDim),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  locale.isId ? hl.valueId : hl.valueEn,
                                  style: AppTheme.body(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                    return isWide
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: itemWidget,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: itemWidget,
                          );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
