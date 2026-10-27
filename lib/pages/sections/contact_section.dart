import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/app_theme.dart';
import '../../app/audio_controller.dart';
import '../../app/localization.dart';
import '../../data/profile_data.dart';
import '../../widgets/pixel_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final locale = LocaleController.instance;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: 50,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Retro Arcade Continue Title
              PixelContainer(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
                borderColor: ArcadeColors.scoreYellow,
                glow: true,
                badgeTitle: "STAGE COMPLETE",
                badgeColor: ArcadeColors.scoreYellow,
                child: Column(
                  children: [
                    Text(
                      "CONTINUE? 9...",
                      style: AppTheme.pixel(
                        fontSize: isDesktop ? 22 : 16,
                        color: ArcadeColors.scoreYellow,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      locale.isId
                          ? "Siap Berkolaborasi? Mari Bangun Solusi Web & Infrastruktur Bersama!"
                          : "Ready to Collaborate? Let's Build Robust Software & Network Solutions!",
                      textAlign: TextAlign.center,
                      style: AppTheme.body(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      locale.isId
                          ? "Terbuka untuk kesempatan Full-Time, Internship, maupun Project Freelance."
                          : "Open for Full-Time engineering roles, internships, and high-impact freelance projects.",
                      textAlign: TextAlign.center,
                      style: AppTheme.body(fontSize: 13, color: ArcadeColors.textDim),
                    ),
                    const SizedBox(height: 28),

                    // Copy Email Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B34),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: ArcadeColors.neonCyan, width: 1.5),
                      ),
                      child: Flex(
                        direction: isDesktop ? Axis.horizontal : Axis.vertical,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectableText(
                            ProfileData.email,
                            style: AppTheme.pixel(
                              fontSize: isDesktop ? 10 : 8.5,
                              color: ArcadeColors.neonCyan,
                            ),
                          ),
                          SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 12),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ArcadeColors.neonCyan,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            icon: const Icon(Icons.copy, size: 16),
                            label: Text(
                              locale.copyEmail,
                              style: AppTheme.pixel(fontSize: 8.5, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              AudioController.instance.click();
                              Clipboard.setData(const ClipboardData(text: ProfileData.email));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: ArcadeColors.backgroundCardElevated,
                                  content: Text(
                                    locale.emailCopied,
                                    style: AppTheme.pixel(fontSize: 9, color: ArcadeColors.successGreen),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Social Links Row
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildSocialButton(
                          label: "LINKEDIN",
                          icon: Icons.link,
                          color: const Color(0xFF0A66C2),
                          url: ProfileData.linkedInUrl,
                        ),
                        _buildSocialButton(
                          label: "GITHUB",
                          icon: Icons.code,
                          color: const Color(0xFF6E5494),
                          url: ProfileData.githubUrl,
                        ),
                        _buildSocialButton(
                          label: "WHATSAPP",
                          icon: Icons.chat,
                          color: const Color(0xFF25D366),
                          url: ProfileData.whatsappUrl,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Footer PRD 6.8
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("© 2026 Yusuf Sanjaya • ", style: TextStyle(color: ArcadeColors.textDim, fontSize: 12)),
                  Text(
                    "DIBUAT DENGAN FLUTTER",
                    style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.neonCyan),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Tersedia untuk Flutter Web & Android APK",
                style: AppTheme.body(fontSize: 11, color: ArcadeColors.textDim),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return InkWell(
      onTap: () async {
        AudioController.instance.click();
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTheme.pixel(fontSize: 8.5, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
