import 'package:flutter/material.dart';
import '../app/app_theme.dart';
import '../app/localization.dart';
import '../widgets/hud_navbar.dart';
import '../widgets/starfield_background.dart';
import 'game/space_shooter_widget.dart';
import 'sections/about_section.dart';
import 'sections/certifications_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/skills_section.dart';

class PortfolioShell extends StatefulWidget {
  const PortfolioShell({super.key});

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _expKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _certsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  int _activeNavIndex = 0;
  bool _isGameActive = false;

  void _scrollToSection(int index) {
    setState(() => _activeNavIndex = index);

    final keys = [_heroKey, _aboutKey, _expKey, _skillsKey, _certsKey, _contactKey];
    if (index >= 0 && index < keys.length) {
      final context = keys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  void _openGame() {
    setState(() => _isGameActive = true);
  }

  void _closeGame() {
    setState(() => _isGameActive = false);
  }

  @override
  Widget build(BuildContext context) {
    final locale = LocaleController.instance;

    return AnimatedBuilder(
      animation: locale,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: ArcadeColors.background,
          appBar: HudNavbar(
            activeIndex: _activeNavIndex,
            onNavItemSelected: _scrollToSection,
            onStartGamePressed: _openGame,
          ),
          endDrawer: _buildMobileDrawer(context),
          body: Stack(
            children: [
              // Animated Stars Parallax Background
              StarfieldBackground(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(key: _heroKey, child: HeroSection(
                        onStartGame: _openGame,
                        onViewProfile: () => _scrollToSection(1),
                      )),
                      const SizedBox(height: 20),
                      Container(key: _aboutKey, child: const AboutSection()),
                      const SizedBox(height: 20),
                      Container(key: _expKey, child: const ExperienceSection()),
                      const SizedBox(height: 20),
                      Container(key: _skillsKey, child: const SkillsSection()),
                      const SizedBox(height: 20),
                      Container(key: _certsKey, child: const CertificationsSection()),
                      const SizedBox(height: 20),
                      Container(key: _contactKey, child: const ContactSection()),
                    ],
                  ),
                ),
              ),

              // Full Screen Interactive 2D Space Shooter Overlay
              if (_isGameActive)
                Positioned.fill(
                  child: SpaceShooterWidget(
                    isFullScreen: true,
                    onExit: _closeGame,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    final locale = LocaleController.instance;

    return Drawer(
      backgroundColor: ArcadeColors.backgroundCard,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "YUSUF.SANJAYA",
                style: AppTheme.pixel(fontSize: 12, color: ArcadeColors.neonCyan),
              ),
            ),
            const Divider(color: ArcadeColors.borderPixel),
            _buildDrawerTile(locale.navHome, 0, Icons.home),
            _buildDrawerTile(locale.navAbout, 1, Icons.person),
            _buildDrawerTile(locale.navExperience, 2, Icons.work),
            _buildDrawerTile(locale.navSkills, 3, Icons.bolt),
            _buildDrawerTile(locale.navCertifications, 4, Icons.military_tech),
            _buildDrawerTile(locale.navContact, 5, Icons.mail),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ArcadeColors.terminalGreen,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  icon: const Icon(Icons.sports_esports, color: Colors.black),
                  label: Text(
                    locale.playMiniGame,
                    style: AppTheme.pixel(fontSize: 9, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _openGame();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(String title, int index, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: ArcadeColors.neonCyan, size: 20),
      title: Text(
        title,
        style: AppTheme.pixel(fontSize: 9, color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context).pop();
        _scrollToSection(index);
      },
    );
  }
}
