import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/audio_controller.dart';
import '../../app/localization.dart';
import '../../data/profile_data.dart';
import '../../widgets/pixel_container.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final locale = LocaleController.instance;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              _buildSectionHeader(
                title: locale.navAbout,
                subtitle: locale.isId
                    ? "Statistik Karakter & Fondasi Kompetensi"
                    : "Character Stats & Core Competencies",
              ),
              const SizedBox(height: 32),

              // Layout: Character Card on Left, Bio on Right (Desktop)
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Retro Character Card
                  SizedBox(
                    width: isDesktop ? 340 : double.infinity,
                    child: _buildCharacterCard(context),
                  ),
                  SizedBox(width: isDesktop ? 28 : 0, height: isDesktop ? 0 : 28),

                  // Right: Bio & Education
                  Expanded(
                    flex: isDesktop ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PixelContainer(
                          padding: const EdgeInsets.all(22),
                          borderColor: ArcadeColors.borderPixel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.isId ? "TENTANG SAYA" : "ABOUT ME",
                                style: AppTheme.pixel(
                                  fontSize: 11,
                                  color: ArcadeColors.neonCyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedBuilder(
                                animation: locale,
                                builder: (context, _) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        locale.isId
                                            ? ProfileData.aboutParagraph1Id
                                            : ProfileData.aboutParagraph1En,
                                        style: AppTheme.body(fontSize: 14),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        locale.isId
                                            ? ProfileData.aboutParagraph2Id
                                            : ProfileData.aboutParagraph2En,
                                        style: AppTheme.body(fontSize: 14),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        locale.isId
                                            ? ProfileData.aboutParagraph3Id
                                            : ProfileData.aboutParagraph3En,
                                        style: AppTheme.body(fontSize: 14),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 20),

                              // Download CV Button
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ArcadeColors.neonCyan.withValues(alpha: 0.15),
                                  foregroundColor: ArcadeColors.neonCyan,
                                  side: const BorderSide(color: ArcadeColors.neonCyan, width: 1.5),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                                icon: const Icon(Icons.download, size: 18),
                                label: Text(
                                  locale.downloadCv,
                                  style: AppTheme.pixel(fontSize: 9, color: ArcadeColors.neonCyan),
                                ),
                                onPressed: () {
                                  AudioController.instance.click();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: ArcadeColors.backgroundCardElevated,
                                      content: Text(
                                        locale.isId
                                            ? "CV PDF akan segera diunduh (Data resmi Yusuf Sanjaya)"
                                            : "CV PDF download initiated",
                                        style: AppTheme.pixel(fontSize: 9, color: ArcadeColors.scoreYellow),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Education History Cards (Section 8.4 PRD)
                        Text(
                          locale.isId ? "RIWAYAT PENDIDIKAN" : "EDUCATION HISTORY",
                          style: AppTheme.pixel(fontSize: 10, color: ArcadeColors.scoreYellow),
                        ),
                        const SizedBox(height: 14),
                        ...ProfileData.educations.map((edu) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PixelContainer(
                              padding: const EdgeInsets.all(16),
                              borderColor: ArcadeColors.borderPixel,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          edu.institution,
                                          style: AppTheme.body(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        edu.period,
                                        style: AppTheme.pixel(
                                          fontSize: 7.5,
                                          color: ArcadeColors.scoreYellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    locale.isId ? edu.majorId : edu.majorEn,
                                    style: AppTheme.body(
                                      fontSize: 13,
                                      color: ArcadeColors.neonCyan,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    locale.isId ? edu.detailsId : edu.detailsEn,
                                    style: AppTheme.body(fontSize: 12, color: ArcadeColors.textDim),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterCard(BuildContext context) {
    final locale = LocaleController.instance;

    return PixelContainer(
      padding: const EdgeInsets.all(20),
      borderColor: ArcadeColors.neonCyan,
      glow: true,
      badgeTitle: "CHARACTER STATS",
      badgeColor: ArcadeColors.terminalGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Pixel Avatar Frame
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: ArcadeColors.backgroundCardElevated,
              border: Border.all(color: ArcadeColors.neonCyan, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pixelated hero avatar representation
                const Icon(
                  Icons.smart_toy,
                  size: 64,
                  color: ArcadeColors.neonCyan,
                ),
                Positioned(
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "LVL 5",
                      style: AppTheme.pixel(fontSize: 7, color: ArcadeColors.scoreYellow),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Text(
            ProfileData.name,
            style: AppTheme.pixel(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "CLASS: FULL-STACK / NET-ENG",
            style: AppTheme.pixel(fontSize: 7.5, color: ArcadeColors.neonCyan),
          ),
          const SizedBox(height: 16),

          const Divider(color: ArcadeColors.borderPixel),
          const SizedBox(height: 12),

          // Stat Bars
          _buildStatRow("HP", "100/100", 1.0, ArcadeColors.dangerRed),
          const SizedBox(height: 8),
          _buildStatRow("EXP", "SMT 5 / INFORMATICS", 0.65, ArcadeColors.cyberAmber),
          const SizedBox(height: 8),
          _buildStatRow("LOC", ProfileData.location, 1.0, ArcadeColors.neonCyan, isBar: false),
          const SizedBox(height: 8),
          _buildStatRow("STATUS", "READY TO COLLAB", 1.0, ArcadeColors.successGreen, isBar: false),

          const SizedBox(height: 16),
          const Divider(color: ArcadeColors.borderPixel),
          const SizedBox(height: 12),

          // Open For Tags
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              locale.isId ? "TERBUKA UNTUK ROLE:" : "OPEN FOR ROLES:",
              style: AppTheme.pixel(fontSize: 7.5, color: ArcadeColors.scoreYellow),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ProfileData.openForRoles.map((role) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ArcadeColors.backgroundCardElevated,
                  border: Border.all(color: ArcadeColors.borderPixel, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  role,
                  style: AppTheme.pixel(fontSize: 7, color: ArcadeColors.textMain),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, double progress, Color color, {bool isBar = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTheme.pixel(fontSize: 7.5, color: color)),
            Flexible(
              child: Text(
                value,
                style: AppTheme.pixel(fontSize: 7, color: ArcadeColors.textDim),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (isBar) ...[
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFF0F1528),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionHeader({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 22, color: ArcadeColors.neonCyan),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTheme.pixel(
                fontSize: 16,
                color: ArcadeColors.neonCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: AppTheme.body(fontSize: 13, color: ArcadeColors.textDim)),
      ],
    );
  }
}
