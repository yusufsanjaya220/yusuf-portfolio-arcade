import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/audio_controller.dart';
import '../../app/localization.dart';
import '../../data/models.dart';
import '../../data/profile_data.dart';
import '../../widgets/pixel_container.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String selectedCategoryId = "all";

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final locale = LocaleController.instance;

    final categories = ProfileData.skillCategories;
    final displayedCategories = selectedCategoryId == "all"
        ? categories
        : categories.where((c) => c.id == selectedCategoryId).toList();

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
                title: locale.navSkills,
                subtitle: locale.isId
                    ? "Pohon Keahlian & Tingkat Kemahiran Teknis"
                    : "Technical Skill Tree & Level Proficiencies",
              ),
              const SizedBox(height: 24),

              // Category Filter Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                      label: locale.isId ? "SEMUA" : "ALL",
                      id: "all",
                      isSelected: selectedCategoryId == "all",
                    ),
                    ...categories.map((cat) {
                      return _buildFilterChip(
                        label: locale.isId ? cat.titleId : cat.titleEn,
                        id: cat.id,
                        isSelected: selectedCategoryId == cat.id,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Categories & Skill Cards
              ...displayedCategories.map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(cat.icon, color: ArcadeColors.neonCyan, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            locale.isId ? cat.titleId.toUpperCase() : cat.titleEn.toUpperCase(),
                            style: AppTheme.pixel(
                              fontSize: 11,
                              color: ArcadeColors.neonCyan,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Grid of skills in this category
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final crossAxisCount = constraints.maxWidth >= 720 ? 2 : 1;
                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: cat.skills.map((skill) {
                              final itemWidth = crossAxisCount == 2
                                  ? (constraints.maxWidth - 16) / 2
                                  : constraints.maxWidth;
                              return SizedBox(
                                width: itemWidth,
                                child: _buildSkillCard(skill),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String id,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          AudioController.instance.click();
          setState(() => selectedCategoryId = id);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? ArcadeColors.terminalGreen : ArcadeColors.backgroundCardElevated,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isSelected ? ArcadeColors.matrixGreen : ArcadeColors.borderPixel,
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            style: AppTheme.pixel(
              fontSize: 8,
              color: isSelected ? Colors.black : ArcadeColors.textDim,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(SkillItem skill) {
    final locale = LocaleController.instance;

    return PixelContainer(
      padding: const EdgeInsets.all(14),
      borderColor: ArcadeColors.borderPixel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  skill.name,
                  style: AppTheme.body(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "LVL ${skill.level}/5",
                style: AppTheme.pixel(fontSize: 8, color: ArcadeColors.scoreYellow),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 5-block Retro Segmented Progress Bar
          Row(
            children: List.generate(5, (index) {
              final isFilled = index < skill.level;
              return Expanded(
                child: Container(
                  height: 8,
                  margin: EdgeInsets.only(right: index < 4 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: isFilled ? ArcadeColors.neonCyan : const Color(0xFF161F38),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          Text(
            locale.isId ? skill.noteId : skill.noteEn,
            style: AppTheme.body(fontSize: 11.5, color: ArcadeColors.textDim),
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
