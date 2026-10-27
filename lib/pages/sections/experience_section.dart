import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/localization.dart';
import '../../data/models.dart';
import '../../data/profile_data.dart';
import '../../widgets/pixel_container.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
                title: locale.navExperience,
                subtitle: locale.isId
                    ? "Daftar Misi & Pengalaman Profesional yang Telah Diselesaikan"
                    : "Completed Professional Quests & Enterprise Roles",
              ),
              const SizedBox(height: 36),

              // Vertical Quests Timeline
              for (final exp in ProfileData.experiences)
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: _buildQuestCard(context, exp, isDesktop),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestCard(BuildContext context, ExperienceItem exp, bool isDesktop) {
    final locale = LocaleController.instance;
    final isOngoing = exp.status == "ON GOING";

    return PixelContainer(
      padding: const EdgeInsets.all(24),
      borderColor: isOngoing ? ArcadeColors.neonCyan : ArcadeColors.borderPixel,
      glow: isOngoing,
      badgeTitle: exp.status,
      badgeColor: isOngoing ? ArcadeColors.successGreen : ArcadeColors.borderPixel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Position & Organization
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.isId ? exp.positionId : exp.positionEn,
                    style: AppTheme.pixel(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.business, color: ArcadeColors.terminalGreen, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        exp.organization,
                        style: AppTheme.body(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ArcadeColors.terminalGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: isDesktop ? 0 : 8),
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: ArcadeColors.scoreYellow, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    locale.isId ? exp.periodId : exp.periodEn,
                    style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.scoreYellow),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.location_on, color: ArcadeColors.dangerRed, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    exp.location,
                    style: AppTheme.body(fontSize: 12, color: ArcadeColors.textDim),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Quest Summary
          Text(
            locale.isId ? exp.summaryId : exp.summaryEn,
            style: AppTheme.body(fontSize: 13.5, color: ArcadeColors.textMain),
          ),
          const SizedBox(height: 16),

          // Key Accomplishments (Bullet points)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in (locale.isId ? exp.bulletPointsId : exp.bulletPointsEn))
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("▶ ", style: TextStyle(color: ArcadeColors.neonCyan, fontSize: 10)),
                      Expanded(
                        child: Text(
                          point,
                          style: AppTheme.body(fontSize: 12.5, color: ArcadeColors.textDim),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // If featured project showcase exists (e.g. PT Kayaba Automated Approval Workflow)
          if (exp.showcase != null) ...[
            const SizedBox(height: 20),
            _buildProjectShowcase(context, exp.showcase!, isDesktop),
          ],

          const SizedBox(height: 20),

          // Tech Stack Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tech in exp.techStack)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ArcadeColors.backgroundCardElevated,
                    border: Border.all(color: ArcadeColors.neonCyan.withValues(alpha: 0.5), width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tech,
                    style: AppTheme.pixel(fontSize: 7.5, color: ArcadeColors.neonCyan),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectShowcase(BuildContext context, ProjectShowcase showcase, bool isDesktop) {
    final locale = LocaleController.instance;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ArcadeColors.backgroundCard,
        border: Border.all(color: ArcadeColors.scoreYellow.withValues(alpha: 0.6), width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_tree, color: ArcadeColors.scoreYellow, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  locale.isId ? showcase.titleId : showcase.titleEn,
                  style: AppTheme.pixel(
                    fontSize: 10,
                    color: ArcadeColors.scoreYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            locale.isId ? showcase.descriptionId : showcase.descriptionEn,
            style: AppTheme.body(fontSize: 12, color: ArcadeColors.textDim),
          ),
          const SizedBox(height: 14),

          // Workflow Matrix Diagram
          Text(
            locale.isId ? "DIAGRAM ALUR PERSETUJUAN (RBAC ENGINE):" : "APPROVAL WORKFLOW RULES (RBAC):",
            style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.neonCyan),
          ),
          const SizedBox(height: 8),
          for (final step in showcase.approvalSteps)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF141C36),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: ArcadeColors.borderPixel, width: 1),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(
                        step.condition,
                        style: AppTheme.pixel(fontSize: 7.5, color: ArcadeColors.scoreYellow),
                      ),
                    ),
                    const Text("➜ ", style: TextStyle(color: ArcadeColors.neonCyan, fontSize: 12)),
                    Expanded(
                      child: Text(
                        locale.isId ? step.approversId : step.approversEn,
                        style: AppTheme.body(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
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
