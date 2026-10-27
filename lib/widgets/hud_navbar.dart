import 'package:flutter/material.dart';
import '../app/app_theme.dart';
import '../app/audio_controller.dart';
import '../app/localization.dart';

class HudNavbar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavItemSelected;
  final int activeIndex;
  final VoidCallback onStartGamePressed;

  const HudNavbar({
    super.key,
    required this.onNavItemSelected,
    required this.activeIndex,
    required this.onStartGamePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final locale = LocaleController.instance;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xE6090D16),
        border: Border(
          bottom: BorderSide(color: ArcadeColors.borderPixel, width: 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Retro Logo / Player Tag
          InkWell(
            onTap: () => onNavItemSelected(0),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  color: ArcadeColors.neonCyan,
                ),
                const SizedBox(width: 8),
                Text(
                  "YUSUF.SANJAYA",
                  style: AppTheme.pixel(
                    fontSize: 12,
                    color: ArcadeColors.neonCyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Desktop HUD Menus
          if (isDesktop) ...[
            _buildNavItem(locale.navHome, 0),
            _buildNavItem(locale.navAbout, 1),
            _buildNavItem(locale.navExperience, 2),
            _buildNavItem(locale.navSkills, 3),
            _buildNavItem(locale.navCertifications, 4),
            _buildNavItem(locale.navContact, 5),
            const SizedBox(width: 12),
          ],

          // Play Game Action Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: ArcadeColors.cyberAmber.withValues(alpha: 0.15),
              foregroundColor: ArcadeColors.cyberAmber,
              side: const BorderSide(color: ArcadeColors.cyberAmber, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            icon: const Icon(Icons.videogame_asset, size: 16),
            label: Text(
              "PLAY",
              style: AppTheme.pixel(fontSize: 9, color: ArcadeColors.cyberAmber),
            ),
            onPressed: () {
              AudioController.instance.click();
              onStartGamePressed();
            },
          ),
          const SizedBox(width: 10),

          // Bilingual Toggle (ID / EN)
          AnimatedBuilder(
            animation: locale,
            builder: (context, _) {
              return TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  side: const BorderSide(color: ArcadeColors.neonCyan, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                ),
                onPressed: () {
                  AudioController.instance.click();
                  locale.toggleLanguage();
                },
                child: Text(
                  locale.isId ? "ID" : "EN",
                  style: AppTheme.pixel(fontSize: 9, color: ArcadeColors.neonCyan),
                ),
              );
            },
          ),
          const SizedBox(width: 8),

          // Sound Toggle Button
          AnimatedBuilder(
            animation: AudioController.instance,
            builder: (context, _) {
              final isEnabled = AudioController.instance.isEnabled;
              return IconButton(
                icon: Icon(
                  isEnabled ? Icons.volume_up : Icons.volume_off,
                  color: isEnabled ? ArcadeColors.successGreen : Colors.grey,
                  size: 20,
                ),
                tooltip: isEnabled ? locale.soundOn : locale.soundOff,
                onPressed: () => AudioController.instance.toggleMute(),
              );
            },
          ),

          // Mobile Drawer Hamburger
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: ArcadeColors.textMain),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index) {
    final isSelected = activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () {
          AudioController.instance.click();
          onNavItemSelected(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? ArcadeColors.neonCyan.withValues(alpha: 0.15) : Colors.transparent,
            border: Border.all(
              color: isSelected ? ArcadeColors.neonCyan : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: AppTheme.pixel(
              fontSize: 9,
              color: isSelected ? ArcadeColors.neonCyan : ArcadeColors.textDim,
            ),
          ),
        ),
      ),
    );
  }
}
