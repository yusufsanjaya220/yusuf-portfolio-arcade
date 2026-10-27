import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/app_theme.dart';
import '../../app/audio_controller.dart';
import '../../app/localization.dart';
import '../../data/models.dart';
import '../../data/profile_data.dart';
import '../../widgets/pixel_container.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

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
              _buildSectionHeader(
                title: locale.navCertifications,
                subtitle: locale.isId
                    ? "Lencana Kredensial Resmi & Pencapaian Terverifikasi"
                    : "Official Badges & Verified Technical Achievements",
              ),
              const SizedBox(height: 32),

              // Certifications Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 720;
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: ProfileData.certifications.map((cert) {
                      final itemWidth = isWide ? (constraints.maxWidth - 20) / 2 : constraints.maxWidth;
                      return SizedBox(
                        width: itemWidth,
                        child: _buildCertCard(context, cert),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 40),

              // In-Game Unlocked Achievements (PRD 7.6)
              PixelContainer(
                padding: const EdgeInsets.all(20),
                borderColor: ArcadeColors.scoreYellow,
                badgeTitle: "MINI-GAME TROPHIES",
                badgeColor: ArcadeColors.scoreYellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.military_tech, color: ArcadeColors.scoreYellow, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            locale.isId
                                ? "TROFI IN-GAME (MAINKAN SPACE SHOOTER UNTUK MEMBUKA FAKTA!):"
                                : "IN-GAME TROPHIES (PLAY SPACE SHOOTER TO UNLOCK FACTS!):",
                            style: AppTheme.pixel(
                              fontSize: 9.5,
                              color: ArcadeColors.scoreYellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ProfileData.generateAchievements().map((ach) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF141C36),
                            border: Border.all(color: ArcadeColors.borderPixel, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.lock_open, color: ArcadeColors.neonCyan, size: 16),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ach.title,
                                    style: AppTheme.pixel(fontSize: 8, color: Colors.white),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    locale.isId ? ach.descriptionId : ach.descriptionEn,
                                    style: AppTheme.body(fontSize: 10.5, color: ArcadeColors.textDim),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertCard(BuildContext context, CertificationItem cert) {
    final locale = LocaleController.instance;

    return PixelContainer(
      padding: const EdgeInsets.all(20),
      borderColor: ArcadeColors.neonCyan,
      glow: true,
      badgeTitle: cert.issuer.toUpperCase(),
      badgeColor: ArcadeColors.terminalGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E284A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.workspace_premium, color: ArcadeColors.scoreYellow, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cert.title,
                      style: AppTheme.body(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${cert.issuer} • ${cert.issueDate}",
                      style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.neonCyan),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Text(
            locale.isId ? cert.descriptionId : cert.descriptionEn,
            style: AppTheme.body(fontSize: 12.5, color: ArcadeColors.textDim),
          ),
          const SizedBox(height: 14),

          // Skill tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: cert.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF141C36),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: ArcadeColors.borderPixel, width: 1),
                ),
                child: Text(
                  tag,
                  style: AppTheme.pixel(fontSize: 7, color: ArcadeColors.textMain),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),

          // Action: Verifikasi Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ArcadeColors.neonCyan, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              icon: const Icon(Icons.open_in_new, color: ArcadeColors.neonCyan, size: 16),
              label: Text(
                locale.verifyCredential,
                style: AppTheme.pixel(fontSize: 8.5, color: ArcadeColors.neonCyan),
              ),
              onPressed: () async {
                AudioController.instance.click();
                final uri = Uri.parse(cert.credentialUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
          ),
        ],
      ),
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
